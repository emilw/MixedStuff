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
Jag har försökt att utveckla libresistance med testdriven utveckling även då jag inte har något "riktigt" test ramverk så såg jag till att sätta upp tester för metoden innan för att täcka in respektive krav.
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
- Wl gör det möjligt för oss att skicka in commandon i länkningen, exempelvis rpath=. underlättar så att man även vid körning av programmet kan peka ut vart libresistance.so finns. Detta eftersom man ibland inte kan lita på att default mapparna(PATH variabeln) i ett system stämmer med det man förväntar sig. För utvecklings ändamål när man vill testa av sitt bilbiotek är det utmärkt. I mitt fall så vill jag köra på min lokala kopia av biblioteket.
- L. Pekar ut sökvägen var libresistance.so hittas under länkningen. I mitt fall vill jag att den länkar mot samma mapp, alltså ".".

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
Det nedan är en kopia från vår gemensamma dokumentation här: [https://github.com/linUM141/Labb6/blob/master/README.md](https://github.com/linUM141/Labb6/blob/master/README.md)

Projekt teamet var:
- Daniel Hammarberg
- Thomas Larsson
- Emil Westholm

------------

# Kom igång
Det finns tre alternativ tillgängliga för att komma igång, de listas nedan.

## Bygg bara biblioteken
Om du vill få fram en version av biblioteken så kör du:
```bash
make lib
```
Det kommer att skapa tre filer:
- libresistance.so
- libpower.so
- libcomponent.so

under mappen lib/.

### Teknisk beskrivning
Respektive komponent byggs som vanligt fast med positionsoberoende kod som är ett krav för att kunna agera som ett länkningsbart bibliotek.
Växeln som används för detta är -fPIC.

Nedan är exemplet för libresistance.c: 
```bash
.
libresistance.o: lib/libresistance/libresistance.c lib/libresistance/libresistance.h
	gcc -c -fPIC lib/libresistance/libresistance.c lib/libresistance/libresistance.h
.
.
```
För att kunna skapa en *.so-fil, alltså ett bibliotek som länkas in dynamiskt, så måste man skapa det från objektsfilen som skapades i förra steget. Det sker genom flaggan -shared och -fPIC.

Se nedan för exempel:
```bash
.
gcc -shared -fPIC -o lib/libresistance.so libresistance.o
.
.
```

## Köra i lib och program "utvecklingsläge"
Om du vill köra i "utvecklingsläge" med lib och program kör du:
```bash
make
#samma som "make all"
```
Det som händer när ovanstående kommando körs är att:
- Biblioteken byggs, se ovan beskrivning (make lib).
- En version av programmet skapas och länkas hårt mot versionen av biblioteket under lib/

Kör programmet med kommandot nedan i root mappen för projektet:
```bash
./electrotest
```

### Teknisk beskrivning
Här länkas biblioteken in hårt från lib/, detta görs med flaggorna:
- -L som säger vart länkaren ska leta efter biblioteken
- -Wl,-rpath= som pekar ut vart programmet ska titta efter biblioteket vid exekvering

Se nedan för exempel:
```bash
gcc -L./lib -Wall -o electrotest main.c -lresistance -lpower -lcomponent -Wl,-rpath=./lib
```

## Installera program
Här installeras programmet och biblioteken i de publika mapparna på datorn.

Programmet installeras under:/usr/local/bin/

Biblioteket installeras under:/usr/lib/

För att installera:
```bash
make install
```

För att köra programmet:
```bash
electrotest
```
### Teknisk beskrivning
Här utförs i princip samma sak som när utvecklingsversionen av programmet och biblioteken skapas. Den stora skillnaden är:
- lib-filerna kopieras in i de publika mapparna
- programmet länkas mot de publika mapparna på datorn
- programmet kopieras till de publika mapparna på datorn

Då default-beteendet vid länkning och var man ska titta efter *.so-filer i gcc är att titta i de publika mapparna så tar vi mer eller mindre bort de specificerande flaggorna som vi hade när vi länkade utvecklingsprogrammet.

Se nedan för exempel:
```bash
gcc -Wall -o electrotest main.c -lresistance -lpower -lcomponent
```

## Avinstallera program
Här avinstalleras programmet och biblioteken från de publika mapparna på datorn.

Programmet tas bort från: /usr/local/bin/

Biblioteket tas bort från: /usr/lib/

För att avinstallera:
```bash
make uninstall
```

------------

## Del 3
Sammarbetet har gått bra, vi valde nästan direkt att köra på ett Github konto i och med att vi alla hade användare där.
Github har även många integrerade applikationer, så som Gitter som är en chat klient och Travis som är en bygg server.
För att säkerställa att vi alla ser samma sak och att ingen plockar in saker som inte fungerar så var det viktigt för oss,
att vi hade automatiserade byggen och tester.

Genom att dela upp de olika bilblioteken så fick vi en tydlig uppdelning på vad var och en skulle utföra vilket gjorde att vi kunde jobbar var för sig.
De delar som vi fick problem med och som vi behövde diskutera var hur vi testade respektive bibliotek.
Jag valde att köra:
make test
och efter lite diskussion så hängde de andra med på det, det är något vi skulle bestämt från början för att få det lite smidigare.
Vi skulle också ha tagit ett redan existerande unit testing ramverk men det kändes som lite "overkill", dock så tycker jag att det
blev lite rörigt för vi löste testerna på lite olika sätt.

För mig var nyckeln till framgång:
- Bygg server
- Att alla funktioner har täckning av automatiserade tester
- Om projektet växer behövs även integrations tester, i det här fallet så skulle electrotest applikationen behöva testas av bättre.
- Gitter fungerade bra för chattar, men vi skulle nog ha behövt Skype for business eller linkande där vi kan dela skärm och ha tel möten om projektet växte.

Allt är publikt, och nås via länkarna nedan:
- Github projektet/repository: [https://github.com/linUM141/Labb6](https://github.com/linUM141/Labb6)
- CI/Bygg server: [https://travis-ci.org/linUM141/Labb6/builds](https://travis-ci.org/linUM141/Labb6/builds)
- Chat forum: [https://gitter.im/linUM141/Lobby](https://gitter.im/linUM141/Lobby)