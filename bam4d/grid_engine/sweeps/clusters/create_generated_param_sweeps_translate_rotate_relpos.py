from bam4d.grid_engine.param_sweeper import get_script

if __name__ == '__main__':

    job_name = 'griddly-clusters-generated-param-sweep-translation-rotation-relpos'
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
            'sge_entry_point': '~/enn/incubator/enn_ppo/enn_ppo/train.py'
        },
        {
            'gym-id': ['GDY-Clusters-Generated-Small', 'GDY-Clusters-Generated-Medium', 'GDY-Clusters-Generated-Large'],
            'exp-name': [f'{job_name}'],
            'track': ['True'],
            'total-timesteps': [50000000],
            'processes': [8],
            'num-envs': [1024],
            'num-steps': [64],
            'num-minibatches': [16],
            'learning-rate': [0.05, 0.001, 0.005],
            'seed': [0,1],
            'ent-coef': [0.01, 0.005, 0.001],
            'eval-interval': [1000000],
            'eval-steps': [1000],
            'eval-num-env': [1],
            'eval-processes': [1],
            'eval-capture-videos': [True],
            'translate': ['"{\\"reference_entity\\": \\"avatar\\", \\"position_features\\": [\\"x\\", \\"y\\"], \\"orientation_features\\": [\\"ox\\", \\"oy\\"]}"'],
            'relpos-encoding': ['"{\\"extent\\": [10, 10], \\"exclude_entities\\": [\\"__global__\\"], \\"position_features\\": [\\"x\\", \\"y\\"]}"'],
            'data-dir': [f'/data/scratch/acw434/{job_name}']
        })

    with open(f'submit-array_{job_name}.sh', 'w') as f:
        f.write(script)
