#include <stdio.h>
//#include "my_add.c"

int main(int argc, char **argv)
{
    int sum = 0;
    char lastEnteredCharacter = '\n';

    while(1){
        char enteredCharacter = getchar();
        
        if(enteredCharacter != '\n'){
            sum = add(sum, atoi(&enteredCharacter));//sum + atoi(&enteredCharacter);
        } else{
            if(lastEnteredCharacter == enteredCharacter){
                break;
            }
        }

        lastEnteredCharacter = enteredCharacter;
    }

    printf("%d \n", sum);
}