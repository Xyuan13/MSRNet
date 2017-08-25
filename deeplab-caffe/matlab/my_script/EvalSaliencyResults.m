SetupEnv;
addpath('./funcs');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dataset_root_folder = sprintf('/home/phoenix/deeplab/rmt/data/%s',dataset);
exper_root_folder = sprintf('/home/phoenix/deeplab/exper/%s',dataset);
result_folder = sprintf('%s/results/%s/%s', exper_root_folder, model_name, testset);

% Get Opts 
salopts = GetSaliencyOpts(dataset_root_folder, exper_root_folder, result_folder,trainset, testset, dataset)

if strcmp(testset, 'val')
  [ conf, rawcounts] = MySaliencyEval(salopts, id);
else
  fprintf(1, 'This is test set. No evaluation. Just saved as png\n');
end 

    
    

