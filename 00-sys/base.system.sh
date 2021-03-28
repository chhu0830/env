#!/usr/bin/env bash

set -e

if [[ $# != 4 ]]; then
    echo "Usage: $0 <EFI PARTITION> <SYSTEM PARTITION> <HOSTNAME> <USERNAME>"
    exit 1
fi

ESP_PATH=$1
SYS_PATH=$2
HOSTNAME=$3
USERNAME=$4

# Mount
mkfs.vfat -F32 -n ESP "${ESP_PATH}"
mkfs.ext4 -L ArchLinux "${SYS_PATH}"
mount "${SYS_PATH}" /mnt
mkdir -p /mnt/boot
mount "${ESP_PATH}" /mnt/boot

# Set Mirrorlist
cp files/mirrorlist /etc/pacman.d/mirrorlist

# Load kernel modules
modprobe efivarfs
modprobe dm-mod

# Execute pre-installation script
[[ -e pre-install.sh ]] && . pre-install.sh

# Install Base System
# pacstrap /mnt base base-devel intel-ucode networkmanager linux
pacstrap /mnt base base-devel linux linux-firmware intel-ucode amd-ucode logrotate networkmanager man-db man-pages nano perl


# Setup fstab
genfstab -U -p /mnt > /mnt/etc/fstab

# Prepare automatic shell script
cp files/chroot.sh /mnt/chroot.sh

# Arch-chroot
arch-chroot /mnt /bin/bash -c "bash chroot.sh '${HOSTNAME}' '${USERNAME}'"

# Execute post-install.sh
[[ -e post-install.sh ]] && . post-install.sh

# Unmount
umount -R /mnt
