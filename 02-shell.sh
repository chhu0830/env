#!/usr/bin/env bash

set -e
# CFGDIR=${CFGDIR:-$(realpath $(dirname $0)/config)}
CFGDIR="${PWD}/config"

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
ln -b -s ${CFGDIR}/system/home/.zshrc ${HOME}/.zshrc
ln -b -s ${HOME}/.profile ${HOME}/.zprofile

# FIXME: ${USER} not set in docker
sudo ${INS} ${INSOPT} gcc make libncurses5-dev libncursesw5-dev
sudo usermod --shell $(which zsh) ${USER}

exec zsh -il
# https://wiki.zshell.dev/docs/getting_started/installation
# sh -c "$(curl -fsSL get.zshell.dev)" --
