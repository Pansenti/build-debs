#!/bin/bash

mkdir temp
cd temp

# get a fresh snapshot of the public repo 
git clone https://github.com/Syntro/SyntroCore.git

# fix up install paths and adjust top level .pro to only build libraries
cp ../libsyntrocore_dpkg_prep.patch SyntroCore
cd SyntroCore
git apply libsyntrocore_dpkg_prep.patch

cd ..

VERSION=`perl -a -lne 'print $F[2]' SyntroCore/version.pri`
PKGNAME="libsyntrocore-$VERSION"

# rename in a format dpkg wants
mv SyntroCore $PKGNAME 

cd $PKGNAME

# generate the debian files
dh_make -c gpl2 -e scott@pansenti.com -l -n -y

# remove some files we don't use
rm debian/*.ex debian/*.EX debian/README*

# copy over the files we need to modify
cp ../../libsyntrocore_debian/* debian/

# build the package
dpkg-buildpackage 

cd ../..

if [ ! -d pkgs ]; then
    mkdir pkgs
fi

cp temp/*.deb pkgs

rm -rf temp

echo -e "\nNew deb files can be found in the pkgs directory"
