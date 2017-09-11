#!/usr/bin/python
import sys
import datetime
import io

fileName = "loggedin"

def getCurrentStat():
    try:
        readFile = open(fileName, "r")
        fileContent = readFile.readline()
        return int(fileContent)
    except:
        file = open(fileName, "w")
        file.write("0")
        file.close()
        return 0

def updateStat(newSum):
    file = open(fileName, "w")
    file.write(str(newSum))
    file.close()

def getStatusText():
    status = getCurrentStat()
    statusText = "Inloggad"
    if(status == 0):
        statusText = "Utloggad"
    
    return "{0}({1})".format(statusText, status)

if len(sys.argv) != 2:
    print "No argument or more than 1 argument. One argument is allowed and it can either be 'in' or 'ut'"
else:
    action = sys.argv[1]
    print("Action to perform is: {0} ".format(action))
    numberToAddOrSubtract = 0
    
    if(action == "in"):
        numberToAddOrSubtract = 1
    if(action == "ut"):
        numberToAddOrSubtract = -1

    if(numberToAddOrSubtract != 0):
        currentSum = getCurrentStat()
        currentSum = currentSum + numberToAddOrSubtract
        if(currentSum >= 0):
            updateStat(currentSum)
print("Status: {0}".format(getStatusText()))