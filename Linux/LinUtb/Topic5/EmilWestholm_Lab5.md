

# Övning 5

## Bygg kommandon
Alla bygg kommandon ligger i respektive mapp som ett sh bash script, förutom uppgift D, där ligger allt i makefilen.

### A
```bash
gcc my_add_2.c -o plus_2
```

### B
```bash
gcc my_add_x.c -o plus_x
```

### C
```bash
#In steps
gcc -c my_add.c -o my_add.o
gcc -c main.c -o main.o
gcc -o plus_x my_add.o main.o lime@ewautomation:~/Repos/MixedStuff/Linux/LinUtb/
```

### D
```bash
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
```
