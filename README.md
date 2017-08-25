<<<<<<< HEAD
########################
#      MSRNet Code     #
########################
=======
# MSRNet
>>>>>>> 0249ac036d04f9004d65e202b7eabc7d259f9829

* This is the sample code for 2017 cvpr paper [Instance-Level Salient Object Segmentation]
  by Guanbin Li, Yuan Xie, Liang Lin and Yizhou Yu
* This code is tested on MATLAB 2014b on Ubuntu14.04
* For more information, please visit our project page 
  (http://hcp.sysu.edu.cn/instance-level-salient-object-segmentation)

## Contents ##
* This code includes 
 - 'deeplab-caffe': the Caffe toolbox for Multiscale Refinement Network (MSRNet) 
 - 'models_prototxts': pre-trained models and prototxts
 - 'code': codes to do testing
 - 'data': 
    a.imgs: source images to do saliency detection
    b.pre:  predicted results

## Usage Instructions ##
* Please follow the instructions below to run the code.
- Compile the `Caffe` and `matcaffe`  in the `deeplab-caffe` package. 
- Put your own images in the `data/imgs` directory
<<<<<<< HEAD
-Download the pretrained MSRNet-VGG models  by running the script
 ./models_prototxts/get_msrnet-vgg_model.sh
- Run 'code/demo.m' to generate saliency map
=======
- Run 'demo.m' to generate saliency map
>>>>>>> 0249ac036d04f9004d65e202b7eabc7d259f9829

## Citation ##
* If you find this useful, please cite our work as follows:
@inproceedings{MSRNet2017object,
  title={Instance-Level Salient Object Segmentation},
  author={Guanbin Li, Yuan Xie, Liang Lin and Yizhou Yu},
  booktitle={CVPR},
  year={2017}
}

<<<<<<< HEAD
Please contact "xiey39@mail2.sysu.edu.cn" if any questions with the code. 
=======
Please contact "xiey39@mail2.sysu.edu.cn" if any questions with the code. 
>>>>>>> 0249ac036d04f9004d65e202b7eabc7d259f9829
