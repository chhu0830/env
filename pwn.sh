#!/bin/sh

sudo apt install -y git gdb
git clone https://github.com/scwuaptx/peda.git ~/.peda
git clone https://github.com/scwuaptx/Pwngdb ~/.Pwngdb
cp ~/.peda/.inputrc ~/
ln -s $PWD/.gdbinit ~/.gdbinit

sudo apt install -y python2.7 python-pip python-dev git libssl-dev libffi-dev build-essential
sudo pip install --upgrade pip
sudo pip install --upgrade setuptools ropgadget
sudo pip install --upgrade pwntools angr

sudo apt install -y nmap

curl -sSL https://rvm.io/mpapis.asc | gpg --import
curl -L https://get.rvm.io | bash -s stable --ruby
zsh -c "source .zshrc && gem install one_gadget"

git clone https://github.com/guelfoweb/knock.git ~/.knock
mv ~/.knock/knockpy/knockpy.py ~/.knock/knockpy/knockpy
sudo chmod +x ~/.knock/knockpy/knockpy

wget -c 'http://sourceforge.net/projects/dirb/files/dirb/2.03/dirb203.tar.gz/download' -O dirb203.tar.gz
tar -zxvf dirb203.tar.gz
cd dirb
sudo apt install libcurl4-gnutls-dev
./configure
make
sudo make install
cd ..
sudo mv -f dirb /usr/share/dirb

sudo apt install build-essential python-pip libyaml-dev python-dev
sudo pip install --upgrade prettytable Mako PyYAML python-dateutil PySocks
git clone https://github.com/epinna/weevely3.git ~/.weevely
mv ~/.weevely/weevely.py ~/.weevel/weevely
sudo chmod +x ~/.weevely3/weevely
