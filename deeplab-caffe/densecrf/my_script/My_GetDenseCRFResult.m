% compute the densecrf result (.bin) to png
%
function My_GetDenseCRFResult(stage)
    addpath('/home/phoenix/deeplab/code-v2/matlab/my_script');
    %SetupEnv;
    load('./pascal_seg_colormap.mat');

    map_folder=['/home/phoenix/Dataset/MSRA-B/SaliencyMap/' stage '_crf_bin'];
    map_dir = dir(fullfile(map_folder, '*bin'));
    save_result_folder=['/home/phoenix/Dataset/MSRA-B/SaliencyMap/' stage '_crf_png'];

    fprintf(1,' saving to %s\n', save_result_folder);

    if ~exist(save_result_folder, 'dir')
        mkdir(save_result_folder);
    end

    for i = 1 : numel(map_dir)
        fprintf(1, 'processing %d (%d)...\n', i, numel(map_dir));
        map = LoadBinFile(fullfile(map_folder, map_dir(i).name), 'int16');

        img_fn = map_dir(i).name(1:end-4);
        %imwrite(uint8(map), colormap, fullfile(save_result_folder, [img_fn, '.png']));
        imwrite(double(map), fullfile(save_result_folder, [img_fn, '.png']));
    end
end

