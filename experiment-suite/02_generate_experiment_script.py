import pkg_resources
import os
import random
import glob
import shutil

SUB_REPS = 1
NUM_REPS = 3

ARGS = {}
ARGS["num_threads"] = 24
test_cases_folder = "test_expressions_sample/"
#THIS FOLDER WILL BE REMOVED!!!
result_folder_base = "results_sample/"
if os.path.exists(result_folder_base):
    shutil.rmtree(result_folder_base)

def generate_julia_runner(test_exp_folder,result_folder,id,sub_reps):

    base_folder = os.path.join(test_exp_folder, "Julia/")
    #ARGS["exp_dir"] = base_folder
    operand_file = os.path.abspath(os.path.join(base_folder,"operand_generator.jl"))
    ARGS["include_operand_generator"] = "include(\"{}\")".format(operand_file)

    experiment_folder = os.path.abspath(os.path.join(base_folder,"experiments"))
    algorithms = glob.glob(experiment_folder + "/*.jl")
    algorithms = [(exp.split("/")[-1].split(".")[0],exp) for exp in algorithms]
    random.shuffle(algorithms)

    include_experiment = ""
    for alg in algorithms:
        include_experiment += "include(\"{}\")\n".format(alg[1])
    ARGS["include_experiments"] = include_experiment

    experiments = ""
    algorithms = algorithms*sub_reps
    for alg in algorithms:
        exp_name = alg[0]
        experiments += "\tBenchmarker.add_data(plotter, [\"{}\"; 24], Benchmarker.measure(2, {}, map(MatrixGenerator.unwrap, matrices)...) );\n".format(exp_name,exp_name)
    ARGS["experiments"] = experiments

    timings_folder = os.path.abspath(os.path.join(result_folder,"timings"))
    if not os.path.exists(timings_folder):
        os.mkdir(timings_folder)
    ARGS["result_file"] = os.path.join(timings_folder,"result"+str(id))

    code = runner.format(**ARGS)
    runner_file = os.path.join(result_folder,str(id)+"runner.jl")
    f = open(runner_file,"w")
    f.write(code)
    f.close()

    return runner_file

template_path = "templates/"
runner = pkg_resources.resource_string(__name__,os.path.join(template_path,"runner.jl")).decode("UTF-8")

test_expressions = glob.glob(test_cases_folder+"/*")

if not os.path.exists(result_folder_base):
    os.mkdir(result_folder_base)

runners = {}
for test_exp_folder in test_expressions:
    expression = test_exp_folder.split("/")[-1]
    result_folder = os.path.join(result_folder_base,expression)
    if not os.path.exists(result_folder):
        os.mkdir(result_folder)
    runners[expression] = []
    for i in range(NUM_REPS):
        runner_file = generate_julia_runner(test_exp_folder,result_folder,i,SUB_REPS)
        runners[expression].append(runner_file)

code = ""
for k,v in runners.items():
   code += "echo \"Expression " + k + "\"\n"
   for exp in v:
       code += "echo \"Running " + exp + "\"\n"
       code += "/julia/julia "+exp + " \n"
       code += "sleep 2\n\n"

f = open("runner.sh","w")
f.write(code)
f.close()
