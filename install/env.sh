#!/bin/bash
DIR="$HOME/.env"

read -p "Where do you want to put your config file? ($DIR) " dir
[ "${dir}" != "" ] && DIR=${dir}

sudo apt update
sudo apt install -y git
git clone https://github.com/chhu0830/env ${DIR}
cd $DIR

read -p "Install basic env? (Y/n) " yn
[ "${yn}" == "Y" -o "${yn}" == "y" -o "${yn}" == "" ] && ./install/basic.sh

read -p "Install i386 env? (Y/n) " yn
[ "${yn}" == "Y" -o "${yn}" == "y" -o "${yn}" == "" ] && ./install/i386.sh

read -p "Install LaTeX? (Y/n) " yn
[ "${yn}" == "Y" -o "${yn}" == "y" -o "${yn}" == "" ] && ./install/latex.sh

read -p "Install LAMP? (Y/n) " yn
[ "${yn}" == "Y" -o "${yn}" == "y" -o "${yn}" == "" ] && ./install/lamp.sh

read -p "Install pwn env? (Y/n) " yn
[ "${yn}" == "Y" -o "${yn}" == "y" -o "${yn}" == "" ] && ./install/pwn.sh

read -p "Install penetration env? (Y/n) " yn
[ "${yn}" == "Y" -o "${yn}" == "y" -o "${yn}" == "" ] && ./install/penetration.sh

read -p "Install ctf env? (Y/n) " yn
[ "${yn}" == "Y" -o "${yn}" == "y" -o "${yn}" == "" ] && ./install/ctf.sh
