import datetime
import io

currentTimeStamp = datetime.datetime.strftime(datetime.datetime.now(), "%s")
print(currentTimeStamp)
file = open("datefile", "w")
file.write(currentTimeStamp)
file.close()