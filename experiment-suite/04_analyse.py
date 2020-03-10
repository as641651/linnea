import json
import random
import numpy as np
import sys
import os
import argparse

class ComparisionsContainer:
    def __init__(self):
        self.data = {}

    def apply_correction(self,key1,key2,val):
        if(int(key1)>int(key2)):
            key1,key2 = key2,key1
            if val==2:
                val=0
            elif val==0:
                val=2
        return [key1,key2,val]

    def add_data(self,key1,key2,val):
        key1,key2,val = self.apply_correction(key1,key2,val)
        if not key1 in self.data:
            self.data[key1] = {}
        self.data[key1][key2] = val

    def get_data(self,key1, key2):
        k1,k2 = sorted([key1,key2])
        val = self.data[k1][k2]
        _,_,val = self.apply_correction(key1,key2,val)
        return val

    def get_data_dict(self,key):
        ret = self.data[key]
        for k,v in self.data.items():
            if key in v.keys():
                val = self.data[k][key]
                _,_,ret[k] = self.apply_correction(key,k,val)

        return ret


def compare(a,b,stat,thresh):
    c=0

    for i in range(R):
        ma = random.sample(a,M)
        mb = random.sample(b,M)
        if(stat(mb)<stat(ma)):
            c = c+1
    p = float(c)/float(R)

    ret = 1
    if(p>thresh):
        ret = 2
    elif(p<(1-thresh)):
        ret = 0

    return ret


def bubbleSort(data):
    arr = np.array(list(range(len(data))))
    n = len(arr)
    rank_arr = np.array(list(range(1,n+1)))

    container = ComparisionsContainer()
    # Traverse through all array elements
    for i in range(n):
        # Last i elements are already in place
        for j in range(0, n-i-1):
            # traverse the array from 0 to n-i-1
            # Swap if the element found is greater
            # than the next element
            a_key = [str(arr[j]).zfill(3),str(arr[j+1]).zfill(3)]
            try:
                ret = container.get_data(a_key[0],a_key[1])
            except KeyError:
                ret = compare(data[str(arr[j])], data[str(arr[j+1])],np.min,THRESH)
                container.add_data(a_key[0],a_key[1],ret)

            if ret == 2:
                arr[j], arr[j+1] = arr[j+1], arr[j]
                if rank_arr[j+1] == rank_arr[j]:
                    if j!=0:
                        if rank_arr[j-1]!=rank_arr[j]:
                            rank_arr[j+1:] = rank_arr[j+1:]+1
                    else:
                        rank_arr[j+1:] = rank_arr[j+1:]+1
                else:
                    if j!=0:
                        if rank_arr[j-1]==rank_arr[j]:
                            rank_arr[j+1:] = rank_arr[j+1:]-1

            if ret == 1:
                if rank_arr[j+1] != rank_arr[j]:
                    rank_arr[j+1] = rank_arr[j]
                    rank_arr[j+2:] = rank_arr[j+2:]-1


    return list(zip(arr,rank_arr))

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

class NpEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, np.integer):
            return int(obj)
        elif isinstance(obj, np.floating):
            return float(obj)
        elif isinstance(obj, np.ndarray):
            return obj.tolist()
        else:
            return super(NpEncoder, self).default(obj)

if __name__ == "__main__":

    parser = argparse.ArgumentParser()
    parser.add_argument('file')
    parser.add_argument('-m', default=4)
    parser.add_argument('-r', default=30)
    parser.add_argument('-t', default=0.9)
    params = parser.parse_args()
    M = int(params.m)
    R = int(params.r)
    THRESH = float(params.t)
    THRESH_SET = [THRESH-0.1, THRESH-0.05,THRESH]
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


    #bubbleSort(data["test_expressions_results/Random_83"])
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

    rankings = {}

    cases_sf = []
    cases_df = []
    for k in data.keys():
        if k in missing:
            continue

        results = bubbleSort(data[k])
        rankings[k] = results
        rank1_algs = []
        for x in results:
            if x[1]==1:
                rank1_algs.append(x[0])
            else:
                break
        best_alg_id = rank1_algs[0]


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

    out_file = "2analysis_"+str(object=THRESH)+"_"+str(object=M)+"_"+str(object=R)+".txt"
    f = open(os.path.join(RESULT_FOLDER_BASE,"Analysis/"+out_file),"w")
    f.write(out)
    f.close()

    rank_file = "Rank_2analysis_"+str(object=THRESH)+"_"+str(object=M)+"_"+str(object=R)+".json"
    fj = open(os.path.join(RESULT_FOLDER_BASE,"Analysis/"+rank_file),"w")
    json.dump(rankings,fj,cls=NpEncoder)
    jf.close()
