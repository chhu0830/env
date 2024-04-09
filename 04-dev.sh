#!/usr/bin/env bash

set -e
# CFGDIR=${CFGDIR:-$(realpath $(dirname $0)/config)}
CFGDIR="${PWD}/config"

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
cat > ${CFGDIR}/zcustom/pyenv.zsh <<EOF
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PYENV_ROOT="\${HOME}/.pyenv"
export PATH="\${PYENV_ROOT}/bin:\${PATH}"
type pyenv &> /dev/null && eval "\$(pyenv init --path)"
type pyenv &> /dev/null && eval "\$(pyenv init -)" 
type pyenv &> /dev/null && eval "\$(pyenv virtualenv-init -)"
EOF


### goenv ###
sudo $INS $INSOPT golang
git clone https://github.com/syndbg/goenv.git ~/.goenv
cat > ${CFGDIR}/zcustom/goenv.zsh <<EOF
function goenv_init_path {
PATH="\$(bash --norc -ec 'IFS=:; paths=(\${PATH});
for i in \${!paths[@]}; do
if [[ \${paths[i]} == "''\${GOENV_ROOT}/shims''" ]]; then unset '\''paths[i]'\'';
fi; done;
echo "\${paths[*]}"')"
export PATH="\${GOENV_ROOT}/shims:\${PATH}"
}

export GOENV_GOPATH_PREFIX="\${HOME}/.go"
export GOENV_ROOT="\${HOME}/.goenv"
export PATH="\${GOENV_ROOT}/bin:\${PATH}"
type goenv &> /dev/null && eval "\$(goenv init -)"
type goenv &> /dev/null && goenv_init_path
# export PATH="\${GOROOT:+\${GOROOT}/bin:}\${PATH}"
# export PATH="\${PATH}\${GOPATH:+:\${GOPATH}/bin}"
EOF


### nvm ###
sudo $INS $INSOPT nodejs
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
cat > ${CFGDIR}/zcustom/nvm.zsh <<EOF
export NVM_DIR="\$([ -z "\${XDG_CONFIG_HOME-}"  ] && printf %s "\${HOME}/.nvm" || printf %s "\${XDG_CONFIG_HOME}/nvm")"
[ -s "\${NVM_DIR}/nvm.sh"  ] && \. "\${NVM_DIR}/nvm.sh" # This loads nvm
[ -s "\${NVM_DIR}/bash_completion"  ] && \. "\${NVM_DIR}/bash_completion"  # This loads nvm bash_completion
EOF
