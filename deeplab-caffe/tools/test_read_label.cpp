#include <fstream>  // NOLINT(readability/streams)
#include <iostream>  // NOLINT(readability/streams)
#include <string>
#include <utility>
#include <vector>
#include <algorithm>

#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/highgui/highgui_c.h>
#include <opencv2/imgproc/imgproc.hpp>

#include "caffe/data_transformer.hpp"
#include "caffe/layers/base_data_layer.hpp"
#include "caffe/layers/image_seg_data_layer.hpp"
#include "caffe/util/benchmark.hpp"
#include "caffe/util/io.hpp"
#include "caffe/util/math_functions.hpp"
#include "caffe/util/rng.hpp"


int main() {
	 
  std::string root_folder="/home/phoenix/Dataset/MSRA-B";
  std::string img_id="/annotation/9_58060.png";
  int new_height=513;
  int new_width=513;
  bool is_color=false;
  // Read an image, and use it to initialize the top blob.
  cv::Mat cv_img = caffe::ReadImageToCVMat(root_folder + img_id,
                                    new_height, new_width, is_color);
  CHECK(cv_img.data) << "Could not load " << img_id;
  
  std::cout << cv_img.rows << std::endl;
  std::cout << cv_img.cols << std::endl;
  std::cout << cv_img.channels();
  //cv::imshow("label", cv_img);
  //cv::waitKey(0);
/*  for (int h = 0; h < new_height; h++) {
    for (int w = 0; w < new_width; w++)
      std::cout<< int(cv_img.at<uchar>(h,w))<<" ";
    std::cout << std::endl;
  }
*/  return 0;
}

