#ifndef CAFFE_IMAGE_SALOBJ_DATA_LAYER_HPP_
#define CAFFE_IMAGE_SALOBJ_DATA_LAYER_HPP_

#include <string>
#include <utility>
#include <vector>

#include "caffe/blob.hpp"
#include "caffe/data_transformer.hpp"
#include "caffe/internal_thread.hpp"
#include "caffe/layer.hpp"
#include "caffe/layers/base_data_layer.hpp"
#include "caffe/proto/caffe.pb.h"
//--------------------------------------------------
const int MultiSource_TopTypes_Count = 5;
enum TopType {
  DATA = 0,  
  LABEL = 1,   
  DIM = 2, 
  COUNT = 3,   
  UNKNOW = 4
};
const std::string TopType_String[MultiSource_TopTypes_Count] = {
        "data",    // whether is face or not
        "label" ,    // bbox boords
        "data_dim", // landmark coords
        "count"      // four kinds of faces : negative, positive, part, landmark
};
//--------------------------------------------------

namespace caffe {

template <typename Dtype>
class ImageSalobjDataLayer : public ImageDimPrefetchingDataLayer<Dtype> {
 public:
  explicit ImageSalobjDataLayer(const LayerParameter& param)
    : ImageDimPrefetchingDataLayer<Dtype>(param) {}
  virtual ~ImageSalobjDataLayer();
  virtual void DataLayerSetUp(const vector<Blob<Dtype>*>& bottom,
      const vector<Blob<Dtype>*>& top);

  virtual inline const char* type() const { return "ImageSalobjData"; }
  virtual inline int ExactNumBottomBlobs() const { return 0; }
  // virtual inline int ExactNumTopBlobs() const { return 4; }
  virtual inline bool AutoTopBlobs() const { return true; }

 protected:
  virtual void ShuffleImages();
  virtual void ShuffleImagesAndCount();
  virtual void load_batch(Batch<Dtype>* batch);

  Blob<Dtype> transformed_label_;
  Blob<Dtype> transformed_count_;
  shared_ptr<Caffe::RNG> prefetch_rng_;
  vector<std::pair<std::string, std::string> > lines_;
  vector<int> count_;
  int lines_id_;
  //---------------------------------------------------------------------
  bool has_count_file;
  // top
  std::set<TopType> topTypes_set_;
  vector<std::pair<TopType, Blob<Dtype>* > > topTypes_vec_;
  //---------------------------------------------------------------------
};

}  // namespace caffe

#endif  // CAFFE_IMAGE_SALOBJ_DATA_LAYER_HPP_

