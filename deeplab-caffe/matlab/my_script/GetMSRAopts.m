function msraopts = GetMSRAopts(seg_root, seg_res_dir, trainset, testset, dataset)
%clear msraopts

if nargin < 5
    dataset = 'msra';
end

% dataset
%
msraopts.dataset=dataset;

% get devkit directory with forward slashes
devkitroot=strrep(fileparts(fileparts(mfilename('fullpath'))),'\','/');

% change this path to point to your copy of the PASCAL msra data
msraopts.datadir=[devkitroot '/'];

% change this path to a writable directory for your results
%msraopts.resdir=[devkitroot '/results/' msraopts.dataset '/'];
msraopts.resdir = seg_res_dir;

% change this path to a writable local directory for the example code
msraopts.localdir=[devkitroot '/local/' msraopts.dataset '/'];

% initialize the training set

msraopts.trainset = trainset;
%msraopts.trainset='train'; % use train for development
% msraopts.trainset='trainval'; % use train+val for final challenge

% initialize the test set

msraopts.testset = testset;
%msraopts.testset='val'; % use validation data for development test set
% msraopts.testset='test'; % use test set for final challenge

% initialize main challenge paths

%msraopts.annopath=[msraopts.datadir msraopts.dataset '/Annotations/%s.xml'];
%msraopts.imgpath=[msraopts.datadir msraopts.dataset '/JPEGImages/%s.jpg'];
%msraopts.imgsetpath=[msraopts.datadir msraopts.dataset '/ImageSets/Main/%s.txt'];
%msraopts.clsimgsetpath=[msraopts.datadir msraopts.dataset '/ImageSets/Main/%s_%s.txt'];

msraopts.annopath=[seg_root '/annotations/%s.xml'];
msraopts.imgpath=[seg_root '/images/%s.jpg'];
msraopts.imgsetpath=[seg_root '/split/%s.txt'];
msraopts.clsimgsetpath=[seg_root '/split/%s_%s.txt'];


msraopts.clsrespath=[msraopts.resdir 'Main/%s_cls_' msraopts.testset '_%s.txt'];
msraopts.detrespath=[msraopts.resdir 'Main/%s_det_' msraopts.testset '_%s.txt'];

% initialize segmentation task paths

%if strcmp(dataset, 'msra2012')
 %   msraopts.seg.clsimgpath=[seg_root '/SegmentationClassAug/%s.png'];
%else
    msraopts.seg.clsimgpath=[seg_root '/gt/%s'];
%end

msraopts.seg.instimgpath=[seg_root '/SegmentationObject/%s'];
msraopts.seg.imgsetpath=[seg_root '/split/%s.txt'];

%msraopts.seg.clsimgpath=[msraopts.datadir msraopts.dataset '/SegmentationClass/%s.png'];
%msraopts.seg.instimgpath=[msraopts.datadir msraopts.dataset '/SegmentationObject/%s.png'];
%msraopts.seg.imgsetpath=[msraopts.dataset '/ImageSets/Segmentation/%s.txt'];


msraopts.seg.clsresdir=[msraopts.resdir 'Saliency/%s_%s_cls'];
msraopts.seg.instresdir=[msraopts.resdir 'Segmentation/%s_%s_inst'];
msraopts.seg.clsrespath=[msraopts.seg.clsresdir '/%s'];
msraopts.seg.instrespath=[msraopts.seg.instresdir '/%s.png'];

% initialize layout task paths

msraopts.layout.imgsetpath=[msraopts.datadir msraopts.dataset '/ImageSets/Layout/%s.txt'];
msraopts.layout.respath=[msraopts.resdir 'Layout/%s_layout_' msraopts.testset '.xml'];

% initialize action task paths

msraopts.action.imgsetpath=[msraopts.datadir msraopts.dataset '/ImageSets/Action/%s.txt'];
msraopts.action.clsimgsetpath=[msraopts.datadir msraopts.dataset '/ImageSets/Action/%s_%s.txt'];
msraopts.action.respath=[msraopts.resdir 'Action/%s_action_' msraopts.testset '_%s.txt'];

% initialize the msra challenge options

% classes

if ~isempty(strfind(seg_root, 'msra')) || ~isempty(strfind(seg_root, 'pascal-s'))
  msraopts.classes={...
    'saliency'
    };
  
elseif ~isempty(strfind(seg_root, 'coco')) || ~isempty(strfind(seg_root, 'COCO'))
  coco_categories = GetCocoCategories();
  msraopts.classes = coco_categories.values();
else
    disp(seg_root);
  error('Unknown dataset!\n');
end
 
msraopts.nclasses=length(msraopts.classes);	


% poses

msraopts.poses={...
    'Unspecified'
    'Left'
    'Right'
    'Frontal'
    'Rear'};

msraopts.nposes=length(msraopts.poses);

% layout parts

msraopts.parts={...
    'head'
    'hand'
    'foot'};    

msraopts.nparts=length(msraopts.parts);

msraopts.maxparts=[1 2 2];   % max of each of above parts

% actions

msraopts.actions={...    
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

msraopts.nactions=length(msraopts.actions);

% overlap threshold

msraopts.minoverlap=0.5;

% annotation cache for evaluation

msraopts.annocachepath=[msraopts.localdir '%s_anno.mat'];

% options for example implementations

msraopts.exfdpath=[msraopts.localdir '%s_fd.mat'];
