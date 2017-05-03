# Övning 13

## Introduktion
Så som jag har förstått det så kan man skapa ett debianpaket på två olika sätt, antingen med bara binärerna som man kopierar i debian strukturen eller hela vägen från ett källkodsrepository där man sätter upp ett flöde från kod till färdigt paket.
Jag har här försökt beskriva det sistnämnda, alltså:

- Repository med källkod
- Tar representation
- Bygga källkod
- Bygga debian paketet

För att snabba upp skapandet av ett nytt debian paket så har jag skapat två skript:
- Skapa ny tar fil med en fräsh kopia av repositoryt(createTarWithTheLatest.sh)
- Skapa debian paketet baserat på tar filen skapad i tidigare steg(createPackages.sh)

## Skapa tar arkiv(createTarWithTheLatest.sh)
För att frikoppla källkodsbiblioteket och själva genereringsprocessen så skapades ett skript som skapar ett tar arkiv med källkoden.

För att undvika att inkludera saker som inte ska med så har undantag lagts in i paketeringen av arkivet.

Se nedan för skapandet av tar bibliotek med det senaste för electrolib och electrotest.

```bash
#Get the latest lib version
tar -cvzf latestLibs.tar.gz ../Topic6/Labb6/lib --exclude='*.gch' --exclude='../Topic6/Labb6/lib/libresistance/docs'

#Get the latest electrolib version excluding GIT stuff and the libs
tar -cvzf latestElectroTest.tar.gz ../Topic6/Labb6 --exclude='../Topic6/Labb6/.git' --exclude='*.gch'
```

## Skapa debian paket(createPackages.sh)
Skapandet av debian paketet startar med tar arkivet som skapades i föregående steg, den är själva input parametern till bygg steget av paketet.

### Preppa tar arkivet(Kolla om namnet spelar någon roll)
För att tar arkivet skall fungera så måste det följa en given namnstandard, namnstandarden ser ut enligt följande:

*packagename.orig.tar.gz*

Genereringen ser ut såhär i skriptet:
```bash
cp latestLibs.tar.gz output/electrolib.orig.tar.gz
```

### Skapa debian strukturen
Nu är källan iordninggjord, men vi har inte färdigställt destinationen, alltså debian paketstrukturen.
Det finns ett fördefinerat antal mappar och filer som måste skapas för att få en korrekt debian paketsstuktur.

Filstrukturen ser ut enligt nedan:
```bash
electrolib_1.0 #packageName_Version
  |--debian
        |--changelog
        |--rules
        |--control
        |--copyright
        |--compat
        |--source
            |--format
```
#### Pakethistorik(changelog)
Pakethistoriken beskriver vilka ändringar som gjorts mellan olika versioner av paketet.
Historikposten skapas i en initial version så som visas nedan:
```bash
dch --create -v 1.0-1 --package electrolib
```

#### Byggregler(rules)
Senare kommer vi köra ett kommando som heter ```debuild``` som kommer generera det slutgiltiga paketet. ```debuild``` kör bygget av källkoden, det betyder att den anropar följande i ursprungs repositoryt:
- ```make```
- ```make install```

Problemet med det ovan är att ```make install``` installerar binärerna som skapades i ```make``` direkt i ex. /usr/lib direkt på maskinen, medan vi vill att den ska genereras ut i debian paket strukturen.
Regel filen rules tillåter oss att injicera speciella instruktioner i olika delar av ```debuild``` processen. Det vi har behov av är att göra så att våran makefil kan generera ut/kopiera *.so/binärerna till debian strukturen när den körs via ```debuild```.

rules filen med ändringen:
```make
override_dh_auto_install:
	$(MAKE) DESTDIR=$$(pwd)/debian/electrolib prefix=/usr/ install
```
Det som händer här är att vi överrider steget ```override_dh_auto_install``` och tar och sätter variabeln DESTDIR och prefix till världen som passar debian paket strukturen. Dessa i sin tur används sedan i makefilen, alltså(exempel från makefile för electrolib):
```make
prefix = /usr/
bindir = $(prefix)lib/

all: lib

install: lib
	sudo cp libresistance/libresistance.so $(DESTDIR)$(bindir)libresistance.so
	sudo cp libpower/libpower.so $(DESTDIR)$(bindir)libpower.so
	sudo cp libcomponent/libcomponent.so $(DESTDIR)$(bindir)libcomponent.so

lib:
	make -C libresistance
	make -C libpower
	make -C libcomponent
```
#### "Kontroll filen"(control)
Kontrollfilen är själva definitionen av debian paketet, här anges information om exempelvis förkrav, versionsnamn, namn etc. Enklast är att visa filens innehåll:
```
Source: electrotest
Maintainer: Emil Westholm <emil@postback.se>
Section: misc
Priority: optional
Standards-Version: 1.0
Build-Depends: electrolib

Package: electrotest
Architecture: any
Depends: electrolib
Description: This is the electrotest application that simplifies calculation of resistance components.
```

Ovan visas filen för electrotest, här ser vi exempelvis att den har förkrav på electrolib, alltså att den finns installerad både när paketet skapas och när det ska installeras.

#### Copyeright(copyright)
Den här filen innehåller information och copyright, alltså vilka rättigheter som följer med programvaran.
Jag har lämnat denna tom för denna uppgiften.

#### Debhelper version(compat)
compat filen innehåller versionen av debhelper, alltså det toolset man nyttjat för att generera paketet. Den är satt till version 9 i mitt paket.

#### Paketformat(source/format)
Beskriver vilket paket format som används. Här har jag använt ```3.0 (native)```

### Fyll på debian paket strukturen med källan
Nästa steg är att fylla på den strukturen som skapats tidigare. Det görs genom att extrahera tar filen till paketestrukturen, se nedan:
```bash
tar xf output/electrolib.orig.tar.gz  -C output/electrolib --strip-components 3
```
*I skriptet ovan används också ```--strip-components``` detta för att inte ta med filstrukturen som nyttjades när tar arkivet skapades.*

### Bygg paketet
Nu kommer det slutgiltiga steget och det är när den påfyllda strukturen ska byggas för att generera det slutgiltiga deb paketet.
Här sker primärt tre saker:
- ```make``` för att bygga källkoden
- ```make install``` för att kopiera binärerna till destinationsmappen(*/debian/electrotlib/usr/lib)
- lintian körs för att validera paketet


## Notis om bilagt tar arkiv
Eftersom jag inte ville lägga med allt från Labb6 och Labb11 så har jag lagt med dem som tar arkiv, det betyder att createTarWithTheLatest.sh inte går att köra utan att man har Labb6 och Labb11 på plats samt justerade makefiler med justeringar.