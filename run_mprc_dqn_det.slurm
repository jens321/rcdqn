#!/bin/bash -l

##############################
#       Job blueprint        #
##############################

# Give your job a name, so you can recognize it in the queue overview
#SBATCH --job-name=mprc_dqn

# Remove one # to uncommment
#SBATCH --output=slurm_output/%x-%j.txt

# Define, how many nodes you need. Here, we ask for 1 node.
#SBATCH -N 1 #nodes
#SBATCH -n 1 #tasks
#SBATCH --cpus-per-task=16
#SBATCH --mem=15G
#SBATCH --time=1-23:59:00   
#SBATCH --gres=gpu:1 
#SBATCH -w node031

# Turn on mail notification. There are many possible self-explaining values:
# NONE, BEGIN, END, FAIL, ALL (including all aforementioned)
# For more values, check "man sbatch"
#SBATCH --mail-type=NONE
# Remember to set your email address here instead of nobody
#SBATCH --mail-user=jtuyls@cs.princeton.edu


# Define and create a unique scratch directory for this job
#tag="transformer";
#OUT_DIRECTORY='output/'${tag}
#mkdir ${OUT_DIRECTORY};

# Submit jobs.
version=4

module purge
eval "$(conda shell.bash hook)"
if [ ${2} = "zork1.z5" ]; then
    echo "activating drrn-shunyu-fast"
    conda activate drrn-shunyu-fast
elif [ ${4} = "add_wt" ]; then
    echo "activating jericho-wt"
    conda activate jericho-wt
elif [ ${4} = "no_add_wt" ]; then 
    echo "activating jericho-no-wt"
    conda activate jericho-no-wt
elif [ ${4} = "mprc_dqn" ]; then 
    echo "activating mprc dqn"
    conda activate mprc-dqn
else
    echo "Unrecognized wt type!"
    exit 1
fi

export WANDB_TAGS=$SLURM_JOB_ID,cpus:16

python3 train.py --env_id ${2} \
                 --batch_size 64 \
                 --env_seed ${3} \
                 --seed ${3} \
                 --project_name "iclr-text-games" \
                 --jericho_add_wt ${4} \
                 --log_dir logs/debug-original-jericho-${1}

# python3 train.py --env_id dragon.z5 \
#                  --batch_size 64 \
#                  --env_seed 0 \
#                  --seed 0 \
#                  --project_name "iclr-text-games" \
#                  --jericho_add_wt add_wt \
#                  --log_dir logs/mprc-dqn-pdb-debug

wait; #Make sure to wait till all the runs have completed.

# Finish the script
exit 0

