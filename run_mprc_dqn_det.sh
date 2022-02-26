#!/bin/bash
# HIGH CUDA
# GAMES="zork1.z5 dragon.z5"

# LOW CUDA
GAMES="detective.z5 omniquest.z5 inhumane.z5 ludicorp.z5 zork3.z5 pentari.z5 balances.z5 library.z5 deephome.z5 enchanter.z3"
SEEDS=(0 1 2)

for seed in ${SEEDS[@]}
do
    for game in ${GAMES} 
    do
        sbatch -A pnlp --job-name=mprc_dqn_det_${game} run_mprc_dqn_det.slurm mprc_dqn_${game} ${game} ${seed} &
    done;
done;