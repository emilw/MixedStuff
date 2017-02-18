#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <signal.h>

#include "gdblab.h"

int test()
{
	int i;
	typedef struct{
		int buffert1[16];
		int buffert2[16];
	}theTest;

	theTest *test = malloc(sizeof(theTest));

	int j=2;

	for (i=0; i<=16; i++)
	{
		test->buffert1[i] = i;
	}

	test->buffert2[0] = 45;
	test->buffert2[1] = 5;

	printf("16 + 14 = %i\n", test->buffert1[16] + test->buffert1[14]);
	printf("45 + 5 = %i\n", test->buffert1[0] + test->buffert1[1]);
	free(test);

	//test->buffert2[0] = 5;
	//printf("16 + 14 = %i\n", test->buffert1[16] + test->buffert1[14]);

	//kill(getpid(),SIGSEGV);

return 0;
}
