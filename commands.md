Commands for Jetson Nano

# Start chromium and make default
open chrome://flags and disable smooth scroll
open preferences and let chrome open with previous tabs

# Python 3
sudo apt-get install python3-pip libhdf5-serial-dev hdf5-tools

### The following follows the guide:
https://medium.com/@feicheung2016/getting-started-with-jetson-nano-and-autonomous-donkey-car-d4f25bbd1c83

# Install Nivida GPIO
https://github.com/NVIDIA/jetson-gpio?source=post_page---------------------------
## Download the .zip file to Downloads
sudo unzip ~/Downloads/jetson-gpio-master.zip -d /opt/nvidia/
sudo mv /opt/nvidia/jetson-gpio-master /opt/nvidia/jetson-gpio
cd /opt/nvidia/jetson-gpio
sudo python3 setup.py install
## Add user
sudo groupadd -f -r gpio
sudo usermod -a -G gpio jetbot
sudo cp /opt/nvidia/jetson-gpio/etc/99-gpio.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules && sudo udevadm trigger
sudo reboot
## Try a sample which reads all pins:
python3 /opt/nvidia/jetson-gpio/samples/simple_input.py

# Install Python GPIO library
pip3 install Adafruit_PCA9685
## Test connection
sudo i2cdetect -y -r 1
## Add user
sudo usermod -a -G i2c jetbot
sudo reboot
## Check groups
groups
## Should display at least i2c

### Guide stopped
-----------------

### The following follows the guide
https://github.com/dusty-nv/jetbot_ros

# Install ROS Medolic
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
sudo apt-get update
sudo apt-get -y install ros-melodic-ros-base
sudo rosdep init
rosdep update
sudo sh -c 'echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc'
source ~/.bashrc
sudo apt install python-rosinstall python-rosinstall-generator python-wstool build-essential

# Install Adafruit libraries
sudo apt-get install python-pip
pip install Adafruit-MotorHAT Adafruit-SSD1306
sudo reboot

# Create Catkin workspace
mkdir -p ~/workspace/catkin_ws/src
cd ~/workspace/catkin_ws
catkin_make
sudo sh -c 'echo "source ~/workspace/catkin_ws/devel/setup.bash" >> ~/.bashrc'

# Build Jetson inference
sudo apt-get install git cmake qt4-qmake libqt4-dev libglew-dev
cd ~/workspace
git clone -b onnx https://github.com/dusty-nv/jetson-inference
cd jetson-inference
git submodule update --init
mkdir build
cd build
cmake ../
make
sudo make install

# Build Jetbot ROS
cd ~/workspace/catkin_ws/src
git clone https://github.com/dusty-nv/jetbot_ros
cd ../ & catkin_make
## Confirm that jetbot_ros can be found
rospack find jetbot_ros
