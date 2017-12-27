#!/bin/bash
sudo apt-get install cmake qt5-default libqt5svg5-dev git 
git clone https://github.com/radare/radare2
cd radare2; ./sys/install.sh; cd ..

git clone https://github.com/radareorg/cutter
cd cutter/src; mkdir build; cd build
cmake ..; make
