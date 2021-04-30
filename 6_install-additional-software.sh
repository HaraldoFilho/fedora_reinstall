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

# Install Foxit Reader

sudo pwd > /dev/null

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
fi


# Install Google Chrome

if [[ -f packages/google-chrome-stable_current_x86_64.rpm ]];
  then
    echo ""
    echo "# Installing Google Chrome..."
    sudo dnf -y install packages/google-chrome-stable_current_x86_64.rpm
    if [[ $remove_files == 'yes' ]];
        then
            rm packages/google-chrome-stable_current_x86_64.rpm
    fi
    echo "Completed!"
fi


#  Install Atom

if [[ -f packages/atom.x86_64.rpm ]];
  then
    echo ""
    echo "# Installing Atom..."
    if [[ -f /var/lib/rpm/.rpm.lock ]];
      then
        sudo rm /var/lib/rpm/.rpm.lock
    fi
    sudo dnf -y install packages/atom.x86_64.rpm
    if [[ $remove_files == 'yes' ]];
        then
            rm packages/atom.x86_64.rpm
    fi
    echo "Completed!"
fi


# Install Skype

if [[ -f packages/skypeforlinux-64.rpm ]];
  then
    echo ""
    echo "# Installing Skype..."
    sudo dnf -y install packages/skypeforlinux-64.rpm
    if [[ $remove_files == 'yes' ]];
        then
            rm packages/skypeforlinux-64.rpm
    fi
    echo "Completed!"
fi


# Install Android Studio

if compgen -G "tarfiles/android-studio-ide-*-linux.tar.gz" > /dev/null;
  then
    if [[ ! -d /opt/android/android-studio ]];
      then
        if [[ ! -d /opt/android ]];
          then
            sudo mkdir /opt/android
        fi
        echo ""
        echo "# Installing Android Studio..."
        sudo tar -xzf tarfiles/android-studio-ide-*-linux.tar.gz --directory=/opt/android/
        if [[ $remove_files == 'yes' ]];
            then
                rm tarfiles/android-studio-ide-*-linux.tar.gz
        fi
        echo "Completed!"
    fi
fi
if [[ -f files/usr/share/applications/android-studio.desktop ]];
  then
    sudo cp files/usr/share/applications/android-studio.desktop /usr/share/applications/
fi
if [[ -f files/etc/udev/rules.d/51-android.rules ]];
  then
    sudo cp files/etc/udev/rules.d/51-android.rules /etc/udev/rules.d/
fi


# Install IntelliJ

if [[ -d ~/.config/JetBrains ]];
  then
    sudo rm -fr ~/.config/JetBrains
fi

if compgen -G "tarfiles/ideaIC-*.tar.gz" > /dev/null;
  then
    if [[ ! -d /opt/jetbrains ]];
      then
        sudo mkdir /opt/jetbrains
    fi
    echo ""
    echo "# Installing IntelliJ..."
    sudo tar -xzf tarfiles/ideaIC-*.tar.gz --directory=/opt/jetbrains
    if [[ $remove_files == 'yes' ]];
        then
            rm tarfiles/ideaIC-*.tar.gz
    fi
    echo "Completed!"
fi

if [[ -f files/usr/share/applications/intellij-ide.desktop ]];
  then
    sudo cp files/usr/share/applications/intellij-ide.desktop /usr/share/applications/
fi


# Install PyCharm

if compgen -G "tarfiles/pycharm-community-*.tar.gz" > /dev/null;
  then
    if [[ ! -d /opt/jetbrains ]];
      then
        sudo mkdir /opt/jetbrains
    fi
    echo ""
    echo "# Installing PyCharm..."
    sudo tar -xzf tarfiles/pycharm-community-*.tar.gz --directory=/opt/jetbrains
    if [[ $remove_files == 'yes' ]];
        then
            rm tarfiles/pycharm-community-*.tar.gz
    fi
    echo "Completed!"
fi


# Install Eclipse C++

if compgen -G "tarfiles/eclipse-cpp-*-linux-gtk-x86_64.tar.gz" > /dev/null;
  then
    if [[ ! -d /opt/eclipse ]];
      then
        sudo mkdir /opt/eclipse
    fi
    echo ""
    echo "# Installing Eclipse C++..."
    sudo tar -xzf tarfiles/eclipse-cpp-*-linux-gtk-x86_64.tar.gz --directory=/opt/eclipse
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


# Install CloudBerry Backup

if compgen -G "packages/rh6_CloudBerryLab_CloudBerryBackup_v*.rpm" > /dev/null;
  then
    echo ""
    echo "# Installing CloudBerry..."
    sudo dnf -y install packages/rh6_CloudBerryLab_CloudBerryBackup_v*.rpm
    if [[ $remove_files == 'yes' ]];
      then
        rm packages/rh6_CloudBerryLab_CloudBerryBackup_v*.rpm
    fi
    echo "Completed!"
fi


# Install Dropbox

if compgen -G "packages/nautilus-dropbox-*.fedora.x86_64.rpm" > /dev/null;
  then
    echo ""
    echo "# Installing Dropbox..."
    sudo dnf -y install packages/nautilus-dropbox-*.fedora.x86_64.rpm
    if [[ $remove_files == 'yes' ]];
      then
        rm packages/nautilus-dropbox-*.fedora.x86_64.rpm
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


# Install RealVNC

if compgen -G "packages/VNC-*-Linux-x64.rpm" > /dev/null;
  then
    echo ""
    echo "# Installing  RealVNC..."
    sudo dnf -y install packages/VNC-*-Linux-x64.rpm
    sudo systemctl disable vncserver-x11-serviced.service
    sudo mv /usr/share/applications/realvnc-vncserver-service.desktop /home/public/.scripts/vnc/
    sudo vnclicensewiz
    if [[ $remove_files == 'yes' ]];
      then
        rm packages/VNC-*-Linux-x64.rpm
    fi
    echo "Completed!"
fi


echo " "
echo "Press ENTER to reboot or 'Ctrl +C' to abort"
read enter
sudo reboot
