#!/bin/bash

sudo pwd > /dev/null

echo " "
echo "## CREATE USERS ##"
echo " "
echo -n "Create new users? (yes/[no]): "
read answer

if [[ $answer != 'yes' ]];
  then
    exit='true'
  else
    exit='false'
fi

while [ $exit != 'true' ]
do
  echo " "
  echo -n "Name: "
  read name
  echo -n "User: "
  read user
  sudo useradd $user -M -c $name
  sudo passwd $user
  echo " "
  echo -n  "Add another user? (yes/[no]): "
  read answer
  if [ $answer != 'yes' ];
    then exit='true'
  fi
done

# restore avatars
if [[ -d files/var/lib/AccountsService/icons ]];
  then
    if [[ -d files/var/lib/AccountsService/users ]];
      then
        sudo cp files/var/lib/AccountsService/icons/* /var/lib/AccountsService/icons/
        sudo cp files/var/lib/AccountsService/users/* /var/lib/AccountsService/users/
        echo " "
        echo "Restored users avatars!"
    fi
fi

if [[ -f files/etc/fstab ]];
  then
    echo " "
    echo " "
    echo "## UPDATE FILE SYSTEM TABLE ##"
    echo " "
    echo "When editor opens, do the following:"
    echo " "
    echo "Replace the UUID of partitions '/', '/boot/efi' and 'none'"
    echo "in the tab of 'files/etc/fstab' with the values in the tab of '/etc/fstab'."
    echo " "
    echo "Press ENTER to continue"
    read enter

    sudo gedit /etc/fstab &
    sudo gedit files/etc/fstab

    sudo cp files/etc/fstab /etc/fstab
fi

# restore crontab
if [[ -d files/var/spool/cron ]];
  then
    sudo cp files/var/spool/cron/* /var/spool/cron/
    echo "Restored crontabs!"
fi

echo " "
echo "Finished!"
echo " "
echo "Press ENTER to reboot"
read ENTER
sudo reboot
