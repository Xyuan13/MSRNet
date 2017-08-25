% save jpg images as bin file for cpp
%
is_server = 1;

dataset = 'msra';  %'coco', 'voc2012','msra'

if is_server
  if strcmp(dataset, 'voc2012')
    img_folder  = '/rmt/data/pascal/VOCdevkit/VOC2012/JPEGImages'
    save_folder = '/rmt/data/pascal/VOCdevkit/VOC2012/PPMImages';
  elseif strcmp(dataset, 'coco')
    img_folder  = '/rmt/data/coco/JPEGImages';
    save_folder = '/rmt/data/coco/PPMImages';
  elseif strcmp(dataset,'msra')
    img_folder  = '/home/phoenix/deeplab/rmt/work/deeplabel/exper/msra/res/features/deeplab_v2_vgg16_refine_full/val/fc8/post_none/results/Saliency/comp6_val_cls'
    save_folder = '/home/phoenix/deeplab/rmt/work/deeplabel/exper/msra/res/features/deeplab_v2_vgg16_refine_full/val/fc8/post_none/results/Saliency/ppm';   
  end 
else
  img_folder = '../img';
  save_folder = '../img_ppm';
end

if ~exist(save_folder, 'dir')
    mkdir(save_folder);
end

img_dir = dir(fullfile(img_folder, '*.png'));
disp(numel(img_dir));
for i = 1 : numel(img_dir)
    fprintf(1, 'processing %d (%d)...\n', i, numel(img_dir));
    img = imread(fullfile(img_folder, img_dir(i).name));
    
    img_fn = img_dir(i).name(1:end-4);
    save_fn = fullfile(save_folder, [img_fn, '.ppm']);
    
    imwrite(img, save_fn);   
end
    
