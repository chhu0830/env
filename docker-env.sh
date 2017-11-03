#!/bin/sh

sudo apt-get update
sudo apt-get install -y git htop net-tools
sudo apt-get install -y software-properties-common

./env.sh
