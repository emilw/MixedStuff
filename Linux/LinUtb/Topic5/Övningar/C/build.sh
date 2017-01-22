#One liner
##gcc my_add.c main.c -o plus_x
#In steps
gcc -c my_add.c -o my_add.o
gcc -c main.c -o main.o
gcc -o plus_x my_add.o main.o 