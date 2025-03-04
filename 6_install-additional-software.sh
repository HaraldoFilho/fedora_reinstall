#!/bin/bash

echo "### INSTALLING ADDITIONAL SOFTWARE ###"
echo -n  "Remove installers after finished? (yes/[no]): "
read remove_files


# Remove NVIDIA drivers installers

if [[ $remove_files == 'yes' ]];
  then
    if compgen -G "runfiles/NVIDIA-Linux-x86_64-*.run" > /dev/null;
      then
        rm runfiles/NVIDIA-Linux-x86_64-*.run
    fi
fi


sudo pwd > /dev/null


# Install Foxit Reader

if compgen -G "runfiles/FoxitReader.enu.setup.*.x64.run" > /dev/null;
  then
    echo ""
    echo "# Installing Foxit PDF Reader..."
    sudo runfiles/FoxitReader.enu.setup.*.x64.run
    if [[ $remove_files == 'yes' ]];
        then
            rm runfiles/FoxitReader.enu.setup.*.x64.run
    fi
    echo "Completed!"
  else
    if [[ -f /opt/foxitsoftware/foxitreader/FoxitReader.desktop ]];
      then
        if [[ -f files/usr/share/applications/FoxitReader.desktop ]];
            then
              echo ""
              echo "# Found Foxit PDF Reader previous installation. Added icon to applications."
              sudo cp files/usr/share/applications/FoxitReader.desktop /usr/share/applications/
        fi
    fi
fi

#  Install Pulsar

if compgen -G "packages/pulsar-*.x86_64.rpm" > /dev/null;
  then
    echo ""
    echo "# Installing Pulsar..."
    if [[ -f /var/lib/rpm/.rpm.lock ]];
      then
        sudo rm /var/lib/rpm/.rpm.lock
    fi
    sudo dnf -y install packages/pulsar-*.x86_64.rpm
    if [[ $remove_files == 'yes' ]];
        then
            rm packages/pulsar-*.x86_64.rpm
    fi
    echo "Completed!"
fi


# Install Android Studio

if compgen -G "tarfiles/android-studio-*-linux.tar.gz" > /dev/null;
  then
    if [[ -d /opt/android/android-studio ]];
      then
        echo ""
        echo "# Android Studio is already installed. Re-install it? (yes/[no]):"
        read install
        if [[ $install == 'yes' ]];
          then
            echo "Backup previous installation? ([yes]/no):"
            read backup
            if [[ $backup != 'no' ]];
              then
                sudo mv /opt/android/android-studio /opt/android/android-studio.old
            fi
            sudo rm -rf /opt/android/android-studio
        fi
      else
        install="yes"
    fi

    if [[ $install == 'yes' ]];
      then
        if [[ ! -d /opt/android ]];
          then
            sudo mkdir /opt/android
        fi
        echo ""
        echo "# Installing Android Studio..."
        sudo tar -xzf tarfiles/android-studio-*-linux.tar.gz --directory=/opt/android/
        if [[ $remove_files == 'yes' ]];
            then
                rm tarfiles/android-studio-*-linux.tar.gz
        fi
        echo "Completed!"
    fi
fi

if [[ -d /opt/android/android-studio ]];
  echo "Android Studio is installed"
  then
    if [[ -f files/usr/share/applications/android-studio.desktop ]];
      then
        sudo cp files/usr/share/applications/android-studio.desktop /usr/share/applications/
        echo "Updated Android Studio icon"
    fi
    if [[ -f files/etc/udev/rules.d/51-android.rules ]];
      then
        sudo cp files/etc/udev/rules.d/51-android.rules /etc/udev/rules.d/
        echo "Updated Android Studio device rules"
    fi
    # create /virt/android/avd directory
    if [[ ! -d /virt/android/avd ]];
      then
        sudo mkdir /virt/android
        sudo mkdir /virt/android/avd
        sudo chmod -R 777 /virt/android
        echo "Created /virt/android/avd directory"
    fi
fi

# Install IntelliJ

if compgen -G "tarfiles/ideaIC-*.tar.gz" > /dev/null;
  then
    if [[ -d ~/.config/JetBrains ]];
      then
        sudo rm -fr ~/.config/JetBrains
    fi
    if [[ ! -d /opt/jetbrains ]];
      then
        sudo mkdir /opt/jetbrains
    fi
    if [[ -d /opt/jetbrains/idea-IC ]];
      then
        sudo rm -fr /opt/jetbrains/idea-IC
    fi
    echo ""
    echo "# Installing IntelliJ..."
    sudo tar -xzf tarfiles/ideaIC-*.tar.gz --directory=/opt/jetbrains/
    if [[ $remove_files == 'yes' ]];
        then
            rm tarfiles/ideaIC-*.tar.gz
    fi
    sudo mv /opt/jetbrains/idea-IC-* /opt/jetbrains/idea-IC
    echo "Completed!"
fi

if [[ -f files/usr/share/applications/intellij-ide.desktop ]];
  then
    sudo cp files/usr/share/applications/intellij-ide.desktop /usr/share/applications/
