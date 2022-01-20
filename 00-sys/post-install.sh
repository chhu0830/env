#!/usr/bin/env bash

set -e

source include/functions.sh
source include/colors.sh

USER=$1

clear

echo "${BOLD}######### Mount Windows SMB${RESET}"
echo
read_input false "  Please enter windows IP and path : " "//192.168.0.1/D" "\/\/(([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])\.{0,1}){4}\/.*"
WINDOWS=$RESULT
read_input false "  Please enter windows username    : " "user" ".*"
USERNAME=$RESULT
read_input false "  Please enter windows password    : " "pass" ".*"
PASSWORD=$RESULT
read_input false "  Please enter mount point         : " "/mnt/windows" ".*"
MOUNTPOINT=$RESULT
echo

pacman --noconfirm --needed -S cifs-utils
mkdir -p $MOUNTPOINT
echo "$WINDOWS  $MOUNTPOINT cifs    rw,_netdev,exec,dir_mode=0755,uid=$USER,gid=$USER,user=$USERNAME,password=$PASSWORD 0   0" >> /etc/fstab
echo 
