#!/bin/bash

mkdir temp
cd temp

# get a fresh snapshot of the public repo 
git clone https://github.com/Syntro/SyntroCore.git

# fix up install paths and adjust top level .pro to only build libraries
cp ../patches/libsyntrocore_dpkg_prep.patch SyntroCore
cd SyntroCore
git apply libsyntrocore_dpkg_prep.patch

cd ..

VERSION=`perl -a -lne 'print $F[2]' SyntroCore/version.pri`
PKGNAME="libsyntrocore-$VERSION"

# rename in a format dpkg wants
mv SyntroCore $PKGNAME 

cd $PKGNAME

# copy over the debian build files 
cp -r ../../debian/libsyntrocore debian

# build the package
dpkg-buildpackage 

cd ../..

if [ ! -d packages ]; then
    mkdir packages
fi

cp temp/*.deb packages

rm -rf temp

echo -e "\nNew deb files can be found in the packages directory"

