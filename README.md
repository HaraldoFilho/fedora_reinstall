# Fedora Reinstall

Scripts to be executed after a [Fedora 34](https://getfedora.org) reinstallation to restore the system to the previous state.

## System

#### Storage
- SSD1: 240GB (sda)
- SSD2: 120GB (sdb)

#### Partition Scheme
- sda1: /boot/efi
- sda2: /
- sda3: /opt
- sda4: /home
- sda5: swap
- sdb1: /virt

#### Graphics
- Integrated Mesa Intel® UHD Graphics 620 (WHL GT2)
- Dedicated NVIDIA Corporation GP108M [GeForce MX150]

## Scripts

### [0_ROOT_pre-reinstall.sh](https://github.com/HaraldoFilho/fedora_reinstall/blob/master/0_ROOT_pre-reinstall.sh)
Copy some system files to be restored later.

### [1_set-root-user.sh](https://github.com/HaraldoFilho/fedora_reinstall/blob/master/1_set-root-user.sh)
Set root user, asking to create a password.

### [2_ROOT_initial-setup.sh](https://github.com/HaraldoFilho/fedora_reinstall/blob/master/2_ROOT_initial-setup.sh)
Restore some system files, update system and install the following software:
#### System Utilities
- GParted
- Nutty
- GNOME Tweaks
- Firewall
- xterm
- CPU-X
- Samba
#### Programming Tools
- GNOME Builder
- DB Browser for SQLite
- gitg
- GHex
- Dia
#### Image Processing
- GIMP
- Inkscape
- My Paint
#### Games
- GNOME Mines
- GNOME Chess
- Armacycles Advanced
#### General Utilities
- TkDiff
- Color picker 3
- Cawbird
- Stellarium
- Image Magick
- Nautilus Image Converter

### [3_install-nvidia-dependencies.sh](https://github.com/HaraldoFilho/fedora_reinstall/blob/master/3_install-nvidia-dependencies.sh)
Install dependencies of NVDIA Drivers.

### [4_ROOT_remove-nouveau.sh](https://github.com/HaraldoFilho/fedora_reinstall/blob/master/4_ROOT_remove-nouveau.sh)
Remove Nouveau Driver, which conflicts with NVIDIA, and reboot system in command line mode to install NVIDIA Drivers.

### [5_ROOT_install-nvidia-drivers.sh](https://github.com/HaraldoFilho/fedora_reinstall/blob/master/5_ROOT_install-nvidia-drivers.sh)
Install NVIDIA Drivers and reboot system in graphical mode.

### [6_install-additional-software.sh](https://github.com/HaraldoFilho/fedora_reinstall/blob/master/6_install-additional-software.sh)
Install additional software, if present in the directories [packages](packages), [runfiles](runfiles) and [tarfiles](tarfiles).

#### Installed Software
- [Foxit Reader](https://www.foxitsoftware.com/pdf-reader/)
- [Google Chrome](https://www.google.com/chrome/)
- [Atom](https://atom.io/)
- [Skype](https://www.skype.com/)
- [Android Studio](https://developer.android.com/studio)
- [IntelliJ](https://www.jetbrains.com/idea/)
- [PyCharm](https://www.jetbrains.com/pycharm/)
- [Eclipse C++](https://www.eclipse.org/)
- [Anaconda](https://www.anaconda.com/)
- [Unified Remote](https://www.unifiedremote.com/)
- [RealVNC](https://www.realvnc.com/)
- [CloudBerry Backup](https://www.msp360.com/backup.aspx)
- [Dropbox](https://www.dropbox.com/)

### [7_final-setup.sh](https://github.com/HaraldoFilho/fedora_reinstall/blob/master/7_final-setup.sh)
Create other users, restore users' avatars, file system table and crontabs.

## Usage

- Just before starting the OS reinstallation, run the script _0_ROOT_pre-reinstall.sh_ as root.
- Get the latest version of [Fedora Workstation](https://getfedora.org/workstation/download/) and reinstall it keeping the original partition scheme.
- Make sure that all the latest software installers are on directories _packages_, _runfiles_ and _tarfiles_.
- Run the other scripts in numerical order.
