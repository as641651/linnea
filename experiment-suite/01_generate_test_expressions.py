import random
import shutil
import os
from linnea.examples.random_expressions import generate_equation
import linnea.examples.application as lapp

import linnea.config

#NUM_APP_EXAMPLES = 25
#NUM_RANDOM_EXAMPLES = 100
NUM_APP_EXAMPLES = 2
NUM_RANDOM_EXAMPLES = 2

test_expressions_folder = "test_expressions_sample"
if os.path.exists(test_expressions_folder):
    shutil.rmtree(test_expressions_folder)

linnea.config.set_output_code_path(test_expressions_folder)
linnea.config.set_generate_graph(True)
linnea.config.init()

from linnea.derivation.graph.derivation import DerivationGraph

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


def generate_code(id, equations):
    graph = DerivationGraph(equations)
    graph.derivation(time_limit=10,
                     merging=True,
                     dead_ends=True,
                     pruning_factor=1.5)

    graph.write_output(code=True,
                       derivation=True,
                       output_name=id,
                       experiment_code=True,
                       algorithms_limit=100,
                       graph=True)

for id,expr in eqns.items():
    generate_code(id,expr)
