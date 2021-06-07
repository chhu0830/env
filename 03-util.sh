#!/usr/bin/env bash

set -e

echo "*******************"
echo "* Utility Install *"
echo "*******************"

OS=$(. /etc/os-release && echo $ID)
case $OS in
  arch)
    INS="powerpill"
    INSOPT="--noconfirm --needed -S"
    UPDOPT="--noconfirm -Syyu"
    ;;
  *)
    INS="apt"
    INSOPT="install -y"
    UPDOPT="update"
    ;;
esac

sudo $INS $UPDOPT

### Utilitiy Installation ###
sudo $INS $INSOPT zip unzip p7zip unrar
sudo $INS $INSOPT htop iftop iotop
sudo $INS $INSOPT ntfs-3g cifs-utils
sudo $INS $INSOPT httpie
# sudo $INS $INSOPT manpages-posix-dev glibc-doc

sudo $INS $INSOPT git tk
ln -b -s ${PWD}/config/gitconfig ${HOME}/.gitconfig

sudo $INS $INSOPT vim
ln -b -s ${PWD}/config/vimrc ${HOME}/.vimrc

sudo $INS $INSOPT tmux
git clone https://github.com/tmux-plugins/tpm ${HOME}/.tmux/plugins/tpm
ln -b -s ${PWD}/config/tmux.conf ${HOME}/.tmux.conf

sudo $INS $INSOPT screen
ln -b -s ${PWD}/config/screenrc ${HOME}/.screenrc
