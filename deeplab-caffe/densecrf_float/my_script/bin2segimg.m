

%map_folder = '~/FCN_Saliency/deeplab/voc12/res/features/vgg128_nout/val/fc8/post_densecrf_w5_xstd50_posw3_poxsd50/'; 
map_folder = '~/FCN_Saliency/Deeplab_Saliency/dataset/msra/features2/vgg128_noup/test/floatcrf/'; 

map_dir = dir(fullfile(map_folder, '*.bin'));

save_result_folder = '~/FCN_Saliency/Deeplab_Saliency/dataset/msra/features2/vgg128_noup/test/floatcrf/';

if ~exist(save_result_folder, 'dir')
    mkdir(save_result_folder);
end

for i = 1 : numel(map_dir)
    fprintf(1, 'processing %d (%d)...\n', i, numel(map_dir));
    map = LoadBinFile(fullfile(map_folder, map_dir(i).name), 'float');

    img_fn = map_dir(i).name(1:end-4);
    imwrite(uint8(map), colormap, fullfile(save_result_folder, [img_fn, '.png']));
end
