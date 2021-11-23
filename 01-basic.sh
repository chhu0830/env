#!/usr/bin/env bash

set -e
CFGDIR=${CFGDIR:-$(realpath $(dirname $0)/config)}

echo "*********************"
echo "* Basic Environment *"
echo "*********************"

. /etc/os-release
case ${ID} in
  arch)
    echo  ""
    echo  "  The operating system is \`$OS\`."
    echo  "  \`Powerpill\` and \`yay\` will be installed." 
    echo  ""
    echo  "****     Press ENTER to continue    ****"
    read -p "**** CTRL + C to terminate this script... ****"

    clear

    ### powerpill Installation ###
    echo "==== Installing powerpill... ===="

    # FIXME: This will use hkp:// instead of hkps://
    echo 'keyserver hkps.pool.sks-keyservers.net' | sudo tee -a /etc/pacman.d/gnupg/gpg.conf
    sudo pacman-key -u --refresh-keys
    # gpg --recv-keys 1D1F0DC78F173680 # It does not work
    gpg --import <(pacman-key --export 1D1F0DC78F173680)
    sudo pacman -Syyu
    sudo pacman --noconfirm --needed -S powerpill

    clear

    ### yay Install ###
    echo "==== Installing yay... ===="
    mkdir -p /tmp/yay
    pushd /tmp/yay
    wget 'https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=yay' -O PKGBUILD
    makepkg -si --noconfirm
    popd

    CPU_COUNT=$(grep '^cpu\scores' /proc/cpuinfo | uniq | awk '{ print $4 }')
    sudo sed -i "s/#MAKEFLAGS=\"-j2\"/MAKEFLAGS=\"-j$((CPU_COUNT * 3 / 2))\"/g" /etc/makepkg.conf
    sudo sed -i "s/\.pkg\.tar\.xz/\.pkg\.tar/g" /etc/makepkg.conf

    sudo perl -i -0pe 's/\[core\]\nInclude/\[core\]\nSigLevel = PackageRequired\nInclude/g' /etc/pacman.conf
    sudo perl -i -0pe 's/\[extra\]\nInclude/\[extra\]\nSigLevel = PackageRequired\nInclude/g' /etc/pacman.conf
    sudo perl -i -0pe 's/\[community\]\nInclude/\[community\]\nSigLevel = PackageRequired\nInclude/g' /etc/pacman.conf
    sudo perl -i -0pe 's/#\[multilib\]\n#Include/\[multilib\]\nSigLevel = PackageRequired\nInclude/g' /etc/pacman.conf
    ;;
  *)
    echo ""
    echo "  The operating system is $OS."
    echo "  Nothing to be installed."
    echo ""
esac

if [[ -n ${WSL_DISTRO_NAME} ]]; then
  cat > /etc/wsl.conf <<-EOF
  [user]
  default = ${USER}
  
  [automount]
  enabled = true
  root = /mnt/
  options = "metadata,umask=022,fmask=111"
  mountFsTab = true
  EOF

  cat >> /etc/fstab <<-EOF
  C:\                     /mnt/c  drvfs   rw,noatime,dirsync,aname=drvfs,path=C:\,uid=1000,gid=1000,metadata,umask=022,fmask=011,symlinkroot=/mnt/,mmap,access=client,msize=65536,trans=fd,rfd=8,wfd=8    0 0
  EOF
    
  crontab <<-EOF
  $(crontab -l)
  @reboot rm -rf /tmp/*
  @reboot mkdir -m 777 /run/screen
  @daily echo 1 > /proc/sys/vm/compact_memory
  EOF
fi

echo "==== $0 successfully finished ===="
