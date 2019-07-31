Commands for Jetson Nano

sudo apt-get install -y tmux ranger

# Make jetbot not lock after 5 minutes

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
cd ~/Downloads
git clone https://github.com/NVIDIA/jetson-gpio.git
sudo mv ~/Downloads/jetson-gpio /opt/nvidia/
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
pip install Adafruit_PCA9685
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

### Python code for running the motors
python
pwm = Adafruit_PCA9685.PCA9685(busnum=1)
pwm.set_pwm_freq(60)
pwm.set_pwm(1, 0, 150) # Sets speed on channel 1
pwm.set_pwm(1, 0, 0) # Sets 0 speed on channel 1

### The following follows the guide
https://github.com/dusty-nv/jetbot_ros

# Install ROS Medolic. Now put into ros-melodic-install.sh
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
sudo apt-get update
sudo apt-get -y install ros-melodic-ros-base
sudo rosdep init
rosdep update
sudo sh -c 'echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc'
source ~/.bashrc
sudo apt-get -y install python-rosinstall python-rosinstall-generator python-wstool build-essential

# Install Adafruit libraries
sudo apt-get -y install python-pip
pip install Adafruit-MotorHAT Adafruit-SSD1306
sudo usermod -aG i2c jetbot
sudo reboot

# Create Catkin workspace
mkdir -p ~/workspace/catkin_ws/src
cd ~/workspace/catkin_ws
catkin_make
sudo sh -c 'echo "source ~/workspace/catkin_ws/devel/setup.bash" >> ~/.bashrc'

# Build Jetson inference. Part of jetson-inference-install.sh
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

# Build ros-deep-learning. Part of ros-deep-learning-install.sh
sudo apt-get -y install ros-melodic-vision-msgs ros-melodic-image-transport ros-melodic-image-publisher
cd ~/workspace/catkin_ws/src
git clone https://github.com/dusty-nv/ros_deep_learning
cd ../
catkin_make

# Build Jetbot ROS. Part of jetbos-ros-install.sh
cd ~/workspace/catkin_ws/src
git clone https://github.com/dusty-nv/jetbot_ros
cd ../ 
catkin_make
## Confirm that jetbot_ros can be found
rospack find jetbot_ros

### Guide stopped
-----------------



### Trying for myself
# sudo apt-get -y install git build-essential python-dev
# cd ~/Documents
# git clone https://github.com/adafruit/Adafruit_Python_PCA9685.git
# cd Adafruit_Python_PCA9685
# sudo python setup.py install

# Install servokit
## https://www.jetsonhacks.com/2019/07/22/jetson-nano-using-i2c/
# cd ~/Documents
# git clone https://github.com/JetsonHacksNano/ServoKit.git
# cd ServoKit
# chmod +x installServoKit.sh
# sudo ./installServoKit.sh
