% matcaffe path
matcaffePath = '../deeplab-caffe/matlab/';
addpath(matcaffePath)

% change to your images
data_root='../data';
img_id='0_0_775';
suffix='.jpg';

% set parameters for the CNN model
models_root='../models_prototxts';
model_id='VGG';

% If your don't have enough memory of GPU, set the downsample_flag true,
% and the input data size would be changed from 512 to 320.
% Since your image size may be larger than the input data size(320/512),
% please set the suitable ratio to downsalple the image 
% otherwise you can't get the proper result.
downsample_flag = true;
ratio = 0.5;

% GPU / CPU
useGPU = true;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
param.protoFile = fullfile(models_root, sprintf('MSRNet-%s-test.prototxt',model_id));
param.modelFile = fullfile(models_root, sprintf('MSRNet-%s.caffemodel',model_id));

% init net
caffe.reset_all();
if exist(param.modelFile, 'file') == 0
  fprintf('%s does not exist.', param.modelFile);
end
if ~exist(param.protoFile,'file')
  error('%s does not exist.', param.protoFile);
end
if useGPU
  fprintf('Using GPU Mode\n');
  caffe.set_mode_gpu();
  caffe.set_device(0);
else
  fprintf('Using CPU Mode\n');
  caffe.set_mode_cpu;
end

net = caffe.Net(param.protoFile, param.modelFile, 'test');

im_data=imread(fullfile(data_root,'imgs',[img_id suffix]));
src=im_data;
if downsample_flag
    input=zeros(320,320,3);   
    im_data=imresize(im_data, ratio);
else
    input=zeros(512,512,3);
    net.blobs('data').reshape([512 512 3 1]);
end

[H, W, ~]=size(im_data);
im_data = im_data(:, :, [3, 2, 1]);           % convert from RGB to BGR
im_data = permute(im_data, [2, 1, 3]);  % permute width and height
im_data = single(im_data);                    % convert to single precision

mean_pix = [104.008, 116.669, 122.675]; 
for c = 1:3, im_data(:,:,c,:) = im_data(:,:,c,:) - mean_pix(c); end
input(1:W,1:H,:)=im_data;

net.forward({input});
output = net.blobs('final_fusion').get_data();
output_crf= net.blobs('final_fusion_crf').get_data();

smap=output(:,:,2);
smap=permute(smap,[2,1,3]);
smap=smap(1:H, 1:W);

smap_crf = output_crf(:,:,2);
smap_crf = permute(smap_crf,[2,1,3]);
smap_crf = smap_crf(1:H, 1:W);
%% show result
% save the compare result
h=figure(1);    

subplot(1,3,1);
imshow(src);
title('Image');

subplot(1,3,2);
imshow(smap);
title('SaliencyMap'); 

subplot(1,3,3);
imshow(smap_crf);
title('SaliencyMap+CRF'); 

%% save saliency map
path=fullfile(data_root,'pre',[img_id '.png']);
imwrite(smap, path);
path=fullfile(data_root,'pre',[img_id '_crf.png']);
imwrite(smap_crf, path);
