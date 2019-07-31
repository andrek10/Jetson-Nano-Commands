#!/bin/bash

sudo apt-get -y install git cmake qt4-qmake libqt4-dev libglew-dev
cd ~/workspace
git clone -b onnx https://github.com/dusty-nv/jetson-inference
cd jetson-inference
git submodule update --init
mkdir build
cd build
cmake ../
make
sudo make install
