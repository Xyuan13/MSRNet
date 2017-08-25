clear all; close all;

%dataset = 'VOC2012';
%orig_folder = fullfile('..', dataset, 'SegmentationClassAug_Visualization');
%save_folder = ['../', dataset, '/SegmentationClassAug'];

%orig_folder = '/rmt/work/deeplabel/exper/voc12/res/erode_gt/post_densecrf_W41_XStd33_RStd4_PosW3_PosXStd3/results/VOC2012/Segmentation/comp6_trainval_aug_cls';
%save_folder = '/rmt/data/pascal/VOCdevkit/VOC2012/SegmentationClassBboxErodeCRFAug';

orig_folder_gt = '/home/phoenix/saliency_annotation/dataset/gt_remain';
pre_folder_gt = '/home/phoenix/saliency_annotation/dataset/fc8_png';

save_folder_gt = '/home/phoenix/saliency_annotation/dataset/gt_remain_resize_back';
%save_folder_image = '/home/phoenix/saliency_annotation/dataset/image_remain_resize';



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% You do not need to change values below
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
imgs_dir = dir(fullfile(orig_folder_gt, '*.png'));

if ~exist(save_folder_gt, 'dir')
    mkdir(save_folder_gt)
end

for i = 1 : numel(imgs_dir)
    %fprintf(1, 'processing %d (%d) ...\n', i, numel(imgs_dir));
    
    img_gt = imread(fullfile(orig_folder_gt, imgs_dir(i).name));
    pre_gt = imread(fullfile(pre_folder_gt, imgs_dir(i).name));
    
    if(size(img_gt,1)>512||size(img_gt,2)>512)
       disp(imgs_dir(i).name);
    img_row = size(img_gt,1);
    img_col = size(img_gt,2);
    
    if img_row > img_col
        factor = img_row/512;
    else
        factor = img_col/512;
    end
    
    %img_gt_resize=imresize(img_gt,factor);
    img_resize=imresize(pre_gt,[img_row img_col]);
    
    imwrite(img_resize,fullfile(save_folder_gt, imgs_dir(i).name));
%    imwrite(img_image_resize,[save_folder_image '/' imgs_dir(i).name(1:end-4) '.jpg'] );
%     img_path1=[orig_folder_image '/' imgs_dir(i).name(1:end-4) '.jpg'];
%     img_path2=[save_folder_image '/' imgs_dir(i).name(1:end-4) '.jpg'];
%     copyfile(img_path1,img_path2);
%     
%     gt_path1=fullfile(orig_folder_gt, imgs_dir(i).name);
%     gt_path2=fullfile(save_folder_gt, imgs_dir(i).name);
%     copyfile(gt_path1,gt_path2);
    end
    %imwrite(img/255, fullfile(save_folder, imgs_dir(i).name));
end
