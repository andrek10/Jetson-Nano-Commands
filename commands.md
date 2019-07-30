Commands for Jetson Nano

# Python 3
sudo apt-get install python3-pip libhdf5-serial-dev hdf5-tools

### The following follows the guide:
https://medium.com/@feicheung2016/getting-started-with-jetson-nano-and-autonomous-donkey-car-d4f25bbd1c83

# Install Nivida GPIO
https://github.com/NVIDIA/jetson-gpio?source=post_page---------------------------
## Download the .zip file to Downloads
sudo unzip ~/Downloads/jetson-gpio-master.zip -d /opt/nvidia/
mv /opt/nvidia/jetson-gpio-master /opt/nvidia/jetson-gpio
sudo python3 /opt/nvidia/jetson-gpio/setup.py install
## Add user
sudo groupadd -f -r gpio
sudo usermod -a -G gpio jetbot
sudo cp /opt/nvidia/jetson-gpio/etc/99-gpio.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules && sudo udevadm trigger
## May need to restart, or run command above this comment
## Try a sample which reads all pins:
python3 /opt/nvidia/jetson-gpio-master/samples/simple_input.py

# Install Python GPIO library
pip3 install Adafruit_PCA9685
## Test connection
sudo /opt/nvidia i2cdetect -y -r 1
## Add user
sudo usermod -a -G i2c jetbot
sudo reboot
## Check groups
groups
## Should display at least i2c

### Guide stopped
-----------------
