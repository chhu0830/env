#!/bin/sh

sudo apt-get install -y git gdb
sudo git clone https://github.com/scwuaptx/peda.git /usr/local/peda
sudo git clone https://github.com/scwuaptx/Pwngdb /usr/local/Pwngdb
cp /usr/local/peda/.inputrc ~/
ln -s $PWD/.gdbinit ~/.gdbinit

sudo apt-get install -y python2.7 python-pip python-dev git libssl-dev libffi-dev build-essential
sudo pip install --upgrade pip
sudo pip install --upgrade setuptools
sudo pip install --upgrade pwntools
sudo pip install --upgrade ropgadget

sudo apt-get install -y nmap
