#!/usr/bin/env bash

set -e
# CFGDIR=${CFGDIR:-$(realpath $(dirname $0)/config)}
CFGDIR=./config

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
sudo $INS $INSOPT bzip2 libreadline-dev openssl
sudo $INS $INSOPT \
  make build-essential libssl-dev zlib1g-dev \
  libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
  libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
sudo pip3 install virtualenv
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
cat >> ${CFGDIR}/zcustom <<EOF
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
EOF


### goenv ###
sudo $INS $INSOPT golang
git clone https://github.com/syndbg/goenv.git ~/.goenv
cat >> ${CFGDIR}/zcustom <<EOF
export GOENV_GOPATH_PREFIX=${HOME}/.go
export GOENV_ROOT="${HOME}/.goenv"
export PATH="${GOENV_ROOT}/bin:$PATH"
eval "$(goenv init -)"
# export PATH="${GOROOT:+${GOROOT}/bin:}${PATH}"
# export PATH="${PATH}${GOPATH:+:${GOPATH}/bin}"
EOF
