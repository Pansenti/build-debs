#!/bin/bash
# 
# Generate a deb installer for SyntroCam
#

if [ -d temp ]; then
    rm -rf temp/*
else
    mkdir temp
fi

cd temp

# get a fresh snapshot of the public repo 
git clone git@github.com:Pansenti/SyntroCam.git

# fix up install paths and adjust top level .pro to only build libraries
cp ../patches/syntrocam_dpkg_prep.patch SyntroCam
cd SyntroCam
git apply syntrocam_dpkg_prep.patch

cd ..

VERSION=`perl -a -lne 'print $F[2]' SyntroCam/version.pri`
PKGNAME="syntrocam-$VERSION"

# rename in a format dpkg wants
mv SyntroCam $PKGNAME 

cd $PKGNAME

# copy over the debian build files 
cp -r ../../debian/syntrocam debian

# build the package
dpkg-buildpackage 

cd ../..

if [ ! -d packages ]; then
    mkdir packages
fi

cp temp/*.deb packages

rm -rf temp

echo -e "\nNew deb files can be found in the packages directory"

