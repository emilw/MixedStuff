EMIL WESTHOLM 2017-01-20

# Övning 4 - Vi användarhandledning(skriven i Nano)

## Användar handledning
### 1 Kommando läge kontra editeringsläge
Det finns två lägen i VI ett kommandoläge och ett editeringsläge.

Tryck Insert för att komma till editerinsläget. I det läget går det bra att editera texten på skärmen.

För att kunna utföra kommandon måste du gå ur editeringsläge, det gör enklast med att trycka på Escape.

### 2 Starta och avsluta
För att starta Vi kör följande:
```bash
vi filnamn
```

För att stänga av vi skriv kommandot(Gå över i kommandoläge med Esc):

* wq => Stänger av VI och sparar dina ändringar
* q! => Stänger av VI men sparar inte dina ändringar

### 3 Skapa/Spara och öppna filer

För att skapa en ny fil:
* vi filSomInteFinns
* Editera filen
* Gå över i kommandoläge
* skriv in w

För att spara en fil:
* Gå över i kommandoläge
* skriv in w

För att öppna en befintlig fil
* vi filSomRedanFinns

### 4 Skriva vanlig text
Vanlig text skrivs i Edit läget som du når via Insert läget i VI.

### 5 Vandra mellan olika delar i texten
Följande är de vanligaste sätten att röra sig i texten(detta görs i kommando läge):
* Gå en bokstav till vänster => vänster pil
* Gå en bokstav till höger => höger pil
* Gå ned en rad => pil nedåt
* Gå upp en rad => pil uppåt
* Flytta till början av nästa ord => w
* Flytta tillbaka till föregående ord => b
* Flytta till slutet av raden => $
* Flytta till sista raden => :$
* Flytta till första raden => :0
* Flytta till rad x => :x


### 6 Kopiera, Klippa och klistra in text
* Kopiera text
** Gå till raden där text ska kopieras, tryck yy för att kopiera raden
* Klistra in text
** Gå till raden där text ska klistras in, tryck p för att klistra in
* Klippa ut text
** Gå till raden där text ska kopieras, tryck d för att klippa ut

### 7 Söker och ersätter text
* Söka efter texten hej
/hej
* Leta vidare efter nästa som matchar sökningen på hej
n
* Gå tillbaka till tidigare sökträffar
N
* Söka baklänges efter hej
?hej
* Ersätta den första hej med Hej
:s/hej/Hej
* Ersätta alla hej med Hej
:%s/hej/Hej

### 8 Namn, titel och datum => Se i början av dokumentet

### 9 Vad är ASCII?
ASCII är en tecken uppsättning som avgör vilka tecken som finns tillgängliga. Man använder olika ASCII grupper för olika delar i världen då ASCII inte kan hantera
alla. Det blir ofta problem om man har multinationella system som måste e.g. tolka lokala tecken om man använder ASCII, här är Unicode ett bättre alternativ då det
kan hantera alla idag kända tecken vilket förenklar.

### 10 Hitta namn med Hexedit och ersätt det

Innan:
45 6D 69 6C  20 57 65 73  74 68 6F 6C  6D 
Efter:
45 4D 49 4C  20 57 45 53  54 48 4F 4C  4D
