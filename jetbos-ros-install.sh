#!/bin/bash

cd ~/workspace/catkin_ws/src
git clone https://github.com/dusty-nv/jetbot_ros
cd ../ 
catkin_make
