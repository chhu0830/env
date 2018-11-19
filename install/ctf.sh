#!/bin/sh
DIR="$PWD/tools"
mkdir -p $DIR

sudo apt install binwalk hexer hexcurse
gem install zsteg

# stegsolve.jar
wget http://www.javadecompilers.com/jad/Jad%201.5.8e%20for%20Linux%20(statically%20linked).zip -O $DIR/jad.zip
unzip $DIR/jad.zip
rm $DIR/Readme.txt $DIR/jad.zip
