#!/bin/bash
# WT_FAST_GAMES
# GAMES="pentari.z5 zork3.z5"
# jericho_add_wt="add_wt"

# NO_WT_FAST_GAMES
# GAMES="zork3.z5 pentari.z5"
# jericho_add_wt="no_add_wt"

# WT_SLOW_GAMES
# GAMES="deephome.z5 enchanter.z3"
# jericho_add_wt="add_wt"

# NO_WT_SLOW_GAMES
# GAMES="deephome.z5 enchanter.z3 dragon.z5"
# jericho_add_wt="no_add_wt"

# CUSTOM
GAMES="zork1.z5"
jericho_add_wt="no_add_wt"

SEEDS=(2 1 0)

for seed in ${SEEDS[@]}
do
    for game in ${GAMES} 
    do
        sbatch -A pnlp --job-name=mprc_dqn_stoch_${game} run_mprc_dqn_stoch.slurm mprc_dqn_${game} ${game} ${seed} ${jericho_add_wt} &
    done;
done;
