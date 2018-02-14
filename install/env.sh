#!/bin/bash
URL="https://raw.githubusercontent.com/chhu0830/env/master/install"
DIR="$HOME/.env"

sudo apt update

read -p "Where do you want to put your config file? ($DIR) " dir
[ "${dir}" != "" ] && DIR=${dir}
mkdir -p $DIR
cd $DIR

read -p "Install basic env? (Y/n) " yn
[ "${yn}" == "Y" -o "${yn}" == "y" -o "${yn}" == "" ] && sh -c "$(curl -fsSL $URL/basic.sh)"

read -p "Install i386 env? (Y/n) " yn
[ "${yn}" == "Y" -o "${yn}" == "y" -o "${yn}" == "" ] && sh -c "$(curl -fsSL $URL/i386.sh)"

read -p "Install LaTeX? (Y/n) " yn
[ "${yn}" == "Y" -o "${yn}" == "y" -o "${yn}" == "" ] && sh -c "$(curl -fsSL $URL/latex.sh)"

read -p "Install LAMP? (Y/n) " yn
[ "${yn}" == "Y" -o "${yn}" == "y" -o "${yn}" == "" ] && sh -c "$(curl -fsSL $URL/lamp.sh)"

read -p "Install pwn env? (Y/n) " yn
[ "${yn}" == "Y" -o "${yn}" == "y" -o "${yn}" == "" ] && sh -c "$(curl -fsSL $URL/pwn.sh)"

read -p "Install penetration env? (Y/n) " yn
[ "${yn}" == "Y" -o "${yn}" == "y" -o "${yn}" == "" ] && sh -c "$(curl -fsSL $URL/penetration.sh)"
