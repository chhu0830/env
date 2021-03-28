#!/usr/bin/env bash

set -e

if [[ $# != 2 ]]; then
    echo "Usage: $0 <HOSTNAME> <USERNAME>"
    exit 1
fi

HOSTNAME=$1
USERNAME=$2
KERNEL_NAME=linux
ROOT_PARTUUID=$(blkid -s PARTUUID -o value $(df -h / | grep '^/dev' | awk '{ print $1 }'))

# Setup hostname
echo "${HOSTNAME}" > /etc/hostname

# Setup default root password
echo -e "root\nroot\n" | passwd

# Setup timezone
rm -rf /etc/localtime
ln -s /usr/share/zoneinfo/Asia/Taipei /etc/localtime

# Generate and setup locale information
sed -i "s/#en_US/en_US/g" /etc/locale.gen
sed -i "s/#zh_TW/zh_TW/g" /etc/locale.gen
locale-gen

echo "LANG=\"en_US.UTF-8\"" > /etc/locale.conf

# Setup sysctl parameters
cat << EOF > /etc/sysctl.d/99-sysctl.conf
# Enable IPv6 Privacy Extensions
net.ipv6.conf.all.use_tempaddr = 2
net.ipv6.conf.default.use_tempaddr = 2

# Change inotify watch limit
fs.inotify.max_user_watches = 524288

# Setup swappiness
vm.swappiness = 10

# Enable SysRq function
kernel.sysrq = 1
EOF

# Setup I/O schedulers
cat << EOF > /etc/udev/rules.d/60-ioschedulers.rules
# set scheduler for non-rotating disks
ACTION=="add|change", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="0", ATTR{queue/scheduler}="mq-deadline"

# set scheduler for rotating disks
ACTION=="add|change", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="1", ATTR{queue/scheduler}="bfq"
EOF

# Setup fstrimer
mkdir -p /etc/systemd/system/fstrim.timer.d/

cat << EOF > /etc/systemd/system/fstrim.timer.d/override.conf
[Timer]
OnCalendar=
OnCalendar=daily
EOF

# Disable core dump for all processes
mkdir -p /etc/security/limits.d
echo "* hard core 0" > /etc/security/limits.d/99-disable-core-dump.conf

# Add repositories
cat << EOF >> /etc/pacman.conf

[xyne-any]
SigLevel = Required
Server = https://xyne.archlinux.ca/bin/repo.php?file=

[xyne-x86_64]
SigLevel = Required
Server = https://xyne.archlinux.ca/bin/repo.php?file=
EOF

# Add required keys
touch /root/.gnupg/dirmngr_ldapservers.conf
dirmngr < /dev/null
pacman-key --recv-keys 5EE46C4C && pacman-key --lsign-key 5EE46C4C

# Install linux-ck, basic services and utilities
pacman --noconfirm -Syy
if [[ $(pacman -Qq linux) == "linux" ]]; then
    pacman --noconfirm -R linux
fi
pacman --noconfirm --needed -S ${KERNEL_NAME}
pacman --noconfirm --needed -S ${KERNEL_NAME}-headers
pacman --noconfirm --needed -S efibootmgr
pacman --noconfirm --needed -S wget ntp openssh dhclient nftables

# Generate initramfs
mkinitcpio -p ${KERNEL_NAME}

# Install boot loader
bootctl --path=/boot install

echo "default linux" > /boot/loader/loader.conf
cat << EOF >> /boot/loader/entries/linux.conf
title ArchLinux
linux /vmlinuz-${KERNEL_NAME}
initrd /intel-ucode.img
initrd /initramfs-${KERNEL_NAME}.img
options root=PARTUUID=${ROOT_PARTUUID}
options scsi_mod.use_blk_mq=y
options dm_mod.use_blk_mq=y
EOF

mkdir -p /etc/pacman.d/hooks
cat << EOF >> /etc/pacman.d/hooks/systemd-boot.hook
[Trigger]
Type = Package
Operation = Upgrade
Target = systemd

[Action]
Description = Updating systemd-boot
When = PostTransaction
Exec = /usr/bin/bootctl update
EOF

# Add user to wheel group and make wheel group be sudoers
useradd -m -G wheel "${USERNAME}"
echo -e "${USERNAME}\n${USERNAME}\n" | passwd "${USERNAME}"
sed -i "s/^#\s*\(%wheel\s\+ALL=(ALL)\s\+ALL\)/\1/" /etc/sudoers

# Enable services
systemctl enable ntpd
systemctl enable sshd
systemctl enable nftables
systemctl enable NetworkManager
systemctl enable fstrim.timer

# Cleanup
rm chroot.sh
