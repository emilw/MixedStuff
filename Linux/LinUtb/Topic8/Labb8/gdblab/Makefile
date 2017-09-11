CC = gcc
LIBFLAG = -L. -lgdb -Wl,-rpath,.

all:	program

program:	main.c libgdb.so
		$(CC) -o program main.c $(LIBFLAG)

libgdb.so:	lib/gdblab.c lib/gdblab.h 
		$(CC) -c -fPIC lib/gdblab.c
		$(CC) -shared -fPIC -o libgdb.so gdblab.o
		
