#!/bin/bash
function quit {
    exit
}

make -C ../Topic6/Labb6/lib/libpower clean
make -C ../Topic6/Labb6/lib/libresistance clean
make -C ../Topic6/Labb6/lib/libcomponent clean
make -C ../Topic6/Labb6 clean

#Get the latest lib version
tar -cvzf latestLibs.tar.gz ../Topic6/Labb6/lib --exclude='*.gch' --exclude='../Topic6/Labb6/lib/libresistance/docs'

#Get the latest electrotest version excluding GIT stuff and the libs
tar -cvzf latestElectroTest.tar.gz ../Topic6/Labb6 --exclude='../Topic6/Labb6/.git' --exclude='*.gch'

#Get the latest electrotestgtk version
tar -cvzf latestElectroTestGtk.tar.gz ../Topic11/labb11

quit