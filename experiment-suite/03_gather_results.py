import glob
import os
import json
import re


result_folder_base = "results_sample/"

analysis_folder = os.path.join(result_folder_base,"Analysis")
if not os.path.exists(analysis_folder):
    os.mkdir(analysis_folder)
gather_result_file = os.path.join(analysis_folder,"gathered_results.json")

RESULTS = {}

def dump_results(filename,expression):
    f = open(filename)
    lines = f.readlines()
    for l in lines:
        time = float(l.split('\t')[3])
        alg = l.split('\t')[0]
        alg = int(re.findall("\d+(?=algorithm)?$",alg)[0])
        try:
            RESULTS[expression][alg].append(time)
        except KeyError:
            RESULTS[expression][alg] = []
            RESULTS[expression][alg].append(time)


def gather_results(expression):
    RESULTS[expression] = {}
    timings_folder = os.path.join(expression,"timings")
    result_files = glob.glob(timings_folder+"/*_timings.txt")
    for res_file in result_files:
        dump_results(res_file,expression)



expressions = glob.glob(result_folder_base+"/*_*")
for exp in expressions:
    gather_results(exp)

#for k in sorted(RESULTS[expressions[0]]):
#    print(k)

with open(gather_result_file,'w') as outfile:
    json.dump(RESULTS,outfile)
