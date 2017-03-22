#!/bin/bash

globalFailingTestCounter=0
allTestsCounter=0

function checkStatusAndTakeAction {
    local testText=$1
    local status=$2

    allTestsCounter=$(($allTestsCounter+1))

    if [ $status == 0 ]; then
        echo "$testText works"
    else
        echo "=====> $testText do not work"
        globalFailingTestCounter=$(($globalFailingTestCounter+1))
    fi
}

make -C 5D all
checkStatusAndTakeAction "Make all" $?

make -C 5D clean
checkStatusAndTakeAction "Make clean" $?

sudo make -C 5D install
checkStatusAndTakeAction "Make install" $?

sudo make -C 5D uninstall
checkStatusAndTakeAction "Make uninstall" $?

if [ $globalFailingTestCounter -gt 0 ]; then
    echo "ERROR: $globalFailingTestCounter out of $allTestsCounter tests failed, please check above for details"
else
    echo "SUCCESS: All($allTestsCounter) tests passed!"
fi

exit $globalFailingTestCounter