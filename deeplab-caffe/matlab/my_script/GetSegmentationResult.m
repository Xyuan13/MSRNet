SetupEnv;
if is_server
  if strcmp(dataset, 'voc12')
    VOC_root_folder = '/home/phoenix/deeplab/rmt/data/pascal/VOCdevkit';
  elseif strcmp(dataset, 'pascalSelect')
    VOC_root_folder = '/home/phoenix/deeplab/rmt/data/pascalSelect';
  else
    error('Wrong dataset');
  end
else
  if strcmp(dataset, 'voc12')  
    VOC_root_folder = '~/dataset/PASCAL/VOCdevkit';
  elseif strcmp(dataset, 'coco')
    VOC_root_folder = '~/dataset/coco';
  else
    error('Wrong dataset');
  end
end


output_mat_folder = fullfile('/home/phoenix/deeplab/exper', dataset, feature_name, model_name, testset, feature_type);
save_result_folder = fullfile('/home/phoenix/deeplab/exper', dataset, 'res', model_name, testset);
if ~exist(save_result_folder, 'dir')
    mkdir(save_result_folder);
end
fprintf(1, 'Saving to %s\n', save_result_folder);
fprintf(1, 'output_mat_folder: %s\n', output_mat_folder);

disp('is_mat')
  % crop the results
  load('pascal_seg_colormap.mat');

  output_dir = dir(fullfile(output_mat_folder, '*.mat'));
  fprintf(1,'numel of output: %d\n', numel(output_dir));
  for i = 1 : numel(output_dir)
   
    if mod(i, 100) == 0
        fprintf(1, 'processing %d (%d)...\n', i, numel(output_dir));
    end

    data = load(fullfile(output_mat_folder, output_dir(i).name));
    raw_result = data.data;
    raw_result = permute(raw_result, [2 1 3]);

    img_fn = output_dir(i).name(1:end-4);
    img_fn = strrep(img_fn, '_blob_0', '');
    
  
    img = imread(fullfile(VOC_root_folder, 'imgs', [img_fn, '.jpg']));

    
    img_row = size(img, 1);
    img_col = size(img, 2);
    
    result = raw_result(1:img_row, 1:img_col, :);

    if ~is_argmax
      [~, result] = max(result, [], 3);
      result = uint8(result) - 1;
    else
      result = uint8(result);
    end
    imwrite(result, colormap, fullfile(save_result_folder, [img_fn, '.png']));
  end