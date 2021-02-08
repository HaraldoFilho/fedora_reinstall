#!/bin/bash

# Code extracted from: https://www.if-not-true-then-false.com/2015/fedora-nvidia-guide/

if [[ $HOME != '/root' ]];
  then
    echo "ERROR: This script must be run as root!"
    exit 1
fi

if ! compgen -G "runfiles/NVIDIA-Linux-x86_64-*.run" > /dev/null;
  then
    echo "! No NVIDIA driver installer has been found on directory 'runfiles'."
    echo "! A NVIDIA driver installer is needed before removing Nouveau."
    exit 1
  else
    chmod 755 runfiles/NVIDIA-Linux-x86_64-*.run
fi

# Disable nouveau
echo "blacklist nouveau" >> /etc/modprobe.d/blacklist.conf

# Edit /etc/sysconfig/grub
echo "Edit '/etc/sysconfig/grub'"
echo "When editor opens, do the following:"
echo " "
echo "- Change GRUB_TIMEOUT value from 5 to 0"
echo "eg. Old: GRUB_TIMEOUT=5"
echo "    New: GRUB_TIMEOUT=0"
echo " "
echo "- Append 'rd.driver.blacklist=nouveau' to the end of GRUB_CMDLINE_LINUX"
echo "eg. Old: GRUB_CMDLINE_LINUX=\"resume=UUID=(...) rhgb quiet\""
echo "    New: GRUB_CMDLINE_LINUX=\"resume=UUID=(...) rhgb quiet rd.driver.blacklist=nouveau\""
echo " "
echo "---- copy from here ----------------"
echo "rd.driver.blacklist=nouveau"
echo "------------------------------------"
echo "Press ENTER to continue"
read enter
nano /etc/sysconfig/grub
grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg

# Remove xorg-x11-drv-nouveau
dnf -y remove xorg-x11-drv-nouveau

# Backup old initramfs nouveau image
mv /boot/initramfs-$(uname -r).img /boot/initramfs-$(uname -r)-nouveau.img

# Create new initramfs image
dracut /boot/initramfs-$(uname -r).img $(uname -r)

## Reboot to runlevel 3
systemctl set-default multi-user.target

echo " "
echo "#############################  ATTENTION!!! #############################"
echo "# System will reboot in command line mode                               #"
echo "# Login as 'root' and execute script '5_ROOT_install-nvidia-drivers.sh' #"
echo "# Answer YES to all the questions                                       #"
echo "#########################################################################"
echo " "
echo "Press ENTER to reboot"
read enter
reboot
