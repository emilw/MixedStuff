# Övning 6

## Del 1

### Funktion och användning
Funktionen beräknar resistansen för seriellt eller parallellt kopplade komponenter.
Det är två huvudscenarion som funktionen hanterar, det är om man skickar in:
- P för parallellt
- S för seriellt

Beroende på de ovan avgörs om seriell eller parallell resistans ska beräknas.

I tillägg till dessa så skickas även en lista med resistansvärden som används som grund för beräkningen.

*Om några av parametrarna är felaktiga kommer metoden att reutrnera -1*

### Algoritmbeskrivning
#### Felhantering
I början av metoden så testas alla input parametrar så att de ska vara valida. Invalida parametrar medför att metoden returnerar -1.
#### Beräkning av resistansen
Beräkning av resistansen sker genom en loop som går igenom alla resistansvärden och applicerar följande logik per resistansvärde:

- Om kopplingsparametern är satt till Parallell lägg till 1/resistansvärdet
- Om kopplingsparametern är Seriell lägg till resistansvärdet
- Om kopplingsparametern är Parallell och resistansvärdet är 0, stoppa loopen och returnera 0 som totalt resistansvärde

*Efter loopen är slutförd så kommer det totala resistansvärdet att räknas om med 1/resistansvärdet om kopplingsparametern är P annars returneras summan rakt av*

#### Kompilering och testing
Jag har försökt att utveckla den här med testdriven utveckling även då jag inte har något "riktigt" test ramverk så såg jag till att sätta upp tester för metoden innan och respektive krav.
För att kunna uppnå det så skapade jag ett program som jag valt att kalla test_main som gör anropen till mitt bibliotek.
Nedan är makefilen för projektet.
```make
all: lib

program: lib
	gcc -L. -Wall -o test_main test_main.c -lresistance -Wl,-rpath=.

lib: libresistance.o
	gcc -shared -fPIC -o libresistance.so libresistance.o

libresistance.o: libresistance.c libresistance.h
	gcc -c -fPIC libresistance.c libresistance.h

clean:
	rm *.o
	rm *.so
	rm test_main

test: program
	./test_main

install: lib
	cp libresistance.so /usr/local/bin/libresistance.so

uninstall:
	rm /usr/local/bin/libresistance.so
```

##### Förklaring make
```bash
libresistance.o: libresistance.c libresistance.h
	gcc -c -fPIC libresistance.c libresistance.h
```
Producerar en objektsfil med positionsoberonde kod, objektsfilen skapas utan att länkas
```bash
lib: libresistance.o
	gcc -shared -fPIC -o libresistance.so libresistance.o
```
Tar output filen från libresistance.o och gör den delad("shared"), det är den här som skapar *.so filen som sedan kan laddas in dynamiskt i programmet.

```bash
program: lib
	gcc -L. -Wall -o test_main test_main.c -lresistance -Wl,-rpath=.
```
Här sker länkningen till ett körbart program.

test_main.c(mitt testprogram) länkas till:
- lresistance => söker på *lib* resistance *.so*
- Wl gör det möjligt för oss att skicka in commandon i länkningen, exempelvis rpath=. underlättar så att man även vid körning av programmet kan peka ut vart libresistance.so finns. Detta eftersom man ibland inte kan lita på att default mapparna(PATH variabeln) i ett system stämmer med det man förväntar sig. 
- L. Pekar ut sökvägen var libresistance.so hittas under länkningen

##### Bygga rutin
För att bygga resistance.so:
```bash
make
```

För att bygga testprogrammet:
```bash
make program
```

För att bygga resistance.so och köra testerna(den här kör jag varje gång jag ändrar något i koden för att se att det kompilerar samt att testerna fungerar):
```bash
make test
```

#### Beskriva testprogrammet
Då jag har gjort detta på ett testdrivet sätt, så kör programmet alla funktionstesterna när man kör det. Den tar alltså inga inputparametrar.

Exempel på utdrag ur testprogrammet(test_main.c):
```c
float testArrayWithRealResistanceScenario[2] = {150,300};
    returnValue = calc_resistance(sizeof(testArrayWithRealResistanceScenario)/sizeof(testArrayWithRealResistanceScenario[0]), 'P', testArrayWithRealResistanceScenario);
    testResult = assertIsTheSame("Verify that summary of resistance items for P is working", 100, returnValue);
.
.
.
.
if(testResult != TRUE){
    printFailedTestText("All", "There were tests failing, se above for more information");
    return 1;
} else {
    printSuccessTestText("All","All tests were ok!");
    return 0;
}
```

## Del 2


## Del 3