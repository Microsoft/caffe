
This branch of Caffe extends [BVLC-led Caffe](https://github.com/BVLC/caffe) by adding Windows support and other functionalities commonly used by Microsoft's researchers, such as managed-code wrapper, [Faster-RCNN](https://papers.nips.cc/paper/5638-faster-r-cnn-towards-real-time-object-detection-with-region-proposal-networks.pdf), [R-FCN](https://arxiv.org/pdf/1605.06409v2.pdf), etc.

**Update**: this branch is not actively maintained. Please checkout [this](https://github.com/BVLC/caffe/tree/windows) for more active Windows support.

---

# Caffe

|  **`Linux (CPU)`**   |  **`Windows (CPU)`** |
|-------------------|----------------------|
| [![Travis Build Status](https://api.travis-ci.org/Microsoft/caffe.svg?branch=master)](https://travis-ci.org/Microsoft/caffe) | [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/6x4l911frv07lj1w/branch/master?svg=true)](https://ci.appveyor.com/project/zer0n/caffe) |              


[![License](https://img.shields.io/badge/license-BSD-blue.svg)](LICENSE)

By [Wei Liu](http://www.cs.unc.edu/~wliu/), [Dragomir Anguelov](https://www.linkedin.com/in/dragomiranguelov), [Dumitru Erhan](http://research.google.com/pubs/DumitruErhan.html), [Christian Szegedy](http://research.google.com/pubs/ChristianSzegedy.html), [Scott Reed](http://www-personal.umich.edu/~reedscot/), [Cheng-Yang Fu](http://www.cs.unc.edu/~cyfu/), [Alexander C. Berg](http://acberg.com).

### Introduction

SSD is an unified framework for object detection with a single network. You can use the code to train/evaluate a network for object detection task. For more details, please refer to our [arXiv paper](http://arxiv.org/abs/1512.02325) and our [slide](http://www.cs.unc.edu/~wliu/papers/ssd_eccv2016_slide.pdf).

<p align="center">
<img src="http://www.cs.unc.edu/~wliu/papers/ssd.png" alt="SSD Framework" width="600px">
</p>


| System | VOC2007 test *mAP* | **FPS** (Titan X) | Number of Boxes | Input resolution
|:-------|:-----:|:-------:|:-------:|:-------:|
| [Faster R-CNN (VGG16)](https://github.com/ShaoqingRen/faster_rcnn) | 73.2 | 7 | ~6000 | ~1000 x 600 |
| [YOLO (customized)](http://pjreddie.com/darknet/yolo/) | 63.4 | 45 | 98 | 448 x 448 |
| SSD300* (VGG16) | 77.2 | 46 | 8732 | 300 x 300 |
| SSD512* (VGG16) | **79.8** | 19 | 24564 | 512 x 512 |


<p align="left">
<img src="http://www.cs.unc.edu/~wliu/papers/ssd_results.png" alt="SSD results on multiple datasets" width="800px">
</p>

## Windows Setup
**Requirements**: Visual Studio 2013

### Pre-Build Steps
Copy `.\windows\CommonSettings.props.example` to `.\windows\CommonSettings.props`

By defaults Windows build requires `CUDA` and `cuDNN` libraries.
Both can be disabled by adjusting build variables in `.\windows\CommonSettings.props`.
Python support is disabled by default, but can be enabled via `.\windows\CommonSettings.props` as well.
3rd party dependencies required by Caffe are automatically resolved via NuGet.

### CUDA
Download `CUDA Toolkit 7.5` [from nVidia website](https://developer.nvidia.com/cuda-toolkit).
If you don't have CUDA installed, you can experiment with CPU_ONLY build.
In `.\windows\CommonSettings.props` set `CpuOnlyBuild` to `true` and set `UseCuDNN` to `false`.

### cuDNN
Download `cuDNN v4` or `cuDNN v5` [from nVidia website](https://developer.nvidia.com/cudnn).
Unpack downloaded zip to %CUDA_PATH% (environment variable set by CUDA installer).
Alternatively, you can unpack zip to any location and set `CuDnnPath` to point to this location in `.\windows\CommonSettings.props`.
`CuDnnPath` defined in `.\windows\CommonSettings.props`.
Also, you can disable cuDNN by setting `UseCuDNN` to `false` in the property file.

### Python
To build Caffe Python wrapper set `PythonSupport` to `true` in `.\windows\CommonSettings.props`.
Download Miniconda 2.7 64-bit Windows installer [from Miniconda website] (http://conda.pydata.org/miniconda.html).
Install for all users and add Python to PATH (through installer).

Run the following commands from elevated command prompt:

```
conda install --yes numpy scipy matplotlib scikit-image pip
pip install protobuf
```

#### Remark
After you have built solution with Python support, in order to use it you have to either:  
* set `PythonPath` environment variable to point to `<caffe_root>\Build\x64\Release\pycaffe`, or
* copy folder `<caffe_root>\Build\x64\Release\pycaffe\caffe` under `<python_root>\lib\site-packages`.

### Matlab
To build Caffe Matlab wrapper set `MatlabSupport` to `true` and `MatlabDir` to the root of your Matlab installation in `.\windows\CommonSettings.props`.

#### Remark
After you have built solution with Matlab support, in order to use it you have to:
* add the generated `matcaffe` folder to Matlab search path, and
* add `<caffe_root>\Build\x64\Release` to your system path.

### Build
Now, you should be able to build `.\windows\Caffe.sln`


_Note: SSD300* and SSD512* are the latest models. Current code should reproduce these results._

### Citing SSD

Please cite SSD in your publications if it helps your research:

    @inproceedings{liu2016ssd,
      title = {{SSD}: Single Shot MultiBox Detector},
      author = {Liu, Wei and Anguelov, Dragomir and Erhan, Dumitru and Szegedy, Christian and Reed, Scott and Fu, Cheng-Yang and Berg, Alexander C.},
      booktitle = {ECCV},
      year = {2016}
    }

### Contents
1. [Installation](#installation)
2. [Preparation](#preparation)
3. [Train/Eval](#traineval)
4. [Models](#models)

### Installation
1. Get the code. We will call the directory that you cloned Caffe into `$CAFFE_ROOT`
  ```Shell
  git clone https://github.com/weiliu89/caffe.git
  cd caffe
  git checkout ssd
  ```

2. Build the code. Please follow [Caffe instruction](http://caffe.berkeleyvision.org/installation.html) to install all necessary packages and build it.
  ```Shell
  # Modify Makefile.config according to your Caffe installation.
  cp Makefile.config.example Makefile.config
  make -j8
  # Make sure to include $CAFFE_ROOT/python to your PYTHONPATH.
  make py
  make test -j8
  # (Optional)
  make runtest -j8
  ```

### Preparation
1. Download [fully convolutional reduced (atrous) VGGNet](https://gist.github.com/weiliu89/2ed6e13bfd5b57cf81d6). By default, we assume the model is stored in `$CAFFE_ROOT/models/VGGNet/`

2. Download VOC2007 and VOC2012 dataset. By default, we assume the data is stored in `$HOME/data/`
  ```Shell
  # Download the data.
  cd $HOME/data
  wget http://host.robots.ox.ac.uk/pascal/VOC/voc2012/VOCtrainval_11-May-2012.tar
  wget http://host.robots.ox.ac.uk/pascal/VOC/voc2007/VOCtrainval_06-Nov-2007.tar
  wget http://host.robots.ox.ac.uk/pascal/VOC/voc2007/VOCtest_06-Nov-2007.tar
  # Extract the data.
  tar -xvf VOCtrainval_11-May-2012.tar
  tar -xvf VOCtrainval_06-Nov-2007.tar
  tar -xvf VOCtest_06-Nov-2007.tar
  ```

3. Create the LMDB file.
  ```Shell
  cd $CAFFE_ROOT
  # Create the trainval.txt, test.txt, and test_name_size.txt in data/VOC0712/
  ./data/VOC0712/create_list.sh
  # You can modify the parameters in create_data.sh if needed.
  # It will create lmdb files for trainval and test with encoded original image:
  #   - $HOME/data/VOCdevkit/VOC0712/lmdb/VOC0712_trainval_lmdb
  #   - $HOME/data/VOCdevkit/VOC0712/lmdb/VOC0712_test_lmdb
  # and make soft links at examples/VOC0712/
  ./data/VOC0712/create_data.sh
  ```

### Train/Eval
1. Train your model and evaluate the model on the fly.
  ```Shell
  # It will create model definition files and save snapshot models in:
  #   - $CAFFE_ROOT/models/VGGNet/VOC0712/SSD_300x300/
  # and job file, log file, and the python script in:
  #   - $CAFFE_ROOT/jobs/VGGNet/VOC0712/SSD_300x300/
  # and save temporary evaluation results in:
  #   - $HOME/data/VOCdevkit/results/VOC2007/SSD_300x300/
  # It should reach 77.* mAP at 120k iterations.
  python examples/ssd/ssd_pascal.py
  ```
  If you don't have time to train your model, you can download a pre-trained model at [here](http://www.cs.unc.edu/~wliu/projects/SSD/models_VGGNet_VOC0712_SSD_300x300.tar.gz).

2. Evaluate the most recent snapshot.
  ```Shell
  # If you would like to test a model you trained, you can do:
  python examples/ssd/score_ssd_pascal.py
  ```

3. Test your model using a webcam. Note: press <kbd>esc</kbd> to stop.
  ```Shell
  # If you would like to attach a webcam to a model you trained, you can do:
  python examples/ssd/ssd_pascal_webcam.py
  ```
  [Here](https://drive.google.com/file/d/0BzKzrI_SkD1_R09NcjM1eElLcWc/view) is a demo video of running a SSD500 model trained on [MSCOCO](http://mscoco.org) dataset.

4. Check out [`examples/ssd_detect.ipynb`](https://github.com/weiliu89/caffe/blob/ssd/examples/ssd_detect.ipynb) or [`examples/ssd/ssd_detect.cpp`](https://github.com/weiliu89/caffe/blob/ssd/examples/ssd/ssd_detect.cpp) on how to detect objects using a SSD model. Check out [`examples/ssd/plot_detections.py`](https://github.com/weiliu89/caffe/blob/ssd/examples/ssd/plot_detections.py) on how to plot detection results output by ssd_detect.cpp.

5. To train on other dataset, please refer to data/OTHERDATASET for more details. We currently add support for COCO and ILSVRC2016. We recommend using [`examples/ssd.ipynb`](https://github.com/weiliu89/caffe/blob/ssd/examples/ssd_detect.ipynb) to check whether the new dataset is prepared correctly.

### Models
We have provided the latest models that are trained from different datasets. To help reproduce the results in [Table 6](https://arxiv.org/pdf/1512.02325v4.pdf), most models contain a pretrained `.caffemodel` file, many `.prototxt` files, and python scripts.

1. PASCAL VOC models:
   * 07+12: [SSD300*](http://www.cs.unc.edu/~wliu/projects/SSD/models_VGGNet_VOC0712_SSD_300x300.tar.gz), [SSD512*](http://www.cs.unc.edu/~wliu/projects/SSD/models_VGGNet_VOC0712_SSD_512x512.tar.gz)
   * 07++12: [SSD300*](http://www.cs.unc.edu/~wliu/projects/SSD/models_VGGNet_VOC0712Plus_SSD_300x300.tar.gz), [SSD512*](http://www.cs.unc.edu/~wliu/projects/SSD/models_VGGNet_VOC0712Plus_SSD_512x512.tar.gz)
   * COCO<sup>[1]</sup>: [SSD300*](http://www.cs.unc.edu/~wliu/projects/SSD/models_VGGNet_VOC0712_SSD_300x300_coco.tar.gz), [SSD512*](http://www.cs.unc.edu/~wliu/projects/SSD/models_VGGNet_VOC0712_SSD_512x512_coco.tar.gz)
   * 07+12+COCO: [SSD300*](http://www.cs.unc.edu/~wliu/projects/SSD/models_VGGNet_VOC0712_SSD_300x300_ft.tar.gz), [SSD512*](http://www.cs.unc.edu/~wliu/projects/SSD/models_VGGNet_VOC0712_SSD_512x512_ft.tar.gz)
   * 07++12+COCO: [SSD300*](http://www.cs.unc.edu/~wliu/projects/SSD/models_VGGNet_VOC0712Plus_SSD_300x300_ft.tar.gz), [SSD512*](http://www.cs.unc.edu/~wliu/projects/SSD/models_VGGNet_VOC0712Plus_SSD_512x512_ft.tar.gz)

2. COCO models:
   * trainval35k: [SSD300*](http://www.cs.unc.edu/~wliu/projects/SSD/models_VGGNet_coco_SSD_300x300.tar.gz), [SSD512*](http://www.cs.unc.edu/~wliu/projects/SSD/models_VGGNet_coco_SSD_512x512.tar.gz)

3. ILSVRC models:
   * trainval1: [SSD300*](http://www.cs.unc.edu/~wliu/projects/SSD/models_VGGNet_ILSVRC2016_SSD_300x300.tar.gz), [SSD500](http://www.cs.unc.edu/~wliu/projects/SSD/models_VGGNet_ilsvrc15_SSD_500x500.tar.gz)

<sup>[1]</sup>We use [`examples/convert_model.ipynb`](https://github.com/weiliu89/caffe/blob/ssd/examples/convert_model.ipynb) to extract a VOC model from a pretrained COCO model.
