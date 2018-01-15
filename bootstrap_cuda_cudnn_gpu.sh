#!/bin/bash

set -euo pipefail

# install prerequsities 
echo "Install build tools"
sudo -H apt-get -qq -y update
sudo -H apt-get -qq -y install build-essential linux-headers-generic linux-image-extra-virtual
sudo -H apt-get -qq -y install build-essential git libfreetype6-dev libxft-dev libncurses-dev libopenblas-dev gfortran libblas-dev liblapack-dev libcupti-dev libatlas-base-dev wget pkg-config zip g++ zlib1g-dev libcurl3-dev curl unzip 

## Install Anaconda python3
echo "Install Anaconda python"
cd ~
wget https://repo.continuum.io/archive/Anaconda3-5.0.1-Linux-x86_64.sh
bash Anaconda3-5.0.1-Linux-x86_64.sh -b -p $HOME/anaconda3
rm Anaconda3-5.0.1-Linux-x86_64.sh 
echo 'export PATH=$HOME/anaconda3/bin:$PATH' >> ~/.bashrc


# Install official NVIDIA driver package
sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub
sudo sh -c 'echo "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64 /" > /etc/apt/sources.list.d/cuda.list'
sudo apt-get update && sudo apt-get install -y --no-install-recommends linux-headers-generic dkms cuda-drivers

#sudo -H apt-get -y install python-dev python-pip python-wheel
#sudo -H pip install --upgrade pip

## insall CUDA 9.0 Latest
echo "Install CUDA"
cd ~
wget "http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_9.0.176-1_amd64.deb"
sudo dpkg -i cuda-repo-ubuntu1604_9.0.176-1_amd64.deb 
sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub 
#rm cuda-repo-ubuntu1604-9-0-local_9.0.176-1_amd64-deb 
sudo -H apt-get -qq -y update 
sudo -H apt-get install -y cuda

# instal cudnn
echo  "Install CuDNN"
CUDNN_RUNTIME_FILE="libcudnn7_7.0.4.31-1+cuda9.0_amd64.deb"
wget https://s3-ap-southeast-1.amazonaws.com/ccevg-qwwzqgchmv4kbz04735/cuDNN/libcudnn7_7.0.4.31-1%2Bcuda9.0_amd64.deb
sudo dpkg -i ${CUDNN_RUNTIME_FILE}
CUDNN_DEV_FILE="libcudnn7-dev_7.0.4.31-1+cuda9.0_amd64.deb"
wget https://s3-ap-southeast-1.amazonaws.com/ccevg-qwwzqgchmv4kbz04735/cuDNN/libcudnn7-dev_7.0.4.31-1%2Bcuda9.0_amd64.deb
sudo dpkg -i ${CUDNN_DEV_FILE}
CUDNN_DOC_FILE="libcudnn7-doc_7.0.4.31-1+cuda9.0_amd64.deb"
wget https://s3-ap-southeast-1.amazonaws.com/ccevg-qwwzqgchmv4kbz04735/cuDNN/libcudnn7-doc_7.0.4.31-1%2Bcuda9.0_amd64.deb
sudo dpkg -i ${CUDNN_DOC_FILE}

# set library path
echo "Setting Library Paths"
echo 'export CUDA_HOME=/usr/local/cuda
export CUDA_ROOT=/usr/local/cuda
export PATH=$PATH:$CUDA_ROOT/bin:$HOME/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CUDA_ROOT/lib64
' >> ~/.bashrc


## Install Tensorflow (using nvidia-docker)
echo "Install Tensorflow"
export TF_BINARY_URL='https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-1.4.0-cp36-cp36m-linux_x86_64.whl'
$HOME/anaconda3/bin/pip install $TF_BINARY_URL

#install monitoring programs
$HOME/anaconda3/bin/pip install git+https://github.com/wookayin/gpustat.git@master
sudo nvidia-smi daemon
sudo -H apt-get -y install htop

#reload .bashrc
exec bash

echo "Finished Installation"