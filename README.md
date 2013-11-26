# build-debs

Some helper scripts for building Ubuntu/Debian deb packages for Syntro components.

# Requirements

A Linux Ubuntu or Debian system with the following packages installed.

        sudo apt-get install build-essential git gpupg pbuilder ubuntu-dev-tools bzr-builddeb apt-file

For RPi running Raspbian Wheezy or Ubuntu Qt4 systems

        sudo apt-get install libqt4-dev

For Ubuntu Qt5 systems

        sudo apt-get install qtbase5-dev

# Fetch

Clone the build-debs repo this way

        git clone https://github.com/Pansenti/build-debs.git

# Run

Build the libsyntrocore packages with the build_libsyntrocore.sh script

        cd build-debs
        ./build_libsyntrocore.sh


# Install

Install the deb packages with dpkg

        cd pkgs
        sudo dpkg -i libsyntrocore1* libsyntrocore-dev*


