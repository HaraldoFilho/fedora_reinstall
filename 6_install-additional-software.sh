#!/bin/bash


# Foxit Reader

sudo pwd > /dev/null

if compgen -G "runfiles/FoxitReader.enu.setup.*.x64.run" > /dev/null;
  then
    echo ""
    echo "# Installing Foxit PDF Reader..."
    sudo runfiles/FoxitReader.enu.setup.*.x64.run
    echo "Complete!"
fi


# Google Chrome

if [[ -f packages/google-chrome-stable_current_x86_64.rpm ]];
  then
    echo ""
    echo "# Installing Google Chrome..."
    sudo dnf -y install packages/google-chrome-stable_current_x86_64.rpm
fi


# Atom

if [[ -f packages/atom.x86_64.rpm ]];
  then
    echo ""
    echo "# Installing Atom..."
    if [[ -f /var/lib/rpm/.rpm.lock ]];
      then
        sudo rm /var/lib/rpm/.rpm.lock
    fi
    sudo dnf -y install packages/atom.x86_64.rpm
fi


# Skype

if [[ -f packages/skypeforlinux-64.rpm ]];
  then
    echo ""
    echo "# Installing Skype..."
    sudo dnf -y install packages/skypeforlinux-64.rpm
fi


# Android Studio

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
        echo "Complete!"
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


# IntelliJ

if [[ -d ~/.config/JetBrains ]];
  then
    sudo rm -fr ~/.config/JetBrains
fi
if compgen -G "tarfiles/ideaIC-*.tar.gz" > /dev/null;
  then
    if [[ ! -d /opt/jetbrains ]];
      then
        echo ""
        echo "# Installing IntelliJ..."
        sudo mkdir /opt/jetbrains
        sudo tar -xzf tarfiles/ideaIC-*.tar.gz --directory=/opt/jetbrains
        echo "Complete!"
    fi
fi
if [[ -f files/usr/share/applications/intellij-ide.desktop ]];
  then
    sudo cp files/usr/share/applications/intellij-ide.desktop /usr/share/applications/
fi


# Anaconda

if compgen -G "runfiles/Anaconda3-*-Linux-x86_64.sh" > /dev/null;
  then
    if [[ ! -d /opt/anaconda ]];
      then
        echo ""
        echo "# Installing Anaconda..."
        sudo runfiles/Anaconda3-*-Linux-x86_64.sh
    fi
fi


# Remote access

if compgen -G "packages/urserver-*.rpm" > /dev/null;
  then
    echo ""
    echo "# Installing Unified Remote..."
    sudo dnf -y install packages/urserver-*.rpm
fi

if compgen -G "packages/VNC-*-Linux-x64.rpm" > /dev/null;
  then
    echo ""
    echo "# Installing  RealVNC..."
    sudo dnf -y install packages/VNC-*-Linux-x64.rpm
fi


# Backup

if compgen -G "packages/rh6_CloudBerryLab_CloudBerryBackup_v*.rpm" > /dev/null;
  then
    echo ""
    echo "# Installing CloudBerry..."
    sudo dnf -y install packages/rh6_CloudBerryLab_CloudBerryBackup_v*.rpm
fi


# Dropbox

if compgen -G "packages/nautilus-dropbox-*.fedora.x86_64.rpm" > /dev/null;
  then
    echo ""
    echo "# Installing Dropbox..."
    sudo dnf -y install packages/nautilus-dropbox-*.fedora.x86_64.rpm
    if [[ -f /etc/yum.repos.d/dropbox.repo ]];
      then
        sudo mv /etc/yum.repos.d/dropbox.repo /etc/yum.repos.d/dropbox.repo.DISABLED
    fi
    if [[ -f /usr/share/applications/dropbox.desktop ]];
      then
        sudo mv /usr/share/applications/dropbox.desktop /usr/share/applications/dropbox.desktop.HIDDEN
    fi
fi
