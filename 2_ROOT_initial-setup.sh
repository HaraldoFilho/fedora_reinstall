!/bin/bash

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
if [[ ! -d /virt ]];
  then
    mkdir /virt
fi

# restore system files

if [[ -f files/root/.bashrc ]];
  then
    cp files/root/.bashrc /root
fi

if [[ -d files/root/.cifs_credentials ]];
  then
    cp -r files/root/.cifs_credentials /root
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
dnf -y install cronie
dnf -y install gparted
dnf -y install nutty
dnf -y install gnome-tweaks
dnf -y install firewall-config
dnf -y install pip
dnf -y install seahorse

# install xterm
dnf -y install xterm

# install cpu-x
dnf -y install cpu-x

# install samba
dnf -y install samba
smbcontrol all reload-config
systemctl enable smb.service
systemctl start smb.service

if [[ -f files/etc/samba/smb.conf ]];
  then
    cp files/etc/samba/smb.conf /etc/samba/
fi

# install Google Chrome
dnf -y install google-chrome-stable-*

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
dnf -y install stellarium
dnf -y install alien
dnf -y install mysql-connector-odbc
dnf -y install libpq
dnf -y install ImageMagick
dnf -y install nautilus-image-converter
nautilus -q

# install audio codecs
dnf -y install gstreamer1-plugin-openh264

# remove tour
dnf -y remove gnome-tour

# Edit /etc/sysconfig/grub
echo "GRUB_DISABLE_OS_PROBER=true" >> /etc/sysconfig/grub
grub2-mkconfig -o /boot/grub2/grub.cfg

# reboot
echo " "
echo "Type ENTER to reboot or 'Ctrl + C' to abort"
read enter
reboot
