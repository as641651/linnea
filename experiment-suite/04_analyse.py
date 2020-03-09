import json
import random
import numpy as np
import sys
import os
import argparse


def compare(a,b,stat,thresh):
    c=0

    for i in range(R):
        ma = random.sample(a,M)
        mb = random.sample(b,M)
        if(stat(mb)<stat(ma)):
            c = c+1
    p = float(c)/float(R)

    ret = 0
    if(p>thresh):
        ret = 2
    elif(p<(1-thresh)):
        ret = 1

    return ret

def check_completeness(data,reps):
    missing = []

    for k,v in data.items():
        if len(v) == 0:
            missing.append(k)
        for k2,v2 in v.items():
            if len(v2)<reps:
                missing.append(k)
                break

    return missing

if __name__ == "__main__":

    parser = argparse.ArgumentParser()
    parser.add_argument('file')
    parser.add_argument('-m', default=2)
    parser.add_argument('-r', default=10)
    parser.add_argument('-t', default=0.9)
    params = parser.parse_args()
    M = int(params.m)
    R = int(params.r)
    THRESH = float(params.t)
    print("Sub sample size : ", M)
    print("Repetitions : ", R)
    print("THRESHOLD : ", THRESH)
    RESULT_FOLDER_BASE = params.file

    if not os.path.exists(RESULT_FOLDER_BASE):
        print("Error: Pass results folder")
        print("Usage: python 04_analyse.py results/")
        exit(code=-1)


    data_file = os.path.join(RESULT_FOLDER_BASE,"Analysis/gathered_results.json")
    if not os.path.exists(data_file):
        print("Error: Gather results first")
        print("Usage: python 03_gather_results.py results/")
        exit(code=-1)

    with open(data_file) as jf:
        data = json.load(jf)

    compute_data_file = os.path.join(RESULT_FOLDER_BASE,"computeData.json")
    with open(compute_data_file) as jf:
        compute_data = json.load(jf)

    config_file = os.path.join(RESULT_FOLDER_BASE,"config.json")
    with open(config_file) as jf:
        configs = json.load(jf)

    missing = check_completeness(data,int(configs["num_reps"]))
    print("Incomplete Data : \n", missing)
    print("Missing Cases : ", len(missing))
    #print(data.keys())
    #random.seed(0)
    cases_sf = []
    cases_df = []
    for k in data.keys():
        if k in missing:
            continue

        N = len(data[k])
        best_alg = data[k]["0"]
        best_alg_id = 0
        for i in range(1,N):
            ret = compare(best_alg, data[k][str(i)],np.min,THRESH)
            if ret==2:
                best_alg = data[k][str(i)]
                best_alg_id = int(i)

        if(best_alg_id != 0 ):
            #print(k)
            ta = min(data[k]["0"])
            flops_a = float(compute_data["flops"][k.split("/")[-1]]["0"])
            intensity_a = float(compute_data["intensity"][k.split("/")[-1]]["0"])
            tb = min(data[k][str(best_alg_id)])
            flops_b = float(compute_data["flops"][k.split("/")[-1]][str(best_alg_id)])
            intensity_b = float(compute_data["intensity"][k.split("/")[-1]][str(best_alg_id)])
            speed_up = float(ta/tb)
            vals = [k,int(best_alg_id),flops_a, flops_b, intensity_a, intensity_b , speed_up]
            if flops_a == flops_b:
                #if speed_up >= 1.05:
                    #print(k, best_alg_id, flops_a, flops_b, speed_up )
                    cases_sf.append(vals)

            if flops_a != flops_b:
                #if speed_up >= 1.05:
                    #print(k, best_alg_id, flops_a, flops_b, speed_up )
                    cases_df.append(vals)


    cases_sf = np.array(cases_sf)
    if len(cases_sf) > 0:
        cases_sf = cases_sf[np.argsort(cases_sf[:,5])]

    cases_df = np.array(cases_df)
    if len(cases_df) > 0:
        cases_df = cases_df[np.argsort(cases_df[:,5])]

    out = "#TOTAL CASES : " + str(len(data.keys())-len(missing)) + "\n"
    out += "#SAME FLOPS\n"

    for case in cases_sf:
        out+= "{}\t{}\t{:.3e}\t{:.3e}\t{:.3e}\t{:.3e}\t{:.3f}\n".format(case[0],int(case[1]),float(case[2]),float(case[3]),float(case[4]),float(case[5]),float(case[6]))
    out += "#Num SAME FLOPS CASES : " + str(len(cases_sf)) + "\n"

    for case in cases_df:
        out+= "{}\t{}\t{:.3e}\t{:.3e}\t{:.3e}\t{:.3e}\t{:.3f}\n".format(case[0],int(case[1]),float(case[2]),float(case[3]),float(case[4]),float(case[5]),float(case[6]))
    out += "#Num DIFFERENT FLOPS CASES : " + str(len(cases_df)) + "\n"


    print(out)

    out_file = "analysis_"+str(object=THRESH)+"_"+str(object=M)+"_"+str(object=R)+".txt"
    f = open(os.path.join(RESULT_FOLDER_BASE,"Analysis/"+out_file),"w")
    f.write(out)
    f.close()
