% set your mat caffe path
matcaffePath = '/home/phoenix/deeplab/code-v2/matlab/';
addpath(matcaffePath)
addpath(genpath('./'))

% Set parameters for the CNN model
param.protoFile='/home/phoenix/temp/train_train.prototxt';
param.modelFile='/home/phoenix/temp/refine4-up_addSuper_9000.caffemodel';

net = caffe.Net(param.protoFile, param.modelFile, 'train');