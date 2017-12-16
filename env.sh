#!/bin/bash

sudo apt update

read -p "Install basic env? (Y/n)" yn
[ "${yn}" == "Y" -o "${yn}" == "y" -o "${yn}" == "" ] && ./basic.sh

read -p "Install i386 env? (Y/n)" yn
[ "${yn}" == "Y" -o "${yn}" == "y" -o "${yn}" == "" ] && ./i386.sh

read -p "Install wine? (Y/n)" yn
[ "${yn}" == "Y" -o "${yn}" == "y" -o "${yn}" == "" ] && sudo apt install -y wine

read -p "Install LAMP? (Y/n)" yn
[ "${yn}" == "Y" -o "${yn}" == "y" -o "${yn}" == "" ] && ./lamp.sh

read -p "Install pwn env? (Y/n)" yn
[ "${yn}" == "Y" -o "${yn}" == "y" -o "${yn}" == "" ] && ./pwn.sh
