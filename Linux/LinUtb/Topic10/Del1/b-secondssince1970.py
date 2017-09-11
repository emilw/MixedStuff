import datetime

print("Todays date:")
print(datetime.date.today())
print("Number of seconds since 1970-01-01:")
print(datetime.datetime.strftime(datetime.datetime.now(), "%s"))