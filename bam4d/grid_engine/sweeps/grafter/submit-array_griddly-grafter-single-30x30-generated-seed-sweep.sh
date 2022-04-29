#!/bin/sh
#$ -cwd
#$ -pe smp 8
#$ -l h_vmem=11G
#$ -N griddly-grafter-single-30x30-generated-seed-sweep
#$ -l gpu=1
#$ -l gpu_type=ampere
#$ -l cluster=andrena
#$ -l h_rt=6:0:0
#$ -t 1-108
#$ -o logs/
#$ -e logs/

env.id_values=( GDY-Grafter-single-30 )
name_values=( griddly-grafter-single-30x30-generated-seed-sweep )
track_values=( True )
seed_values=( 0 1 2 )
total_timesteps_values=( 5000000 )
data_dir_values=( /data/scratch/acw434/griddly-grafter-single-30x30-generated-seed-sweep )
rollout.processes_values=( 8 )
rollout.num_envs_values=( 1024 2048 )
rollout.steps_values=( 128 256 )
ppo.lr_values=( 0.005 0.001 0.0005 )
ppo.ent_coef_values=( 0.2 0.1 0.05 )
eval.interval_values=( 100000 )
eval.steps_values=( 500 )
eval.num_env_values=( 1 )
eval.processes_values=( 1 )
eval.capture_videos_values=( True )
trial=${SGE_TASK_ID}
env.id="${env.id_values[$(( trial % ${#env.id_values[@]} ))]}"
trial=$(( trial / ${#env.id_values[@]} ))
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
rollout.processes="${rollout.processes_values[$(( trial % ${#rollout.processes_values[@]} ))]}"
trial=$(( trial / ${#rollout.processes_values[@]} ))
rollout.num_envs="${rollout.num_envs_values[$(( trial % ${#rollout.num_envs_values[@]} ))]}"
trial=$(( trial / ${#rollout.num_envs_values[@]} ))
rollout.steps="${rollout.steps_values[$(( trial % ${#rollout.steps_values[@]} ))]}"
trial=$(( trial / ${#rollout.steps_values[@]} ))
ppo.lr="${ppo.lr_values[$(( trial % ${#ppo.lr_values[@]} ))]}"
trial=$(( trial / ${#ppo.lr_values[@]} ))
ppo.ent_coef="${ppo.ent_coef_values[$(( trial % ${#ppo.ent_coef_values[@]} ))]}"
trial=$(( trial / ${#ppo.ent_coef_values[@]} ))
eval.interval="${eval.interval_values[$(( trial % ${#eval.interval_values[@]} ))]}"
trial=$(( trial / ${#eval.interval_values[@]} ))
eval.steps="${eval.steps_values[$(( trial % ${#eval.steps_values[@]} ))]}"
trial=$(( trial / ${#eval.steps_values[@]} ))
eval.num_env="${eval.num_env_values[$(( trial % ${#eval.num_env_values[@]} ))]}"
trial=$(( trial / ${#eval.num_env_values[@]} ))
eval.processes="${eval.processes_values[$(( trial % ${#eval.processes_values[@]} ))]}"
trial=$(( trial / ${#eval.processes_values[@]} ))
eval.capture_videos="${eval.capture_videos_values[$(( trial % ${#eval.capture_videos_values[@]} ))]}"

module purge
module load cuda anaconda3 vulkan-sdk
conda activate conda_poetry_base

export PYTHONUNBUFFERED=1

# Set up poetry
cd ~/enn/incubator
poetry shell

python ~/enn/incubator/enn_zoo/enn_zoo/train.py  env.id="${env.id}" name="${name}" track="${track}" seed="${seed}" total_timesteps="${total_timesteps}" data_dir="${data_dir}" rollout.processes="${rollout.processes}" rollout.num_envs="${rollout.num_envs}" rollout.steps="${rollout.steps}" ppo.lr="${ppo.lr}" ppo.ent-coef="${ppo.ent_coef}" eval.interval="${eval.interval}" eval.steps="${eval.steps}" eval.num_env="${eval.num_env}" eval.processes="${eval.processes}" eval.capture-videos="${eval.capture_videos}"