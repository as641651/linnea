import json
import os

base_folder = "run3/Analysis/"
json_file = "Rank_2analysis_0.99_18_1.json"

expression = "test_expressions_results/Random_99"

with open(os.path.join(base_folder,json_file)) as f:
    data = json.load(f)

print(data[expression])
