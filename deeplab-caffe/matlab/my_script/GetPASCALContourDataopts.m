function opts = PASCALContourData(seg_root, seg_res_dir, trainset, testset, dataset)
%clear opts

if nargin < 5
    dataset = 'PASCALContourData';
end

% dataset
%
opts.dataset=dataset;

% get devkit directory with forward slashes
devkitroot=strrep(fileparts(fileparts(mfilename('fullpath'))),'\','/');

% change this path to point to your copy of the PASCAL msra data
opts.datadir=[devkitroot '/'];

% change this path to a writable directory for your results
%opts.resdir=[devkitroot '/results/' opts.dataset '/'];
opts.resdir = seg_res_dir;

% change this path to a writable local directory for the example code
opts.localdir=[devkitroot '/local/' opts.dataset '/'];

% initialize the training set

opts.trainset = trainset;
%opts.trainset='train'; % use train for development
% opts.trainset='trainval'; % use train+val for final challenge

% initialize the test set

opts.testset = testset;
%opts.testset='val'; % use validation data for development test set
% opts.testset='test'; % use test set for final challenge

% initialize main challenge paths

%opts.annopath=[opts.datadir opts.dataset '/Annotations/%s.xml'];
%opts.imgpath=[opts.datadir opts.dataset '/JPEGImages/%s.jpg'];
%opts.imgsetpath=[opts.datadir opts.dataset '/ImageSets/Main/%s.txt'];
%opts.clsimgsetpath=[opts.datadir opts.dataset '/ImageSets/Main/%s_%s.txt'];

opts.annopath=[seg_root '/SegmentationObjectFilledDenseCRF/%s.xml'];
opts.imgpath=[seg_root '/JPEGImages/%s.jpg'];
opts.imgsetpath=[seg_root '/split/%s.txt'];
opts.clsimgsetpath=[seg_root '/split/%s_%s.txt'];


opts.clsrespath=[opts.resdir 'Main/%s_cls_' opts.testset '_%s.txt'];
opts.detrespath=[opts.resdir 'Main/%s_det_' opts.testset '_%s.txt'];

% initialize segmentation task paths

%if strcmp(dataset, 'msra2012')
 %   opts.seg.clsimgpath=[seg_root '/SegmentationClassAug/%s.png'];
%else
    opts.seg.clsimgpath=[seg_root '/annotation/%s'];
%end

opts.seg.instimgpath=[seg_root '/SegmentationObject/%s'];
opts.seg.imgsetpath=[seg_root '/split/%s.txt'];

%opts.seg.clsimgpath=[opts.datadir opts.dataset '/SegmentationClass/%s.png'];
%opts.seg.instimgpath=[opts.datadir opts.dataset '/SegmentationObject/%s.png'];
%opts.seg.imgsetpath=[opts.dataset '/ImageSets/Segmentation/%s.txt'];


opts.seg.clsresdir=[opts.resdir 'Saliency/%s_%s_cls'];
opts.seg.instresdir=[opts.resdir 'Segmentation/%s_%s_inst'];
opts.seg.clsrespath=[opts.seg.clsresdir '/%s'];
opts.seg.instrespath=[opts.seg.instresdir '/%s.png'];

% initialize layout task paths

opts.layout.imgsetpath=[opts.datadir opts.dataset '/ImageSets/Layout/%s.txt'];
opts.layout.respath=[opts.resdir 'Layout/%s_layout_' opts.testset '.xml'];

% initialize action task paths

opts.action.imgsetpath=[opts.datadir opts.dataset '/ImageSets/Action/%s.txt'];
opts.action.clsimgsetpath=[opts.datadir opts.dataset '/ImageSets/Action/%s_%s.txt'];
opts.action.respath=[opts.resdir 'Action/%s_action_' opts.testset '_%s.txt'];

% initialize the msra challenge options

% classes

if ~isempty(strfind(seg_root, 'PASCALContourData'))
  opts.classes={...
    'saliency'
    };
  
elseif ~isempty(strfind(seg_root, 'coco')) || ~isempty(strfind(seg_root, 'COCO'))
  coco_categories = GetCocoCategories();
  opts.classes = coco_categories.values();
else
  error('Unknown dataset!\n');
end
 
opts.nclasses=length(opts.classes);	


% poses

opts.poses={...
    'Unspecified'
    'Left'
    'Right'
    'Frontal'
    'Rear'};

opts.nposes=length(opts.poses);

% layout parts

opts.parts={...
    'head'
    'hand'
    'foot'};    

opts.nparts=length(opts.parts);

opts.maxparts=[1 2 2];   % max of each of above parts

% actions

opts.actions={...    
    'other'             % skip this when training classifiers
    'jumping'
    'phoning'
    'playinginstrument'
    'reading'
    'ridingbike'
    'ridinghorse'
    'running'
    'takingphoto'
    'usingcomputer'
    'walking'};

opts.nactions=length(opts.actions);

% overlap threshold

opts.minoverlap=0.5;

% annotation cache for evaluation

opts.annocachepath=[opts.localdir '%s_anno.mat'];

% options for example implementations

opts.exfdpath=[opts.localdir '%s_fd.mat'];
