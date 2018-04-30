#!/usr/bin/env bash

#BSUB -J "linnea_time_julia[1-31]" # job name
#BSUB -o "linnea/results/execution/run_%J/cout.txt" # job output
#BSUB -W 2:00               # limits in hours:minutes
#BSUB -M 2000               # memory in MB
#BSUB -P aices2


for i in {1..31}; do
    if [ -f ${HOME}/linnea/output/lamp_example${i}c/Julia/runner.jl ]; then
        echo "File found!: ${HOME}/linnea/output/lamp_example${i}c/Julia/runner.jl"
        # ${DIR}/Julia/seed_${SEED}_matrix_chain_${i}/runner.jl > TEST_OUT_${SEED}_${i} 2>&1
    else
        echo "File not found: ${HOME}/linnea/output/lamp_example${i}c/Julia/runner.jl"
    fi
done

#exit