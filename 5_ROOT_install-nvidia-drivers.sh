#!/bin/bash

# Code extracted from: https://www.if-not-true-then-false.com/2015/fedora-nvidia-guide/

if [[ $HOME != '/root' ]];
  then
    echo "ERROR: This script must be run as root in command line mode!"
    exit 1
fi

runfiles/NVIDIA-Linux-x86_64-*.run
systemctl set-default graphical.target

echo "Press ENTER to reboot and go back to graphical mode"
read enter
reboot
