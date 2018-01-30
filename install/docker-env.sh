#!/bin/sh

apt update
apt install -y git htop net-tools wget time man sudo curl
apt install -y software-properties-common iputils-ping
./env.sh
