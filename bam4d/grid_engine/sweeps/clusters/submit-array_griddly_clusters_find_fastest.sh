#!/bin/sh
#$ -cwd
#$ -pe smp 8
#$ -l h_vmem=11G
#$ -N griddly_clusters_find_fastest
#$ -l gpu=1
#$ -l gpu_type=ampere
#$ -l cluster=andrena
#$ -l h_rt=1:0:0
#$ -t 1-26
#$ -o logs/
#$ -e logs/

gym_id_values=( GDY-Clusters-0 )
exp_name_values=( griddly_clusters_find_fastest )
track_values=( True )
total_timesteps_values=( 2000000 )
processes_values=( 8 )
num_envs_values=( 1024 2048 4096 )
num_steps_values=( 128 256 512 )
num_minibatches_values=( 16 32 64 )
learning_rate_values=( 0.005 )
ent_coef_values=( 0.2 )
data_dir_values=( /data/scratch/acw434/griddly_clusters_find_fastest )
trial=${SGE_TASK_ID}
gym_id=${gym_id_values[$(( trial % ${#gym_id_values[@]} ))]}
trial=$(( trial / ${#gym_id_values[@]} ))
exp_name=${exp_name_values[$(( trial % ${#exp_name_values[@]} ))]}
trial=$(( trial / ${#exp_name_values[@]} ))
track=${track_values[$(( trial % ${#track_values[@]} ))]}
trial=$(( trial / ${#track_values[@]} ))
total_timesteps=${total_timesteps_values[$(( trial % ${#total_timesteps_values[@]} ))]}
trial=$(( trial / ${#total_timesteps_values[@]} ))
processes=${processes_values[$(( trial % ${#processes_values[@]} ))]}
trial=$(( trial / ${#processes_values[@]} ))
num_envs=${num_envs_values[$(( trial % ${#num_envs_values[@]} ))]}
trial=$(( trial / ${#num_envs_values[@]} ))
num_steps=${num_steps_values[$(( trial % ${#num_steps_values[@]} ))]}
trial=$(( trial / ${#num_steps_values[@]} ))
num_minibatches=${num_minibatches_values[$(( trial % ${#num_minibatches_values[@]} ))]}
trial=$(( trial / ${#num_minibatches_values[@]} ))
learning_rate=${learning_rate_values[$(( trial % ${#learning_rate_values[@]} ))]}
trial=$(( trial / ${#learning_rate_values[@]} ))
ent_coef=${ent_coef_values[$(( trial % ${#ent_coef_values[@]} ))]}
trial=$(( trial / ${#ent_coef_values[@]} ))
data_dir=${data_dir_values[$(( trial % ${#data_dir_values[@]} ))]}

export OMP_NUM_THREADS=1

module purge
module load cuda anaconda3 vulkan-sdk
conda activate conda_poetry_base

export PYTHONUNBUFFERED=1

# Set up poetry
cd ~/enn/incubator
poetry shell

python ~/enn/incubator/enn_ppo/enn_ppo/train.py  --gym-id=${gym_id} --exp-name=${exp_name} --track=${track} --total-timesteps=${total_timesteps} --processes=${processes} --num-envs=${num_envs} --num-steps=${num_steps} --num-minibatches=${num_minibatches} --learning-rate=${learning_rate} --ent-coef=${ent_coef} --data-dir=${data_dir}