import random
import shutil
import os
import sys
import json
import pprint
from linnea.examples.random_expressions import generate_equation
import linnea.examples.application as lapp
import linnea.config


def generate_expressions():
    eqns = {}

    for i in range(1,NUM_APP_EXAMPLES+1):
       expr = getattr(lapp, "Example"+str(i).zfill(2))()
       eqns["Application_"+str(i).zfill(2)] = expr.eqns
       #print("Application ", i, expr.eqns)

    random.seed(0)
    rand_exprs = [generate_equation(random.randint(4, 7)) for _ in range(NUM_RANDOM_EXAMPLES)]

    for i,ex in enumerate(rand_exprs):
    	#print("Random ", i,ex)
        eqns["Random_"+str(object=i)] = ex

    return eqns


def generate_code(id, equations):
    linnea.config.clear_all()
    graph = DerivationGraph(equations)
    graph.derivation(time_limit=TIME_LIMIT,
                     merging=True,
                     dead_ends=True,
                     pruning_factor=1.5)

    graph.write_output(code=True,
                       derivation=True,
                       output_name=id,
                       experiment_code=True,
                       algorithms_limit=100,
                       graph=True,
                       no_duplicates=True)


if __name__ == "__main__":

    try:
        with open(sys.argv[1]) as f:
            ARGS = json.load(f)
            pprint.pprint(ARGS)
    except IndexError:
        print("Error: Pass config file")
        print("Usage: python 01_generate_test_expression.py config.json")
        exit(code=-1)


    NUM_APP_EXAMPLES = int(ARGS["num_app_examples"])
    NUM_RANDOM_EXAMPLES = int(ARGS["num_random_examples"])
    TEST_EXPRESSIONS_FOLDER = ARGS["test_expressions_folder"]
    TIME_LIMIT = ARGS["time_limit"]

    if os.path.exists(TEST_EXPRESSIONS_FOLDER):
        print("Removing {} ... ".format(TEST_EXPRESSIONS_FOLDER))
        shutil.rmtree(TEST_EXPRESSIONS_FOLDER)

    linnea.config.set_output_code_path(TEST_EXPRESSIONS_FOLDER)
    linnea.config.set_generate_graph(True)
    linnea.config.init()

    from linnea.derivation.graph.derivation import DerivationGraph

    eqns = generate_expressions()

    for id,expr in eqns.items():
        generate_code(id,expr)
