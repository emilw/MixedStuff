
# Övning 8

## Del A(Debug)
### 1 Ändringar i Make fil
Förändringar i Makefilen:

```diff
program:       main.c libgdb.so
-               $(CC) -o program main.c $(LIBFLAG)
+               $(CC) -g -o program main.c $(LIBFLAG)
 
 libgdb.so:     lib/gdblab.c lib/gdblab.h 
-               $(CC) -c -fPIC lib/gdblab.c
+               $(CC) -g -c -fPIC lib/gdblab.c
                $(CC) -shared -fPIC -o libgdb.so gdblab.o

```

### 2 Debug session
Startade debuggern:
```bash
gdb program
```
Lade in en breakpoint i gdblab.c för att kolla värdena på variablerna:
```bash
break lib/gdblab.c:29
```

Startade debug sessionen:
```bash
run
```
Debuggern träffade brytpunkten:
```bash
Breakpoint 1, test () at lib/gdblab.c:29
29		printf("45 + 5 = %i\n", test->buffert2[0] + test->buffert2[1]);
```
Skriv ut hur koden ser ut i området innan och efter för att kunna orientera sig:
```bash
(gdb) list 13,50
13			int buffert2[16];
14		}theTest;
15	
16		theTest *test = malloc(sizeof(theTest));
17	
18		int j=2;
19	
20		for (i=0; i<=16; i++)
21		{
22			test->buffert1[i] = i;
23		}
24	
25		test->buffert2[0] = 45;
26		test->buffert2[1] = 5;
27	
28		printf("16 + 14 = %i\n", test->buffert1[16] + test->buffert1[14]);
29		printf("45 + 5 = %i\n", test->buffert2[0] + test->buffert2[1]);
30		free(test);
31	
32		//test->buffert2[0] = 5;
33		//printf("16 + 14 = %i\n", test->buffert1[16] + test->buffert1[14]);
```
Skriv ut värdet av buffert1[16]
```bash
(gdb) print test->buffert1[16]
$s40 = 45
```
Förväntade värdet borde vara 16, men i och med att en array med storlek 16 går mellan 0->15 så verkar det som vi träffar buffert2 arrayen.
Kör färdigt körningen:
```bash
(gdb) continue
```
Lägger in en breakpoint tidigare, innan buffert2 sätts:
```bash
break lib/gdblab.c:24
run
(gdb) print test->buffert1[16]
$41 = 16
(gdb) continue
(gdb) print test->buffert1[16]
$42 = 45
```
Det verkar som att den första arrayen skriver till första positionen i den andra arrayen, felet är att buffert1 addresserat över 15, alltså till 16.
buffert1[16] är alltså samma som buffert2[0].

*Istället för att ha lagt in en break point till så hade jag kunnat nyttja ```step``` eller ```next``` för att gå igenom koden och in genom funktionerna rad för rad. I ett större projekt så hade det varit svårare att placera ut brytpunkterna så direkt som i detta fall.*


### 3 Vad som var fel i programmet
#### 1. 45 + 5 == 50
Fel array användes i utskriften, ändringen jag gjorde var:
```diff
        printf("16 + 14 = %i\n", test->buffert1[16] + test->buffert1[14]);
-       printf("45 + 5 = %i\n", test->buffert1[0] + test->buffert1[1]);
+       printf("45 + 5 = %i\n", test->buffert2[0] + test->buffert2[1]);
        free(test);
```
#### 2. 16 + 14 = 30
I och med att den första arrayen var för liten och allokerade en position i den andra, så skrev den andra arrayen över "sista" positionen i den första arrayen. För att hantera det med minimalt med ändringar, utökade jag array 1 till att vara 17 positioner(0-16).
```diff
{
        int i;
        typedef struct{
-               int buffert1[16];
+               int buffert1[17];
                int buffert2[16];
        }theTest;

```
## Del B(Trace)
Testerna kördens med errorprog_32.
### Vilken fil saknas?
Filen som saknas är data.txt
### Vilken exitkod returneras?
Programmet returnerar exit kod 3.
### Vilken file descriptor får den efter att fil lagts in?
open på data.txt ger file descriptor 3.
Utskriften på skärmen sker via file descriptor 1(Standard output) i write
### Vilken exitkod returneras efter efter att en fil har lagts in?
Programmet returnerar exit kod 3.