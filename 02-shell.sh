#!/usr/bin/env bash

set -e

echo "***************"
echo "* ZSH Install *"
echo "***************"

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

# sudo $INS $UPDOPT
sudo $INS $INSOPT curl git

# Install zsh
sudo ${INS} ${INSOPT} zsh
ln -b -s ${PWD}/config/zshrc ${HOME}/.zshrc

# FIXME: ${USER} not set in docker
sudo usermod --shell $(which zsh) ${USER}

# sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
