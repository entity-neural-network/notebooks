from bam4d.grid_engine.param_sweeper import get_script

if __name__ == '__main__':

    job_name = 'griddly-clusters-sge-test2'
    script = get_script(
        {
            'sge_time_h': 1,
            'sge_job_name': f'{job_name}',
            'sge_num_cpus': 8,
            'sge_num_gpus': 1,
            'sge_memory': 11,
            'sge_memory_unit': 'G',
            'sge_cluster_name': 'andrena',
            'sge_gpu_type': 'ampere',
            'sge_root_directory': '~/enn/incubator',
            'sge_entry_point': '~/enn/incubator/enn_ppo/enn_ppo/train.py'
        },
        {
            'gym-id': ['GDY-Clusters-0', 'GDY-Clusters-3'],
            'exp-name': [f'{job_name}'],
            'track': ['True'],
            'total-timesteps': [10000000],
            'processes': [8],
            'num-envs': [2048],
            'num-steps': [128],
            'num-minibatches': [16],
            'learning-rate': [0.05, 0.01, 0.005],
            'ent-coef': [0.2, 0.1, 0.05],
            'eval-interval': [1000000],
            'eval-steps': [300],
            'eval-num-env': [8],
            'eval-processes': [4],
            'data-dir': [f'/data/scratch/acw434/{job_name}']
        })

    with open(f'submit-array_{job_name}.sh', 'w') as f:
        f.write(script)
