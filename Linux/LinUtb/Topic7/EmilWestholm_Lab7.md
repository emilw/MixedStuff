# Övning 7

Alla filer ligger i respektive undermap med samma nummer.

## Del 1(Man sida)

### Skapa man sida
Läs man sidan
```bash
man -l resistance.l 
```
Skapad postscript fil:
```bash
groff -man resistance.l -T ps > resistance.ps
```

## Del 2(Diff/Patch)
Diff och patch scenario

```bash
$cat version1
-----------------
Testrad1
Testrad2
Testrad3
Testrad5
Testrad6
Testrad7

$cat version2
-----------------
Testrad1
Testrad2
Testrad3
Testrad4
Testrad5
Testrad6
Testrad7
```
Skapa en diff fil av skillnaden och applicera den på version1 filen

```bash
#Skapa diff fil
$diff version1 version2 > version1ToVersion2.patch

#Applicera ändringen i version1
$patch version1 version1ToVersion2.patch
```
### Beskrvning av exemplet ovan
Version 1 är den den första versionen av mina ändringar. För att hantera ändringar och enkelt kunna gå tillbaka så tar jag en kopia på filen och fortsätter göra ändringarna där. Jag döper filen till Version 2.
Anledningen till det är att jag snabbt kan ta mig tillbaka till Version 1 samt se vilka skillnaderna är om jag vill se vad jag ändrat.

I Version 2 så lägger jag till en rad, som jag kallar Testrad4, den finns inte i Version 1.
När jag kör kommandot diff så specificerar jag:
- Version 1 filen
- Version 2 filen
- Sen väljer jag att styra ut den till version1ToVersion2.patch.

I Patch filen finns nu den exakta skillnaden mellan filerna.

Genom att köra patch och specificera:
- Version 1
- version1ToVersion2.patch

så kan jag lägga på den ändringen direkt i Version 1.

Om jag diffar Version 1 och Version 2 igen så kommer de inte att diffa.
### Arbetsflöde för större projekt
Exemplet ovan opererar enbart på en fil åt gången, men arbetsflödet är detsamma även för kataloger med fler filer och subkataloger.
Det som anges i de fallen är:
```bash
diff -ruN Version1Mapp Version2Mapp
```
Parametrar:
- *r* står för att den ska utföra diffen rekursivt i mappstrukturen
- *u* står för att den ska visa max context på 3 om inte mer specas, alltså antalet rader innan och efter diffen
- *N* står för att om man i en senare version kanske har lagt till en fil så ska diffen se den jämförelsen som mot en tom fil

För att applicera en diff på en mapp med fler sub mappar så kör man:

```bash
patch -p1 < version1ToVersion2.patch
```
I fallet ovan så innehåller version1ToVersion2.patch all filer som diffar.

Parametern som är viktig att ha koll på här är:
- *pN* den specificerar hur många slashar som ska tas bort för att matcha filerna i den fil struktur man ska applicera ändringen på.
Det vanliga som jag ser är att använda 1 så att man utgår ifrån att man står i den katalog man applicerar ändringen på men man är
inte känslig för att den som applicerar ändringen kanske har en annan struktur utanför arbetsmappen.

Om man tittar på vad vi åstadkommit med flödet ovan så har vi jobbat vidare i Version 2 alltså den nya ändringen som vi vill ha in,
sen så har vi tagit in den ändringen i standard/master(Version1). När vi vill börja med en ny ändring så tar vi en kopia av Version1 igen
och kör hela flödet en gång till.

Jag har kört en del GIT, jag förstod inte att det var härifrån det kom om jag ska vara ärlig.
Att kopiera nya mappar för varje ny version blir som en lokal kopia och sen så jämför man mot det som finns i branchen och applicerar de ändringar man vill ta med in i master.
Jag hade nog kör GIT för ovanstående flöde.

## Del 3(Awk och Sed)
### Lista användare och kommentarer
Kommandot som listar(listUsersAndComments.sh):
```bash
mawk -F: '{print $1"\t\t"$5}' /etc/passwd
```
### Byt ut svenska bokstäver
Kommandot som byter ut svenska bokstäver(replaceSwedishCharacters.sh):
```bash
sed -ie 's/å/aa/g; s/ä/ae/g; s/ö/oe/g' exampleFile.txt 
```
