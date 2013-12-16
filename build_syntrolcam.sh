#!/bin/bash
# 
# Generate a deb installer for SyntroLCam
#

if [ -d temp ]; then
    rm -rf temp/*
else
    mkdir temp
fi

cd temp

# get a fresh snapshot of the public repo 
git clone https://github.com/Syntro/SyntroLCam.git

# fix up install paths and adjust top level .pro to only build libraries
cp ../patches/syntrolcam_dpkg_prep.patch SyntroLCam
cd SyntroLCam
git apply syntrolcam_dpkg_prep.patch

cd ..

VERSION=`perl -a -lne 'print $F[2]' SyntroLCam/version.pri`
PKGNAME="syntrolcam-$VERSION"

# rename in a format dpkg wants
mv SyntroLCam $PKGNAME 

cd $PKGNAME

# copy over the debian build files 
cp -r ../../debian/syntrolcam debian

# build the package
dpkg-buildpackage 

cd ../..

if [ ! -d packages ]; then
    mkdir packages
fi

cp temp/*.deb packages

rm -rf temp

echo -e "\nNew deb files can be found in the packages directory"

