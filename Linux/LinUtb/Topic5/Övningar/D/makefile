all: program

program: a_functions.o b_functions.o c_functions.o d_functions.o main.o
	gcc -o bin/program1 a_functions.o b_functions.o c_functions.o d_functions.o main.o

main.o: main.c main.h
	gcc -c main.c main.h

d_functions.o: d_functions.c d.h
	gcc -c d_functions.c d.h

c_functions.o: c_functions.c c.h
	gcc -c c_functions.c c.h

b_functions.o: b_functions.c b.h
	gcc -c b_functions.c b.h

a_functions.o: a_functions.c a.h
	gcc -c a_functions.c a.h

clean:
	rm *.o
	rm bin/program1

install: program
	cp bin/program1 /usr/local/bin/program1

uninstall:
	rm /usr/local/bin/program1
