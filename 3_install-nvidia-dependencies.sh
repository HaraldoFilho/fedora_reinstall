#!/bin/bash

# Code extracted from: https://www.if-not-true-then-false.com/2015/fedora-nvidia-guide/

# system update
sudo dnf -y update

# Install nvidia dependencies
sudo dnf -y install kernel-devel kernel-headers gcc make dkms acpid libglvnd-glx libglvnd-opengl libglvnd-devel pkgconfig

# Check if kernel files are syncronized
echo "---------------------------------------------------------------------------------------------------------"
uname -a
rpm -qa | grep -E "kernel-devel|kernel-headers"
echo "---------------------------------------------------------------------------------------------------------"
echo -n "All kernel versions match? (yes/[no]): "
read answer
if [[ $answer != 'yes' ]];
  then
    echo "Trying to sync all packages..."
    sudo dnf -y distro-sync
    echo "System will be rebooted. When finished, run this script again and check kernel versions."
fi

echo "Press ENTER to reboot or 'Ctrl +C' to abort"
read enter
sudo reboot

