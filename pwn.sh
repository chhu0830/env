#!/bin/sh

sudo apt-get install -y git gdb
sudo git clone https://github.com/longld/peda.git /usr/local/peda
sudo git clone https://github.com/scwuaptx/Pwngdb /usr/local/Pwngdb
ln -s $PWD/.gdbinit ~/.gdbinit

sudo apt-get install -y python2.7 python-pip python-dev git libssl-dev libffi-dev build-essential
sudo pip install --upgrade pip
sudo pip install --upgrade pwntools

sudo apt-get install -y nmap
