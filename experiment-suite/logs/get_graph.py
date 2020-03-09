import csv
import pandas as pd
import numpy as np

filename = "plot/combined_t24_k_best_stats_min_time.csv"
#
input = pd.read_csv(filename,sep=";")


#print(list(input.columns))
SU = 1.2
henriks_list = list(input[input.speedup > SU].example)

#print(input.speedup)

mylist = []
speedups = []
speedups_filtered = []
mylog = "run3/Analysis/analysis_0.9_2_30.txt"
#mylog = "run3/Analysis/analysis_0.5_18_1.txt"
f = open(mylog)
lines = f.readlines()
start = True
for line in lines:
    if "#Num SAME FLOPS" in line:
        start = True
    if "#" not in line and start:
        data = line.split()[0]
        name = data.split("/")[-1].lower()
        id = int(name.split("_")[-1])
        if "random" in name:
            id = id+1
        id = str(object=id).zfill(3)
        mylist.append(name.split("_")[0]+id)
        su = float(line.split()[-1])
        speedups.append(su)
        if su>SU or SU==1.0:
            speedups_filtered.append(su)

#print(mylist)

print("\nHenriks Match with mine")

match = 0
for example in henriks_list:
    if example not in mylist:
        print(example, "NOT MATCH",input.loc[input["example"]==example]["speedup"].values[0])
    else:
        print(example, "MATCH", input[input["example"]==example].speedup.values[0])
        match += 1
print("\nhenriks list ", len(henriks_list))
print("speedups my list ", len(speedups))
print("Num matches : {}/{}".format(match,len(henriks_list)))

print("\nMy Match with Henrik")
match = 0
for example,speedup in zip(mylist,speedups):
    if speedup > SU or SU==1.0:
        if example not in henriks_list:
            print(example, "NOT MATCH",speedup,input[input["example"]==example].speedup.values[0])
        else:
            print(example, "MATCH", speedup,input[input["example"]==example].speedup.values[0])
            match += 1

print("\nhenriks list ", len(henriks_list))
print("speedups my list ", len(speedups_filtered))
print("Num matches : {}/{}".format(match,len(speedups_filtered)))
# with open( filename, 'r' ) as theFile:
#     reader = csv.DictReader(theFile)
#     for line in reader:
#         # line is { 'workers': 'w0', 'constant': 7.334, 'age': -1.406, ... }
#         # e.g. print( line[ 'workers' ] ) yields 'w0'
#         print(line.keys())

# f = open(filename,"r",encoding="utf-8", errors="ignore")
#
# lines = f.readlines()
#
# for line in lines:
#     print(line.split(";"):)
#
# f.close()
