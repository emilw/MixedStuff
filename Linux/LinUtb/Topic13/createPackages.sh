#!/bin/bash
function quit {
    exit
}

function createDebStructureIfNotExists {
    local fullFolderName=$1
    local releaseVersion=$2
    local releaseName=$3

    if [ ! -d "output/$fullFolderName" ]; then
        echo "Missing output folder for $fullFolderName, creating it"
        mkdir output/$fullFolderName
        echo "Create debian package folder"
        mkdir output/$fullFolderName/debian

        cd output/$fullFolderName
        pwd
        echo "Creating history file"
        dch --create -v $releaseVersion-1 --package $releaseName
        echo "Creating compat file"
        echo 9 > debian/compat
        echo "Creating copyright file"
        touch debian/copyright
        cd ../../
        echo "Creating control file"
        cp $releaseName"Control.conf" output/$fullFolderName/debian/control

        echo "Creating rules file"
        cp $releaseName"rules.conf" output/$fullFolderName/debian/rules

        echo "Copying hithere.dirs"
        cp $releaseName.dirs output/$fullFolderName/debian/$releaseName.dirs

        echo "Creating source format file"
        mkdir output/$fullFolderName/debian/source
        #echo "3.0 (quilt)" > output/$fullFolderName/debian/source/format
        echo "3.0 (native)" > output/$fullFolderName/debian/source/format
        ls -l output/$fullFolderName/debian/
    fi
}

function buildPackage() {
    local fullFolderName=$1
    cd output/$fullFolderName
    echo "Building deb package for $fullFolderName"
    debuild -us -uc
    echo "Done building package for $fullFolderName"
    cd ../../
}

libVersion="1.0"
programVersion="1.0"
libReleaseName="electrolib"
programReleaseName="electrotest"

echo "Removing output folder and files"
rm -r output/

if [ ! -d "output" ]; then
    echo "Missing output folder, creating it"
    mkdir output
fi

libTarFullName=$libReleaseName"_"$libVersion
programTarFullName=$programReleaseName"_"$programVersion

echo "Renaming tarball to deb format"
cp latestLibs.tar.gz output/$libTarFullName.orig.tar.gz
#Copy program
cp latestElectroTest.tar.gz output/$programTarFullName.orig.tar.gz
echo "Tarballs are in place"

libFolderFullName=$libReleaseName-$libVersion
programFolderFullName=$programReleaseName-$programVersion

createDebStructureIfNotExists $programFolderFullName $programVersion $programReleaseName
createDebStructureIfNotExists $libFolderFullName $libVersion $libReleaseName


echo "Extract tar ball $libTarFullName to output $libFolderFullName"
tar xf output/$libTarFullName.orig.tar.gz  -C output/$libFolderFullName --strip-components 3
echo "Extract tar ball $programTarFullName to output $programFolderFullName"
tar xf output/$programTarFullName.orig.tar.gz  -C output/$programFolderFullName --strip-components 2

echo "Building electro lib"
buildPackage $libFolderFullName

echo "Installing electro lib to make sure that electrotest can build"
sudo dpkg -i "output/"$libTarFullName"-1_i386.deb"

echo "Starting to build electro test"
buildPackage $programFolderFullName


echo "Uninstalling electrolib"
sudo dpkg -r electrolib

quit