#!/bin/sh
#$ -cwd
#$ -pe smp 8
#$ -l h_vmem=11G
#$ -N griddly-clusters-generated-seed-sweep-translation-rotation-best-hyperparams
#$ -l gpu=1
#$ -l gpu_type=ampere
#$ -l cluster=andrena
#$ -l h_rt=6:0:0
#$ -t 1-30
#$ -o logs/
#$ -e logs/

gym_id_values=( GDY-Clusters-Generated-Small GDY-Clusters-Generated-Medium GDY-Clusters-Generated-Large )
exp_name_values=( griddly-clusters-generated-seed-sweep-translation-rotation-best-hyperparams )
track_values=( True )
total_timesteps_values=( 50000000 )
processes_values=( 8 )
num_envs_values=( 1024 )
num_steps_values=( 64 )
num_minibatches_values=( 16 )
learning_rate_values=( 0.005 )
seed_values=( 0 1 2 3 4 5 6 7 8 9 )
ent_coef_values=( 0.01 )
eval_interval_values=( 1000000 )
eval_steps_values=( 500 )
eval_num_env_values=( 1 )
eval_processes_values=( 1 )
eval_capture_videos_values=( True )
translate_values=( "{\"reference_entity\": \"avatar\", \"position_features\": [\"x\", \"y\"], \"orientation_features\": [\"ox\", \"oy\"]}" )
data_dir_values=( /data/scratch/acw434/griddly-clusters-generated-seed-sweep-translation-rotation-best-hyperparams )
trial=${SGE_TASK_ID}
gym_id="${gym_id_values[$(( trial % ${#gym_id_values[@]} ))]}"
trial=$(( trial / ${#gym_id_values[@]} ))
exp_name="${exp_name_values[$(( trial % ${#exp_name_values[@]} ))]}"
trial=$(( trial / ${#exp_name_values[@]} ))
track="${track_values[$(( trial % ${#track_values[@]} ))]}"
trial=$(( trial / ${#track_values[@]} ))
total_timesteps="${total_timesteps_values[$(( trial % ${#total_timesteps_values[@]} ))]}"
trial=$(( trial / ${#total_timesteps_values[@]} ))
processes="${processes_values[$(( trial % ${#processes_values[@]} ))]}"
trial=$(( trial / ${#processes_values[@]} ))
num_envs="${num_envs_values[$(( trial % ${#num_envs_values[@]} ))]}"
trial=$(( trial / ${#num_envs_values[@]} ))
num_steps="${num_steps_values[$(( trial % ${#num_steps_values[@]} ))]}"
trial=$(( trial / ${#num_steps_values[@]} ))
num_minibatches="${num_minibatches_values[$(( trial % ${#num_minibatches_values[@]} ))]}"
trial=$(( trial / ${#num_minibatches_values[@]} ))
learning_rate="${learning_rate_values[$(( trial % ${#learning_rate_values[@]} ))]}"
trial=$(( trial / ${#learning_rate_values[@]} ))
seed="${seed_values[$(( trial % ${#seed_values[@]} ))]}"
trial=$(( trial / ${#seed_values[@]} ))
ent_coef="${ent_coef_values[$(( trial % ${#ent_coef_values[@]} ))]}"
trial=$(( trial / ${#ent_coef_values[@]} ))
eval_interval="${eval_interval_values[$(( trial % ${#eval_interval_values[@]} ))]}"
trial=$(( trial / ${#eval_interval_values[@]} ))
eval_steps="${eval_steps_values[$(( trial % ${#eval_steps_values[@]} ))]}"
trial=$(( trial / ${#eval_steps_values[@]} ))
eval_num_env="${eval_num_env_values[$(( trial % ${#eval_num_env_values[@]} ))]}"
trial=$(( trial / ${#eval_num_env_values[@]} ))
eval_processes="${eval_processes_values[$(( trial % ${#eval_processes_values[@]} ))]}"
trial=$(( trial / ${#eval_processes_values[@]} ))
eval_capture_videos="${eval_capture_videos_values[$(( trial % ${#eval_capture_videos_values[@]} ))]}"
trial=$(( trial / ${#eval_capture_videos_values[@]} ))
translate="${translate_values[$(( trial % ${#translate_values[@]} ))]}"
trial=$(( trial / ${#translate_values[@]} ))
data_dir="${data_dir_values[$(( trial % ${#data_dir_values[@]} ))]}"

module purge
module load cuda anaconda3 vulkan-sdk
conda activate conda_poetry_base

export PYTHONUNBUFFERED=1

# Set up poetry
cd ~/enn/incubator
poetry shell

python ~/enn/incubator/enn_ppo/enn_ppo/train.py  --gym-id="${gym_id}" --exp-name="${exp_name}" --track="${track}" --total-timesteps="${total_timesteps}" --processes="${processes}" --num-envs="${num_envs}" --num-steps="${num_steps}" --num-minibatches="${num_minibatches}" --learning-rate="${learning_rate}" --seed="${seed}" --ent-coef="${ent_coef}" --eval-interval="${eval_interval}" --eval-steps="${eval_steps}" --eval-num-env="${eval_num_env}" --eval-processes="${eval_processes}" --eval-capture-videos="${eval_capture_videos}" --translate="${translate}" --data-dir="${data_dir}"