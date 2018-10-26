#!/bin/sh

sudo cp ../config/docker/docker-tcp.socket /etc/systemd/system/
sudo chmod -x /etc/systemd/system/docker-tcp.socket
sudo systemctl enable docker-tcp.socket
sudo systemctl enable docker.socket
sudo systemctl stop docker
sudo systemctl start docker-tcp.socket
sudo systemctl start docker
