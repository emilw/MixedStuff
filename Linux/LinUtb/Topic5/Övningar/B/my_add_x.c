#include <stdio.h>

int main(int argc, char **argv)
{
    int sum = 0;
    char lastEnteredCharacter = '\n';

    while(1){
        char enteredCharacter = getchar();
        
        if(enteredCharacter != '\n'){
            sum = addNumbers(sum, atoi(&enteredCharacter));//sum + atoi(&enteredCharacter);
        } else{
            if(lastEnteredCharacter == enteredCharacter){
                break;
            }
        }

        lastEnteredCharacter = enteredCharacter;
    }

    printf("%d \n", sum);
}

int addNumbers(int value1, int value2){
    return value1 + value2;
}