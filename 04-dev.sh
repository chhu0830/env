#!/usr/bin/env bash

set -e

echo "***********************"
echo "* Development Install *"
echo "***********************"

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

sudo $INS $INSOPT gcc make


### pyenv ###
sudo $INS $INSOPT python3 python3-pip
# sudo $INS $INSOPT bzip2 libreadline-dev openssl
# sudo $INS $INSOPT \
#   make build-essential libssl-dev zlib1g-dev \
#   libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
#   libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
echo 'export PYENV_ROOT="${HOME}/.pyenv"' >> ${HOME}/.zshenv
echo 'export PATH="${PYENV_ROOT}/bin:${PATH}"' >> ${HOME}/.zshenv
echo 'eval "$(pyenv init --path)"' >> ${HOME}/.zshenv
echo 'eval "$(pyenv init -)"' >> ${HOME}/.zshenv
echo 'eval "$(pyenv virtualenv-init -)"' >> ${HOME}/.zshenv


### goenv ###
sudo $INS $INSOPT golang
git clone https://github.com/syndbg/goenv.git ~/.goenv
echo 'export GOENV_ROOT="${HOME}/.goenv"' >> ${HOME}/.zshenv
echo 'export PATH="${GOENV_ROOT}/bin:$PATH"' >> ${HOME}/.zshenv
echo 'eval "$(goenv init -)"' >> ${HOME}/.zshenv
# echo 'export PATH="${GOROOT}/bin:${PATH}"' >> ${HOME}/.zshenv
echo 'export PATH="${PATH}:${GOPATH}/bin"' >> ${HOME}/.zshenv
