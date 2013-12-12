# build-debs

Some helper scripts for building Ubuntu/Debian deb packages for Syntro components.

## Build System Requirements

A Linux Ubuntu or Debian system with the following packages installed.

        sudo apt-get install build-essential git gpupg pbuilder ubuntu-dev-tools bzr-builddeb apt-file cdbs debhelper

For RPi running Raspbian Wheezy or Ubuntu Qt4 systems

        sudo apt-get install libqt4-dev

For Ubuntu Qt5 systems

        sudo apt-get install qtbase5-dev

For building syntrolcam

        sudo apt-get install libasound2 libasound2-dev

## Fetch

Clone the build-debs repo this way

        git clone https://github.com/Pansenti/build-debs.git

## Build 

Build the libsyntrocore packages with the build_libsyntrocore.sh script

        cd build-debs
        ./build_libsyntrocore.sh

The syntrolcam and syntroview builds require the libsyntrocore
packages be installed first.

Build the syntrolcam package with the build_syntrolcam.sh script

        ./build_syntrolcam.sh

Build the syntroview package with the build_syntroview.sh script

        ./build_syntroview.sh

The syntrolcam and syntroview builds require the libsyntrocore
packages be installed first.


## Install 

Install the deb packages with dpkg either on the build machine or
another machine similar to the build system.

        cd pkgs
        sudo dpkg -i libsyntrocore*

        sudo dpkg -i syntrolcam*
        sudo dpkg -i syntroview*

## Removal

Remove the packages this way

        sudo dpkg -r syntrolcam syntroview libsyntrocore1 libsyntrocore-dev

To completely remove all record of these packages, use --purge

        sudo dpkg -r --purge syntrolcam syntroview libsyntrocore1 libsyntrocore-dev

