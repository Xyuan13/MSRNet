model= 'Attention-Refine-320' %'Res101' %'Attention-COCO'
dataset='msra+hku'
phase='val'
layer='fc8_2000'

features_root=['/home/phoenix/deeplab/exper/' dataset '/features/' model '/' phase '/' layer]

output_path=['/home/phoenix/deeplab/exper/' dataset '/features/' model '/' phase '/' layer '_png/']
if ~exist(output_path)
    mkdir(output_path)
end


dataset_root='/home/phoenix/deeplab/rmt/data/'
if strcmp(dataset, 'msra') 
      dataset_path=[dataset_root dataset '/image/']
elseif strcmp(dataset, 'ECSSD')
      dataset_path=[dataset_root dataset '/image/']
elseif strcmp(dataset, 'msra+hku') 
      dataset_path=[dataset_root dataset '/msra/image/']    
end

    
dirs=dir(fullfile(features_root,'*.mat'))
for i=1:size(dirs)
    if mod(i, 100) == 0
        fprintf(1, 'processing %d (%d)...\n', i, numel(size(dirs)));
    end    
    mat_id=dirs(i).name;
    img_id=mat_id(1:end-11);
    im=imread([dataset_path img_id '.jpg']);
    img_row = size(im, 1);
    img_col = size(im, 2);
    data_mat=load(fullfile(features_root,mat_id));
    data=data_mat.data;

    fc8_map = data(:,:,2);
    sal_result = permute(fc8_map,[2,1,3]);
    sal_pro = sal_result(1:img_row,1:img_col,:);
      
    fc8_map_bg = data(:,:,1);
    bg_result = permute(fc8_map_bg,[2,1,3]);
    bg_pro=bg_result(1:img_row,1:img_col,:);
    
    pro = sal_pro;
    for m = 1:img_row
        for n = 1:img_col
          if pro(m,n,1) < bg_pro(m,n,1)
              pro(m,n)=0;
          end
        end
    end
    pro = (pro - min(pro(:))) /(max(pro(:)) - min(pro(:)) + eps);
    result_seg = uint8(pro.*255);
    
    imwrite(result_seg,[output_path img_id '.png']);
end
    

    