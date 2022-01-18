#!/usr/bin/env bash

set -e
# CFGDIR=${CFGDIR:-$(realpath $(dirname $0)/config)}
CFGDIR=./config

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

sudo $INS $UPDOPT

### zsh Installation ###
sudo ${INS} ${INSOPT} curl git zsh
ln -b -s ${CFGDIR}/zshrc ${HOME}/.zshrc
ln -b -s ${HOME}/.profile ${HOME}/.zprofile

# FIXME: ${USER} not set in docker
sudo usermod --shell $(which zsh) ${USER}

# sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
