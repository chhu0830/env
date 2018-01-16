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
sudo chmod +x ~/.knock/knockpy/knockpy.py
