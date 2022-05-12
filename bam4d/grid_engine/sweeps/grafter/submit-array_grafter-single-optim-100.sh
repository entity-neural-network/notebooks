#!/bin/sh
#$ -cwd
#$ -pe smp 8
#$ -l h_vmem=11G
#$ -N grafter-single-optim-100
#$ -l gpu=1
#$ -l gpu_type=ampere
#$ -l cluster=andrena
#$ -l h_rt=6:0:0
#$ -t 1-10
#$ -o logs/
#$ -e logs/

env_id_values=( GDY-Grafter-Single-100 )
name_values=( grafter-single-optim-100 )
track_values=( True )
seed_values=( 0 1 2 3 4 5 6 7 8 9 )
total_timesteps_values=( 10000000 )
data_dir_values=( /data/scratch/acw434/grafter-single-optim-100 )
rollout_processes_values=( 8 )
rollout_num_envs_values=( 256 )
rollout_steps_values=( 64 )
optim_bs_values=( 8192 )
optim_lr_values=( 0.005 )
ppo_ent_coef_values=( 0.01 )
eval_interval_values=( 100000 )
eval_steps_values=( 10000 )
eval_num_envs_values=( 1 )
eval_processes_values=( 1 )
eval_capture_videos_values=( True )
trial=${SGE_TASK_ID}
env_id="${env_id_values[$(( trial % ${#env_id_values[@]} ))]}"
trial=$(( trial / ${#env_id_values[@]} ))
name="${name_values[$(( trial % ${#name_values[@]} ))]}"
trial=$(( trial / ${#name_values[@]} ))
track="${track_values[$(( trial % ${#track_values[@]} ))]}"
trial=$(( trial / ${#track_values[@]} ))
seed="${seed_values[$(( trial % ${#seed_values[@]} ))]}"
trial=$(( trial / ${#seed_values[@]} ))
total_timesteps="${total_timesteps_values[$(( trial % ${#total_timesteps_values[@]} ))]}"
trial=$(( trial / ${#total_timesteps_values[@]} ))
data_dir="${data_dir_values[$(( trial % ${#data_dir_values[@]} ))]}"
trial=$(( trial / ${#data_dir_values[@]} ))
rollout_processes="${rollout_processes_values[$(( trial % ${#rollout_processes_values[@]} ))]}"
trial=$(( trial / ${#rollout_processes_values[@]} ))
rollout_num_envs="${rollout_num_envs_values[$(( trial % ${#rollout_num_envs_values[@]} ))]}"
trial=$(( trial / ${#rollout_num_envs_values[@]} ))
rollout_steps="${rollout_steps_values[$(( trial % ${#rollout_steps_values[@]} ))]}"
trial=$(( trial / ${#rollout_steps_values[@]} ))
optim_bs="${optim_bs_values[$(( trial % ${#optim_bs_values[@]} ))]}"
trial=$(( trial / ${#optim_bs_values[@]} ))
optim_lr="${optim_lr_values[$(( trial % ${#optim_lr_values[@]} ))]}"
trial=$(( trial / ${#optim_lr_values[@]} ))
ppo_ent_coef="${ppo_ent_coef_values[$(( trial % ${#ppo_ent_coef_values[@]} ))]}"
trial=$(( trial / ${#ppo_ent_coef_values[@]} ))
eval_interval="${eval_interval_values[$(( trial % ${#eval_interval_values[@]} ))]}"
trial=$(( trial / ${#eval_interval_values[@]} ))
eval_steps="${eval_steps_values[$(( trial % ${#eval_steps_values[@]} ))]}"
trial=$(( trial / ${#eval_steps_values[@]} ))
eval_num_envs="${eval_num_envs_values[$(( trial % ${#eval_num_envs_values[@]} ))]}"
trial=$(( trial / ${#eval_num_envs_values[@]} ))
eval_processes="${eval_processes_values[$(( trial % ${#eval_processes_values[@]} ))]}"
trial=$(( trial / ${#eval_processes_values[@]} ))
eval_capture_videos="${eval_capture_videos_values[$(( trial % ${#eval_capture_videos_values[@]} ))]}"

module purge
module load cuda anaconda3 vulkan-sdk
conda activate conda_poetry_base

export PYTHONUNBUFFERED=1

OMP_NUM_THREADS=1

# Set up poetry
cd ~/enn/incubator
poetry shell

python ~/enn/incubator/enn_zoo/enn_zoo/train.py  env.id="${env_id}" name="${name}" track="${track}" seed="${seed}" total_timesteps="${total_timesteps}" data_dir="${data_dir}" rollout.processes="${rollout_processes}" rollout.num_envs="${rollout_num_envs}" rollout.steps="${rollout_steps}" optim.bs="${optim_bs}" optim.lr="${optim_lr}" ppo.ent_coef="${ppo_ent_coef}" eval.interval="${eval_interval}" eval.steps="${eval_steps}" eval.num_envs="${eval_num_envs}" eval.processes="${eval_processes}" eval.capture_videos="${eval_capture_videos}"