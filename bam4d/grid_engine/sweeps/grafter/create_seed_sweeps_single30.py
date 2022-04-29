from bam4d.grid_engine.param_sweeper import get_script

if __name__ == '__main__':

    job_name = 'grafter-single-hyperparam-sweep'

    script = get_script(
        {
            'sge_time_h': 6,
            'sge_job_name': f'{job_name}',
            'sge_num_cpus': 8,
            'sge_num_gpus': 1,
            'sge_memory': 11,
            'sge_memory_unit': 'G',
            'sge_cluster_name': 'andrena',
            'sge_gpu_type': 'ampere',
            'sge_root_directory': '~/enn/incubator',
            'sge_entry_point': '~/enn/incubator/enn_zoo/enn_zoo/train.py'
        },
        {
            'env.id': ['GDY-Grafter-Single-30','GDY-Grafter-Single-50','GDY-Grafter-Single-100'],

            'name': [f'{job_name}'],
            'track': ['True'],
            'seed': [0],
            'total_timesteps': [1000000],
            'data_dir': [f'/data/scratch/acw434/{job_name}'],

            'rollout.processes': [8],
            'rollout.num_envs': [256, 512, 1024],
            'rollout.steps': [64, 128, 512],
            #'rolloutnum-minibatches': [16, 32],

            'optim.bs': [8192, 16384, 32768],
            'optim.lr': [0.005, 0.001, 0.0005],

            'ppo.ent_coef': [0.2, 0.1, 0.05],

            # 'eval.interval': [500000],
            # 'eval.steps': [1000],
            # 'eval.num_envs': [1],
            # 'eval.processes': [1],
            # 'eval.capture_videos': [True]

        })
    with open(f'submit-array_{job_name}.sh', 'w') as f:
        f.write(script)