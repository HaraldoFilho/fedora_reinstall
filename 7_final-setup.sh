#!/bin/bash

sudo pwd > /dev/null


# create new users

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
  if [[ $answer != 'yes' ]];
    then exit='true'
  fi
done


# restore file system table

if [[ -f files/etc/fstab ]];
  then
     echo " "
     echo " "
     echo "## RESTORE FILE SYSTEM TABLE ##"
     echo " "
     echo -n "Restore File System Table? (yes/[no]): "
     read answer
     if [[ $answer == 'yes' ]];
       then
         sudo cp files/etc/fstab /etc/fstab
         echo " "
         echo "File System Table restored!"
     fi
fi


# restore avatars

if [[ -d files/var/lib/AccountsService/icons ]];
  then
    if [[ -d files/var/lib/AccountsService/users ]];
      then
        echo " "
        echo " "
        echo "## RESTORE USERS AVATARS ##"
        echo " "
        echo -n "Restore users avatars? ([yes]/no): "
        read answer
        if [[ $answer != 'no' ]];
          then
            sudo cp files/var/lib/AccountsService/icons/* /var/lib/AccountsService/icons/
            sudo cp files/var/lib/AccountsService/users/* /var/lib/AccountsService/users/
            echo " "
            echo "Users avatars have been restored!"
        fi
    fi
fi


# restore root crontab

if [[ -f files/var/spool/cron/root ]];
  then
    echo " "
    echo " "
    echo "## RESTORE ROOT CRONTAB ##"
    echo " "
    echo "When editor opens hit 'Ctrl + O', 'ENTER' and 'Ctrl + X'"
    echo " "
    echo "Press ENTER to continue"
    read enter

    sudo cp files/var/spool/cron/root /var/spool/cron/
    sudo crontab -e
    echo "Restored root crontab!"
fi

echo " "
echo "Finished!"
echo " "
echo "Press ENTER to reboot or 'Ctrl +C' to abort"
read enter
sudo reboot


