#!/bin/bash
function quit {
    print "Done running debian package generator for electrolib/electrotest/electrogtk"
    exit
}

function print {
    echo -e "Package status text: \e[32m"$@"\e[39m"
}

function printFailure {
    echo -e "Package status text: \e[31m"$@"\e[39m"
}

failureCount=0

function equalToZeroOtherwiseFailure {
    local input=$1
    local failureText
    local firstPosition=0
    for p in "$@";
    do
        if [ $firstPosition -eq 0 ] ; then
            firstPosition=1
        else
            failureText=$failureText"$p";
        fi        
    done
    echo $1

    if [ "$1" -gt "0" ] ; then
        printFailure "$failureText status($input)"
        failureCount=$failureCount+1
        printFailure "A set of steps failed($failureCount)"
        exit
    fi
}

function createDebStructureIfNotExists {
    local fullFolderName=$1
    local releaseVersion=$2
    local releaseName=$3

    if [ ! -d "output/$fullFolderName" ]; then
        print "Missing output folder for $fullFolderName, creating it"
        mkdir output/$fullFolderName
        print "Create debian package folder"
        mkdir output/$fullFolderName/debian

        cd output/$fullFolderName
        pwd
        print "Creating history file"
        dch --create -v $releaseVersion-1 --package $releaseName
        print "Creating compat file"
        echo 9 > debian/compat
        print "Creating copyright file"
        touch debian/copyright
        cd ../../
        print "Creating control file"
        cp "Templates/"$releaseName"Control.conf" output/$fullFolderName/debian/control

        print "Creating rules file"
        cp "Templates/"$releaseName"rules.conf" output/$fullFolderName/debian/rules

        print "Copying $releaseName.dirs"
        cp "Templates/"$releaseName.dirs output/$fullFolderName/debian/$releaseName.dirs

        print "Creating source format file"
        mkdir output/$fullFolderName/debian/source
        echo "3.0 (quilt)" > output/$fullFolderName/debian/source/format
        #echo "3.0 (native)" > output/$fullFolderName/debian/source/format
        ls -l output/$fullFolderName/debian/
    fi
}

function buildPackage() {
    local fullFolderName=$1
    cd output/$fullFolderName
    print "Commit all changes"
    dpkg-source --commit
    print "Building deb package for $fullFolderName"
    debuild -us -uc
    equalToZeroOtherwiseFailure $? "Failed to build $fullFolderName"
    print "Done building package for $fullFolderName"
    cd ../../
}

#Init environment
DEBEMAIL="emil@postback.se"
DEBFULLNAME="Emil"
export DEBEMAIL DEBFULLNAME

libVersion="1.1"
programVersion="1.1"
programGtkVersion="1.1"
libReleaseName="electrolib"
programReleaseName="electrotest"
programGtkReleaseName="electrotestgtk"

print "Removing output folder and files"
rm -r output/

if [ ! -d "output" ]; then
    print "Missing output folder, creating it"
    mkdir output
fi

libTarFullName=$libReleaseName"_"$libVersion
programTarFullName=$programReleaseName"_"$programVersion
programGtkTarFullName=$programGtkReleaseName"_"$programGtkVersion

print "Renaming tarball to deb format"
cp latestLibs.tar.gz output/$libTarFullName.orig.tar.gz
#Copy program
cp latestElectroTest.tar.gz output/$programTarFullName.orig.tar.gz
cp latestElectroTestGtk.tar.gz output/$programGtkTarFullName.orig.tar.gz
print "Tarballs are in place"

libFolderFullName=$libReleaseName-$libVersion
programFolderFullName=$programReleaseName-$programVersion
programGtkFolderFullName=$programGtkReleaseName-$programGtkVersion

createDebStructureIfNotExists $programFolderFullName $programVersion $programReleaseName
createDebStructureIfNotExists $programGtkFolderFullName $programGtkVersion $programGtkReleaseName
createDebStructureIfNotExists $libFolderFullName $libVersion $libReleaseName

print "Extract tar ball $libTarFullName to output $libFolderFullName"
tar xf output/$libTarFullName.orig.tar.gz -C output/$libFolderFullName --strip-components 3
print "Extract tar ball $programTarFullName to output $programFolderFullName"
tar xf output/$programTarFullName.orig.tar.gz -C output/$programFolderFullName --strip-components 2
print "Extract tar ball $programGtkTarFullName to output $programGtkFolderFullName"
tar xf output/$programGtkTarFullName.orig.tar.gz -C output/$programGtkFolderFullName --strip-components 2

print "Building electro lib"
buildPackage $libFolderFullName

print "Installing electro lib to make sure that electrotest can build"
sudo dpkg -i "output/"$libTarFullName"-1_i386.deb"

equalToZeroOtherwiseFailure $? "Failed to install $libTarFullName"

print "Starting to build electro test"
buildPackage $programFolderFullName

print "Starting to build electro test"
buildPackage $programGtkFolderFullName


print "Uninstalling electrolib"
sudo dpkg -r $libReleaseName

equalToZeroOtherwiseFailure $? "Failed to uninstall $libReleaseName"

quit