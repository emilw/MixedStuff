#!/bin/bash
function quit {
    exit
}  

function log {
    echo "$@"
}

function getNumberOfLines {
    wc -l < timetracker
}

function isStarted {
    createFileIfNotExists
    if [ $( getNumberOfLines ) -eq 1 ]; then
        return 1
    else
        return 0
    fi
}

function timerStat {
    local startTime=$( head -n 1 timetracker)
    local started=$1
    local stopTime=$( date +%s )
    local message="The timer have been running for"

    if [ $started -eq 0 ]; then
        stopTime=$(tail -n 1 timetracker)
        message="The last session lasted for"
    fi

    local duration=$(($stopTime-$startTime))

    log "$message: $duration seconds"

}

function printStatus {
    isStarted
    local started=$?
    if [ $started -eq 1 ]; then
        log "Status: The timer is started"
    else
        log "Status: The timer is stopped"
    fi

    timerStat $started
}

function createFileIfNotExists {
    if [ ! -f "timetracker" ]; then
         touch "timetracker"
         echo "0" > timetracker
         echo "0" >> timetracker
     fi
}

function saveStartTime {
    isStarted
    date +%s > timetracker
}

function saveStopTime {
    isStarted
    local started=$?
    if [ $started -eq 0 ]; then
        log "There is no timetrack started, please run with parameter 'start' to start a new time track session"
    else
        date +%s >> timetracker
    fi
}


if [ "$1" == "start" ]; then
    log "Starting..."
    saveStartTime
    printStatus
elif [ "$1" == "stop" ]; then
    log "Stopping..."
    saveStopTime
    printStatus
elif [ "$1" == "status" ]; then
    log "Retrieving status..."
    printStatus
else
    log "Please provide start, stop or status as input parameter."
fi

quit