#!/bin/sh
URL="https://raw.githubusercontent.com/chhu0830/env/master/config/pwn"
DIR=$PWD/config/pwn
mkdir -p $DIR

sudo apt install -y git gdb
git clone https://github.com/scwuaptx/peda.git ~/.peda
git clone https://github.com/scwuaptx/Pwngdb ~/.Pwngdb
cp $HOME/.peda/.inputrc $HOME/
curl -fsSL $URL/.gdbinit > $DIR/.gdbinit
ln -s $DIR/.gdbinit $HOME/.gdbinit

sudo apt install -y python2.7 python-pip python-dev git libssl-dev libffi-dev build-essential
sudo pip install --upgrade pip
sudo pip install --upgrade setuptools ropgadget
sudo pip install --upgrade pwntools angr

sudo apt install -y nmap

curl -sSL https://rvm.io/mpapis.asc | gpg --import
curl -L https://get.rvm.io | bash -s stable --ruby
zsh -c "source .zshrc && gem install one_gadget"
