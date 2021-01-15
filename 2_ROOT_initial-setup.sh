#!/bin/bash

if [[ $HOME != '/root' ]];
  then
    echo "ERROR: This script must be run as root!"
    exit 1
fi

# set hostname
if [[ -f files/etc/hostname ]];
  then
    HOSTNAME=`cat files/etc/hostname`
    hostnamectl set-hostname $HOSTNAME
    echo "New hostname is '$HOSTNAME'"
fi

# create /virt directory
mkdir /virt

# restore system files

if [[ -f files/root/.bashrc ]];
  then
    cp files/root/.bashrc /root
fi

if [[ -f /home/public/.bash_aliases ]];
  then
    if [[ ! -f /root/.bash_aliases ]];
      then
        ln -s /home/public/.bash_aliases /root/.bash_aliases
    fi
fi

if [[ -f files/etc/environment ]];
  then
    cp files/etc/environment /etc/
fi

# system update
dnf -y update

# install system utilities
dnf -y install gparted
dnf -y install nutty
dnf -y install gnome-tweaks

# install xterm
dnf -y install xterm
if [[ -f /usr/share/applications/xterm.desktop ]];
  then
    mv /usr/share/applications/xterm.desktop /usr/share/applications/xterm.desktop.HIDDEN
fi

# install cpu-x
dnf -y install cpu-x
if [[ -f /usr/share/applications/cpu-x.desktop ]];
  then
    mv /usr/share/applications/cpu-x.desktop /usr/share/applications/cpu-x.desktop.HIDDEN
fi

# install samba
dnf -y install samba
smbcontrol all reload-config
systemctl enable smb.service
systemctl start smb.service

if [[ -f files/etc/samba/smb.conf ]];
  then
    cp files/etc/samba/smb.conf /etc/samba/
fi

# install programming tools
dnf -y install gnome-builder
dnf -y install sqlitebrowser-*.x86_64
dnf -y install gitg
dnf -y install ghex
dnf -y install dia

# install image processing software
dnf -y install gimp
dnf -y install inkscape
dnf -y install mypaint

# install games
dnf -y install gnome-mines
dnf -y install gnome-chess
dnf -y install armacycles-ad

# install general utilities
dnf -y install tkcvs
dnf -y install gcolor3
dnf -y install peek
dnf -y install stellarium
dnf -y install alien
dnf -y install mysql-connector-odbc
dnf -y install libpq
dnf -y install ImageMagick
dnf -y install nautilus-image-converter
nautilus -q

# reboot
echo " "
echo "Type ENTER to reboot"
read enter
reboot