fi


# Install PyCharm

if compgen -G "tarfiles/pycharm-community-*.tar.gz" > /dev/null;
  then
    if [[ -d ~/.config/JetBrains ]];
      then
        sudo rm -fr ~/.config/JetBrains
    fi
    if [[ ! -d /opt/jetbrains ]];
      then
        sudo mkdir /opt/jetbrains
    fi
    if [[ -d /opt/jetbrains/pycharm ]];
      then
        sudo rm -fr /opt/jetbrains/pycharm
    fi
    echo ""
    echo "# Installing PyCharm..."
    sudo tar -xzf tarfiles/pycharm-community-*.tar.gz --directory=/opt/jetbrains/
    if [[ $remove_files == 'yes' ]];
        then
          rm tarfiles/pycharm-community-*.tar.gz
    fi
    sudo mv /opt/jetbrains/pycharm-* /opt/jetbrains/pycharm
    echo "Completed!"
fi

if [[ -f files/usr/share/applications/pycharm.desktop ]];
  then
    sudo cp files/usr/share/applications/pycharm.desktop /usr/share/applications/
fi


# Install Eclipse C++

if compgen -G "tarfiles/eclipse-cpp-*-linux-gtk-x86_64.tar.gz" > /dev/null;
  then
    if [[ ! -d /opt/eclipse ]];
      then
        sudo mkdir /opt/eclipse
    fi
    if [[ -d /opt/eclipse/eclipse-cpp ]];
      then
        sudo rm -fr /opt/eclipse/eclipse-cpp
    fi
    echo ""
    echo "# Installing Eclipse C++..."
    sudo tar -xzf tarfiles/eclipse-cpp-*-linux-gtk-x86_64.tar.gz --directory=/opt/eclipse/
    if [[ $remove_files == 'yes' ]];
      then
        rm tarfiles/eclipse-cpp-*-linux-gtk-x86_64.tar.gz
    fi
    sudo mv /opt/eclipse/eclipse /opt/eclipse/eclipse-cpp
    echo "Completed!"
fi
if [[ -f files/usr/share/applications/eclipse-cpp.desktop ]];
  then
    sudo cp files/usr/share/applications/eclipse-cpp.desktop /usr/share/applications/
fi


# Install Anaconda

if compgen -G "runfiles/Anaconda3-*-Linux-x86_64.sh" > /dev/null;
  then
    if [[ ! -d /opt/anaconda ]];
      then
        echo ""
        echo "# Installing Anaconda..."
        sudo runfiles/Anaconda3-*-Linux-x86_64.sh
        if [[ $remove_files == 'yes' ]];
          then
            rm runfiles/Anaconda3-*-Linux-x86_64.sh
        fi
        echo "Completed!"
    fi
fi

# create /virt/anaconda/conda directory
if [[ -d /opt/anaconda ]];
  then
    if [[ ! -d /virt/anaconda/conda ]];
      then
        sudo mkdir /virt/anaconda
        sudo mkdir /virt/anaconda/conda
        sudo chmod -R 777 /virt/anaconda
        echo "Created /virt/anaconda/conda directory"
    fi
fi

# Install Unified Remote

if compgen -G "packages/urserver-*.rpm" > /dev/null;
  then
    echo ""
    echo "# Installing Unified Remote..."
    sudo dnf -y install packages/urserver-*.rpm
    if [[ $remove_files == 'yes' ]];
      then
        rm packages/urserver-*.rpm
    fi
    echo "Completed!"
fi


# Install MSP360 Backup

if compgen -G "packages/rh6_MSP360_MSP360Backup_v*.rpm" > /dev/null;
  then
    echo ""
    echo "# Installing MSP360 Backup..."
    sudo dnf -y install packages/rh6_MSP360_MSP360Backup_v*.rpm
    if [[ $remove_files == 'yes' ]];
      then
        rm packages/rh6_MSP360_MSP360Backup_v*.rpm
    fi
    echo "Completed!"
fi


# Install Dropbox

if compgen -G "packages/nautilus-dropbox-*.x86_64.rpm" > /dev/null;
  then
    echo ""
    echo "# Installing Dropbox..."
    sudo dnf -y install packages/nautilus-dropbox-*.x86_64.rpm
    if [[ $remove_files == 'yes' ]];
      then
        rm packages/nautilus-dropbox-*.x86_64.rpm
    fi
    echo "Completed!"
    if [[ -f /etc/yum.repos.d/dropbox.repo ]];
      then
        sudo mv /etc/yum.repos.d/dropbox.repo /etc/yum.repos.d/dropbox.repo.DISABLED
    fi
    if [[ -f /usr/share/applications/dropbox.desktop ]];
      then
        sudo mv /usr/share/applications/dropbox.desktop /usr/share/applications/dropbox.desktop.HIDDEN
    fi
fi

echo " "
echo "Press ENTER to reboot or 'Ctrl +C' to abort"
read enter
sudo reboot
