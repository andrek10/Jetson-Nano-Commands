#!/bin/bash

sudo apt-get -y install ros-melodic-vision-msgs ros-melodic-image-transport ros-melodic-image-publisher
cd ~/workspace/catkin_ws/src
git clone https://github.com/dusty-nv/ros_deep_learning
cd ../
catkin_make
