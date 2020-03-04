import pkg_resources
import os
import random
import glob
import shutil
import json
import sys
import pprint

DEBUG_FLOPS = False

def generate_julia_runner(test_exp_folder,result_folder,id,sub_reps):

    base_folder = os.path.join(test_exp_folder, "Julia/")
    #TEMPLATE_DICT["exp_dir"] = base_folder
    operand_file = os.path.abspath(os.path.join(base_folder,"operand_generator.jl"))
    TEMPLATE_DICT["include_operand_generator"] = "include(\"{}\")".format(operand_file)

    experiment_folder = os.path.abspath(os.path.join(base_folder,"experiments"))
    algorithms = glob.glob(experiment_folder + "/*.jl")
    algorithms = [(exp.split("/")[-1].split(".")[0],exp) for exp in algorithms]
    random.shuffle(algorithms)

    include_experiment = ""
    for alg in algorithms:
        include_experiment += "include(\"{}\")\n".format(alg[1])
    TEMPLATE_DICT["include_experiments"] = include_experiment

    experiments = ""
    algorithms = algorithms*sub_reps
    for alg in algorithms:
        exp_name = alg[0]
        experiments += "\tBenchmarker.add_data(plotter, [\"{}\"; 24], Benchmarker.measure(2, {}, map(MatrixGenerator.unwrap, matrices)...) );\n".format(exp_name,exp_name)
    TEMPLATE_DICT["experiments"] = experiments

    timings_folder = os.path.abspath(os.path.join(result_folder,"timings"))
    if not os.path.exists(timings_folder):
        os.mkdir(timings_folder)
    TEMPLATE_DICT["result_file"] = os.path.join(timings_folder,"result"+str(id))

    code = RUNNER.format(**TEMPLATE_DICT)
    runner_file = os.path.join(result_folder,str(id)+"runner.jl")
    f = open(runner_file,"w")
    f.write(code)
    f.close()

    return runner_file


def get_flops(test_cases_folder):
    test_expressions = glob.glob(test_cases_folder+"/*")
    flops = {}
    for exp in test_expressions:
        key = exp.split("/")[-1]
        flops[key] = {}
        algs = glob.glob(os.path.join(exp,"Julia/k_best/")+"/*.jl")
        #print(algs)
        for alg in algs:
            cost = 0
            with open(alg) as f:
                lines = f.readlines()
                for line in lines:
                    if "cost:" in line:
                        cost = line.split("cost:")[-1].split()[0]
                        flops[key][alg.split("/")[-1].split(".")[0]] = cost

    return flops

def get_data(test_cases_folder):
    data = {}
    data["flops"] = {}
    data["bytes"] = {}
    data["intensity"] = {}

    test_expressions = glob.glob(test_cases_folder+"/*")
    for exp in test_expressions:
        key = exp.split("/")[-1]
        data["flops"][key] = {}
        data["bytes"][key] = {}
        data["intensity"][key] = {}
        with open(os.path.join(exp,"intensity.txt")) as f:
            lines = f.readlines()
            for line in lines:
                alg,bytes,cost,intensity = line.strip().split()
                data["flops"][key][alg] = cost
                data["bytes"][key][alg] = bytes
                data["intensity"][key][alg] = intensity

    return data

if __name__ == "__main__":

    try:
        with open(sys.argv[1]) as f:
            ARGV = json.load(f)
            pprint.pprint(ARGV)
    except IndexError:
        print("Error: Pass config file")
        print("Usage: python 02_generate_experiment_script.py config.json")
        exit(code=-1)


    TEMPLATE_DICT = {}
    TEMPLATE_DICT["num_threads"] = ARGV["num_threads"]
    SUB_REPS = 1
    NUM_REPS = ARGV["num_reps"]

    TEST_EXPRESSIONS_FOLDER = ARGV["test_expressions_folder"]

    try:
        RESULT_FOLDER_BASE = sys.argv[2]
    except IndexError:
        RESULT_FOLDER_BASE = ARGV["test_expressions_folder"] + "_results"

    if os.path.exists(RESULT_FOLDER_BASE) and not DEBUG_FLOPS:
        print("Removing {} ... ".format(RESULT_FOLDER_BASE))
        shutil.rmtree(RESULT_FOLDER_BASE)

    template_path = "templates/"
    RUNNER = pkg_resources.resource_string(__name__,os.path.join(template_path,"runner.jl")).decode("UTF-8")

    test_expressions = glob.glob(TEST_EXPRESSIONS_FOLDER+"/*")

    if not os.path.exists(RESULT_FOLDER_BASE):
        os.mkdir(RESULT_FOLDER_BASE)

    compute_data = get_data(TEST_EXPRESSIONS_FOLDER)
    with open(os.path.join(RESULT_FOLDER_BASE,"computeData.json"),"w") as f:
        json.dump(compute_data,f)
    if DEBUG_FLOPS:
        exit(code=-1)

    with open(os.path.join(RESULT_FOLDER_BASE,"config.json"),"w") as f:
        json.dump(ARGV,f)


    runners = []
    for test_exp_folder in test_expressions:
        expression = test_exp_folder.split("/")[-1]
        result_folder = os.path.join(RESULT_FOLDER_BASE,expression)
        if not os.path.exists(result_folder):
            os.mkdir(result_folder)
        for i in range(NUM_REPS):
            runner_file = generate_julia_runner(test_exp_folder,result_folder,i,SUB_REPS)
            runners.append(runner_file)

    random.shuffle(runners)

    if ARGV["cluster"]:
        runner_prepend = "source ~/.bashrc\n"
        julia_call = "julia "
    else:
        runner_prepend = ""
        julia_call = "/julia/julia "

    code = runner_prepend
    for exp in runners:
       code += "echo \"Running " + exp + "\"\n"
       code += julia_call+exp + " \n"
       code += "sleep 2\n\n"

    f = open("runner.sh","w")
    f.write(code)
    f.close()
