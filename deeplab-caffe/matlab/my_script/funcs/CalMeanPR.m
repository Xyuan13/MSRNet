function [pr,rc] = CalMeanPR(SRC, srcSuffix, GT, gtSuffix)
% Code Author: Wangjiang Zhu
% Email: wangjiang88119@gmail.com
% Date: 3/24/2014
files = dir(fullfile(SRC, strcat('*', srcSuffix)));
if isempty(files)
    error('No saliency maps are found: %s\n', fullfile(SRC, strcat('*', srcSuffix)));
end

pr = zeros(length(files), 1);
rc = zeros(length(files), 1);
parfor k = 1:length(files)

    srcName = files(k).name;
    srcImg = imread(fullfile(SRC, srcName));
    
    gtName = strrep(srcName, srcSuffix, gtSuffix);
    gtImg = imread(fullfile(GT, gtName));
    
    ta = sum(srcImg(:))/(size(srcImg,1)*size(srcImg,2));
    EVAL = Evaluate(gtImg(:,:,1)>1,srcImg>ta);
    
    pr(k) = EVAL(4);
    rc(k) = EVAL(5);
end

pr = mean(pr)
rc = mean(rc)
