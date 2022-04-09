#!/bin/bash
# WT_FAST_GAMES
# GAMES="ludicorp.z5 balances.z5 inhumane.z5 pentari.z5 zork3.z5"
# jericho_add_wt="add_wt"

# NO_WT_FAST_GAMES
# GAMES="zork1.z5 inhumane.z5 ludicorp.z5 zork3.z5 pentari.z5 detective.z5 balances.z5"
# jericho_add_wt="no_add_wt"

# WT_SLOW_GAMES
# GAMES="library.z5 deephome.z5 enchanter.z3"
# jericho_add_wt="add_wt"

# NO_WT_SLOW_GAMES
# GAMES="library.z5 deephome.z5 enchanter.z3 dragon.z5"
# jericho_add_wt="no_add_wt"

# CUSTOM
GAMES="zork1.z5"
jericho_add_wt="no_add_wt"

SEEDS=(0 1 2)

for seed in ${SEEDS[@]}
do
    for game in ${GAMES} 
    do
        sbatch -A pnlp --job-name=mprc_dqn_det_${game} run_mprc_dqn_det.slurm mprc_dqn_${game} ${game} ${seed} ${jericho_add_wt} &
    done;
done;

#export LD_LIBRARY_PATH=/n/fs/nlp-jtuyls/miniconda3/lib:$LD_LIBRARY_PATH