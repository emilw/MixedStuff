#include <stdio.h>

int main(int argc, char **argv)
{
    if(argc == 1){
        printf("No arguments provided");
    }
    else if(argc == 3){
        int a = atoi(argv[1]);
        int b = atoi(argv[2]);

        int result = a + b;
        printf("%d", result);
        //printf("Adding %d + %d is %d",a, b, result);
    } else{
        printf("Wrong amount of arguments provided");
    }

    printf("\n");
}