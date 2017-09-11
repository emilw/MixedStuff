import datetime
import io

file = open("datefile", "r")
savedTimeStamp = file.readline()
file.close()
currentTimeStamp = datetime.datetime.strftime(datetime.datetime.now(), "%s")
print("Current seconds from 1970-01-01: {0}".format(currentTimeStamp))
print("Saved number of seconds(from datefile): {0}".format(savedTimeStamp))
print("Calculation: {0}-{1}={2}".format(currentTimeStamp, savedTimeStamp, int(currentTimeStamp)-int(savedTimeStamp)))