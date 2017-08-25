function salopts = GetSaliencyOpts(sal_data_dir, sal_exper_dir, sal_res_dir, trainset, testset, dataset)
%clear msraopts

if nargin < 5
    dataset = 'msra';
end

% dataset
salopts.dataset=dataset;


% initialize the training set
salopts.trainset = trainset;

% initialize the test set
salopts.testset = testset;

% initialize main paths
salopts.imgsetpath=[sal_exper_dir '/list/%s_id.txt'];
salopts.respath = [sal_res_dir '/%s.png'];
if strcmp(dataset, 'msra') || strcmp(dataset, 'msra10k')
  salopts.imgpath=[sal_data_dir '/msra/image/%s.jpg'];
  salopts.annopath=[sal_data_dir '/msra/gt/%s.png'];
elseif strcmp(dataset, 'pascal-s')
  salopts.imgpath=[sal_data_dir '/imgs/%s.jpg'];
  salopts.annopath=[sal_data_dir '/gt/%s.png'];
elseif strcmp(dataset, 'ECSSD')
  salopts.imgpath=[sal_data_dir '/image/%s.jpg'];
  salopts.annopath=[sal_data_dir '/gt/%s.png'];  
else
    error('Unknown Dataset!');
end
% classes
salopts.classes={...
    'saliency'
};
salopts.nclasses=length(salopts.classes);	

% overlap threshold
salopts.minoverlap=0.5;


