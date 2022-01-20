#!/usr/bin/env bash

source include/functions.sh
source include/colors.sh

MODEL_NAME=$(cat /sys/class/dmi/id/board_name)
MODEL_NAME=${MODEL_NAME// /-}

clear

echo "${BOLD}######### Available Block Devices${RESET}"
echo
lsblk -o NAME,FSTYPE,LABEL,SIZE,RO,MOUNTPOINT
echo

echo "${BOLD}######### Installation Setup${RESET}"
echo
read_input false "  Please enter EFI partition for boot manager : " "/dev/sda1" "/dev/sd[a-z][0-9]"
ESP_PATH=$RESULT
read_input false "  Please enter SYSTEM partition for ArchLinux : " "/dev/sda2" "/dev/sd[a-z][0-9]"
SYS_PATH=$RESULT
echo
read_input false "  Please enter hostname                       : " "ArchLinux-${MODEL_NAME}" "*"
HOSTNAME=$RESULT
read_input false "  Please enter username                       : " "user" "*"
USERNAME=$RESULT
echo

echo "${BOLD}######### Installation Information${RESET}"
echo
echo "  Boot manager will be install on ${GREEN}${ESP_PATH}${RESET}"
echo "  ArchLinux will be installed on ${GREEN}${SYS_PATH}${RESET}"
echo
echo "  Default root password is ${GREEN}root${RESET}"
echo "  Default ${USERNAME} password is ${GREEN}${USERNAME}${RESET}"
echo
echo
echo "${BOLD}****        Press ENTER to continue       ****${RESET}"
read -p "${BOLD}**** CTRL + C to terminate this script... ****${RESET}"

clear

echo "${BOLD}====== Installing Basic System ======${RESET}"
echo
echo "According to your Internet speed,"
echo "This operation will take 5-30 minutes."
echo
echo "Please wait patiently..."
echo
bash base.system.sh "${ESP_PATH}" "${SYS_PATH}" "${HOSTNAME}" "${USERNAME}" &> /tmp/install_system.log
if [[ $? == 0 ]]; then
    echo "${BOLD}${GREEN}****** Installation Finished! ******${RESET}"
else
    echo "${BOLD}${YELLOW}******        Installation Aborted!      ******${RESET}"
    echo "${BOLD}${YELLOW}****** Log File: /tmp/install_system.log ******${RESET}"
fi
