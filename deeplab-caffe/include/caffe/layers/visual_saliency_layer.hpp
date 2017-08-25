#ifndef CAFFE_VISUAL_SALIENCY_LAYER_HPP_
#define CAFFE_VISUAL_SALIENCY_LAYER_HPP_

#include <string>
#include <vector>

#include "caffe/blob.hpp"
#include "caffe/layer.hpp"
#include "caffe/proto/caffe.pb.h"

namespace caffe {

/*
  VisualSaliencyLayer
*/
template <typename Dtype>
class VisualSaliencyLayer : public Layer<Dtype> {
 public:
  explicit VisualSaliencyLayer(const LayerParameter& param)
      : Layer<Dtype>(param) {}
  virtual void LayerSetUp(const vector<Blob<Dtype>*>& bottom,
      const vector<Blob<Dtype>*>& top);
  virtual void Reshape(const vector<Blob<Dtype>*>& bottom,
      const vector<Blob<Dtype>*>& top);
  virtual inline const char* type() const { return "VisualSaliency"; }
  virtual inline int ExactNumTopBlobs() const { return 0; }

 protected:
  virtual void Forward_cpu(const vector<Blob<Dtype>*>& bottom,
      const vector<Blob<Dtype>*>& top);
  virtual void Backward_cpu(const vector<Blob<Dtype>*>& top,
      const vector<bool>& propagate_down, const vector<Blob<Dtype>*>& bottom);
  int iter_;
  int visual_interval_;
  int visual_num_;
  string layer_name_;
  string prefix_;

};

}  // namespace caffe

#endif  // CAFFE_VISUAL_SALIENCY_LAYER_HPP_