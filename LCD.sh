#!/bin/bash

#download recquired files
cd \
&& wget http://www.hestiapi.com/download/LCD-show-170703.tar.gz \
&& tar xvf LCD-show-170703.tar.gz \
&& cd LCD-show/ \
&& sudo ./LCD35-show;

#Remove git files
sudo rm -rf /home/pi/LCD-show LCD-show-170703.tar.gz;

#Calibration
sudo dpkg -i ./LCD-show/xinput-calibrator_0.7.5-1_armhf.deb \
&& sudo rm -rf LCD-show* \
&& sudo mkdir /etc/X11/xorg.conf.d \
&& sudo touch /etc/X11/xorg.conf.d/99-calibration.conf \
&& echo 'Section "InputClass"
  Identifier        "calibration"
  MatchProduct        "ADS7846 Touchscreen"
  Option        "Calibration"          "3900 218 246 3832"
EndSection' | sudo tee /etc/X11/xorg.conf.d/99-calibration.conf;

#To get more precise touch, adjust the 4 numbers according to YOUR calibration output by running the calibration utility from the LCD's GUI menu or over pushed from the SSH to your LCD with this command: sudo DISPLAY=:0.0 xinput_calibrator
