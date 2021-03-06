#!/bin/bash
# 
# Generate a deb installer for SyntroView
#

if [ -d temp ]; then
    rm -rf temp/*
else
    mkdir temp
fi

cd temp

# get a fresh snapshot of the public repo 
git clone https://github.com/Syntro/SyntroView.git

# fix up install paths and adjust top level .pro to only build libraries
cp ../patches/syntroview_dpkg_prep.patch SyntroView
cd SyntroView
git apply syntroview_dpkg_prep.patch
cd ..

VERSION=`perl -a -lne 'print $F[2]' SyntroView/version.pri`
PKGNAME="syntroview-$VERSION"

# rename in a format dpkg wants
mv SyntroView $PKGNAME 

cd $PKGNAME

# copy over the debian build files 
cp -r ../../debian/syntroview debian

# build the package
dpkg-buildpackage 

cd ../..

if [ ! -d packages ]; then
    mkdir packages
fi

cp temp/*.deb packages

rm -rf temp

echo -e "\nNew deb files can be found in the packages directory"

