#!/bin/bash

if [[ $HOME != "/root" ]];
  then
    echo "ERROR: This script must be run as root!"
    exit 1
fi

## /etc

if [[ ! -d files/etc ]];
  then
    mkdir files/etc
fi

cp /etc/environment files/etc/
cp /etc/fstab files/etc/
cp /etc/hostname files/etc/


# samba config file

if [[ ! -d files/etc/samba ]];
  then
    mkdir files/etc/samba
fi

cp /etc/samba/smb.conf files/etc/samba/

if [[ ! -d files/etc/udev ]];
  then
    mkdir files/etc/udev
fi

if [[ ! -d files/etc/udev/rules.d ]];
  then
    mkdir files/etc/udev/rules.d
fi


# android devices rules

cp /etc/udev/rules.d/* files/etc/udev/rules.d/


# /root/.bashrc

if [[ ! -d files/root ]];
  then
    mkdir files/root
fi

cp /root/.bashrc files/root/


# /usr

if [[ ! -d files/usr ]];
  then
    mkdir files/usr
fi

if [[ ! -d files/usr/share ]];
  then
    mkdir files/usr/share
fi

if [[ ! -d files/usr/share/applications ]];
  then
    mkdir files/usr/share/applications
fi

# android studio icon

if [[ -f /usr/share/applications/android-studio.desktop ]];
  then
    cp /usr/share/applications/android-studio.desktop files/usr/share/applications/
fi


# /var

if [[ ! -d files/var ]];
  then
    mkdir files/var
fi

# users avatars

if [[ ! -d files/var/lib ]];
  then
    mkdir files/var/lib
fi

if [[ ! -d files/var/lib/AccountsService ]];
  then
    mkdir files/var/lib/AccountsService
fi

cp -r /var/lib/AccountsService/* files/var/lib/AccountsService/
#rm files/var/lib/AccountsService/users/gdm
#rm files/var/lib/AccountsService/users/gnome-initial-setup

# crontabs

if [[ ! -d files/var/spool ]];
  then
    mkdir files/var/spool
fi

if [[ ! -d files/var/spool/cron ]];
  then
    mkdir files/var/spool/cron
fi

cp /var/spool/cron/* files/var/spool/cron/


# change ownership to admin
chown -R admin:admin files
