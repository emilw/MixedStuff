

# Övning 2

## 1. Del 1

| Commando | Växel/Användning | Beskrivning |
| --- | --- | --- |
| Man | **Man cat** =&gt; Ger information om programmet cat. <br> **-help** =&gt; Hitta hjälp hur man använder Man <br> **K** alla man sidor som innehåller en text om man söker efter detaljer men är osäker på vilken manual man ska titta i | Kommando för att ta fram manualer för registrerade program |
| info | **Info Man** =&gt; Ger manualen till programmet Man  <br> **-apropos fileName** =&gt; Leta efter fileName i alla manualer  | Presenterar manualer i info formatet. Går att få mer interaktiv och modernare än **Man** |
| cp | **Cp file ../file** =&gt; kopierar file till ../file  <br> **-R** tar alla filer rekursivt från en mapp <br> **-p** behåller fil attribut så som rättigheter etc.  | Kopiera filer mellan mappar |
| mv | **Mv fil1 ../fil1** =&gt; flyttar fil1 till ../fil1  <br> **-f** fråga inte användaren om en fil skrivs över. Bra när du vill skriva över filer. <br> **-n** skriver inte över existerande filer med samma namn  | Flytta filer mellan mappar eller byta namn |
| mkdir | **Mkdir hej** =&gt; Skapar mappen hej  <br> **-m** överrida de default satta rättigheterna när Mkdir körs utan –m   | Skapa mapp |
| rm | **rm fil** =&gt; Ta bort filen fil  <br> **-d** ta bort mappar också <br> **-r** ta bort filer rekursivt <br> **-f** utför utan att ställa frågor | Ta bort fil |
| find | **Find hello** =&gt; Hitta alla filer eller mappar som startar med hello i samma mapp där kommandot körs  <br> **-name** Söker på namn, möjligt att filtrera ut filer med &quot;\*.cs&quot; för att lista bara de filerna  **\!** Inverterad sök, välj de som inte matchar uttrycket i exempelvis **–name**   <br> **-size =&gt;** Hittar filer med en given storlek(använd + för att söka på större än) | Hitta filer |
| cd | **Cd mapp** =&gt; Går till mappen **Cd ..** =&gt; Flyttar sig ur mappen **Cd /var/log** =&gt; Flyttar direkt dit utan att behöva navigera dit mapp för mapp | Byta mapp, används för att navigera sig genom fil systemet |
| pwd | **Pwd** =&gt; Full sökväg dit man står | Vart i filsystemet man är just nu |
| Df | **Df** =&gt; Visar en översikt över alla monterade enheter  <br> **-H** =&gt; Visar mer lättläst hur mycket utrymme som är kvar.  **Jag ser ingen nytta av att lista fler** | Disk information för att se vart olika mappar är monterade. Bra att ha koll på för att kolla hur mycket disk som finns kvar eller vart ett SD kort är mappat etc. |
| Ps | **Ps** =&gt; Listar alla processer för den användare som kör kommandot  <br> **-A** Visar alla processerna som körs på systemet just nu. <br> **-f** Visar mer information om respektive process <br> **-P** Hitta process utifrån process id  | Information om processer, olika möjligheter att se vad som körs just nu. |
| Du | **Du** =&gt; Listar alla mappar och hur mycket de innehåller  <br> **-h** =&gt; Presenterar storlekarna i Kb/Mb/Kb etc. <br> **-c** =&gt; Presenterar en total <br> **-a** =&gt; Listar alla filer i mapparna för att få möjlighet att se exakt vilken fil som tar plats | Presenterar information om diskanvändning |
| tar | **Tar –cvf minMapp.tar MinMapp** =&gt; Lägger alla filerna från MinMapp i minMapp.tar  <br> **-c** =&gt; Skapa tar arkiv-f =&gt; Specificera filen att skriva till-v =&gt; Skriver ut vad som läggs i arkivet <br> **-t =&gt;** Lista filer i en tar | Packar en mapp eller ett gäng med filer till ett tar arkiv |
| seq | **seq 1 4** =&gt; Presenterar en lista med talen 1,2,3,4  <br> **-f** =&gt; Formatera sekvensens nummer till ett specificerat format. <br> **-s** =&gt; Lägg in en avgränsare mellan respektive element i serien, bra om man behöver parsea ut dem en och en i vidare bearbetning.  | Presenterar en sekvens med siffror |
| whoami | **whoami** =&gt; den användare som är inloggad | Vilken användare du kör som just nu, kan vara användbart om du byter sessioner eller går in i root i de fall su används istället för sudo |
| users | **users** =&gt; Listar alla användare som är inloggade nu    | Listar alla användare som är inloggade just nu |
| who | **who** =&gt; Listar alla användare och vart de är inloggade - **a** =&gt; Visa mer information per användare <br> **-H** =&gt; Visar en beskrivning per kolumn för att förstå vad som returneras | Listar alla användare som är inloggade just nu samt vilka consol sessioner de är kopplade mot |
| whereis | **whereis nano** =&gt; Listar vart editorn nano är installerad   | Ta reda på vart ett program är installerat |
| cat | **cat fil** =&gt; Visar innehållet i en fil på skärmen  <br> **-n** =&gt; Visar radnummer per rad  **Jag ser inga mer växlar som intressanta, för mig är hela cat fil1 fil2 =&gt; fil3 en av de stora grejerna med cat** | Lista filinnehållet på skärmen, bra för att förhandsgranska filer eller för att konkatenera filer. |
| tee | **tee fil** =&gt; Allt som skrivs till filen skrivs också ut på skärmen  **ls | tee fil** =&gt; kommer att spara ner en listning av filer i filen fil men också skriva ut den på skärmen. <br> **-a** =&gt; Lägg till istället för att skriva över filen  | Tee gör det möjligt att alltid styra en kopia av strömmen till skärmen. Används ofta ihop med andra kommandon. |
| more | **more fil** =&gt; Presenterar innehållet där det är möjligt att strömma det sida för sida | Strömma filinnehåll |
| less | **less fil** =&gt; Presenter en ström från fil. -N visa rader i filen-G gå till rad/ sökan =&gt; gå framåtN =&gt; gå bakåt | En utökad version av more, samma grundidé fast mer möjligheter. |
| uniq | **uniq fil** =&gt; Visa alla rader en gång  <br> **-c** =&gt; Skriv ut alla gånger som raden finns i filen <br> **-d** =&gt; Visa bara rader som finns flera gånger | Listar rader som finns flera gånger i en fil bara en gång |
| tail | **tail logfil** =&gt; Visar sista 10 raderna ur filen logfil.  <br> **-n** =&gt; Anger hur många rader från slutet man vill se <br> **-f** =&gt; stängs inte när den nått slutet, fyller på när ny data skrivs till filen. Typiskt bra när man ska följa loggning som ett system utför. | Se slutet på en fil, mest användbart för loggar |
| echo | **echo Hello** =&gt; Skriver ut texten Hello på skärmen  <br> **-n** =&gt; Skippar radbrytning eller ersätter den med något annat som man specificerar | Utskrift på skärmen, bra när man skriver bash skript och vill kunna följa vad skriptet gör eller fråga efter user input. |
| which | **which nano** =&gt; Var Nano är installerad -a =&gt; Listar alla träffar | Which fungerar på samma sätt som WhereIs men med skillnaden att which bara söker efter exekverbara filer eller länkar till dessa |
| wget | **wget** [**https://testdata/test.xml**](https://testdata/test.xml) =&gt; laddar ner test.xml lokalt  <br> **-0** =&gt; Specificera filnamnet som filen ska få lokalt <br> **-c**  =&gt; Resumea nedladdningen av en fil som avbrytits <br> **-b** =&gt; köra nedladdningen i bakgrunden  | Ladda ner http(s) källor, typiskt bra för att ladda ner filer från webben |
| cut | **cut –d : -f 1,20 myFile** =&gt; Läser ut och delar upp en fil utifrån fältlängden -f och avgränsaren –d. | Kan processa och formatera filer eller strömmar som är väl formaterade |
| **grep** | **grep LXDE minFil** =&gt; Returnerar alla träffar på LXDE in minFil.  <br> **-c** =&gt; Visar antalet träffar summerat <br> **-n** =&gt; Vilken rad som söksträngen fick träff | Kommando för att söka i filer |
| sort | **sort minFil** =&gt; Sorterar min fil ASC - **r** =&gt; Ändra sorteringsordningen till DESC <br> **-u** =&gt; Returnerar bara samma rad en gång <br> **-f** =&gt; Bortse från om stora och små bokstäver skiljer sig | Sorterar en fil |
| wc | **wc minFil** =&gt; Returnerar antalet rader, tecken och ord  **m** =&gt; tecken **w** =&gt; ord **l** =&gt; rader | Returnerar statistik om en fil |



## 2. Del 2 - access

Root användaren har alltid access till mappar.

## 3. Del 2 – hur löstes uppgiften

```bash
ls -l

d---rwx--- 2 lime admingroup  4096 jan 19 12:38 admin
d---rwx--- 2 lime datagroup   4096 jan 19 12:38 data
d---rwx--- 2 lime marketgroup 4096 jan 19 12:37 market

```

```bash
tail /etc/group

adama:x:1001:
peterp:x:1002:
lisap:x:1003:
datagroup:x:1004:adama,peterp
admingroup:x:1005:adama,lisap
marketgroup:x:1006:peterp,lisap
```

```bash
tail /etc/passwd

adama:x:1001:1001:Adam Andersson,1,0,,0:/home/adama:/bin/bash
peterp:x:1002:1002:Peter Pettersson,,,:/home/peterp:/bin/bash
lisap:x:1003:1003:Lisa Persson,,,:/home/lisap:/bin/bash
```

## 4.	Svaren på del 3

|mount point|description|
|---|---|
|/boot|Filer för att kunna starta systemet|
|/etc|Programs konfigurationsfiler|
|/sbin| Binärer som behövs tidigt i uppstarten, samma som bin till mångt och mycket men här krävs root/super user access vilket medför att vanliga användarprogram inte kan ligga här.  |
|/bin | Binärer som behövs tidigt i uppstarten av systemet när inga andra diskar etc. är laddade|
|/usr |Lokalt installerade program/binärer|
|/var |Loggar eller andra filer som rör på sig|
|/dev |Mappade enheter, typ USB sticka eller liknande|
|/home | Hemkatalogerna ligger härunder|


## 5. Svaren på del 4

*A*

```bash
find . -maxdepth 1  -size +1M | sort
```
Find kommandot returnererar alla filer som är större än 1 Mb
Sort kommandot sorterar dessa

*B*
```bash
sort addresser | uniq -c | wc -l
```
sort lägger adressraderna I ordning
uniq tar ut alla unika poster
wc returnerar en summering på antalet rader

*C*
```bash
who | cut -d ' ' -f1 | sort | uniq
```
Who listar vilka användare som är inloggade
Cut tar ut den första kolumnen utifrån ’ ’
Sort sorterar resultatet
Uniq tar bort eventuella dubletter

*D*
```bash
seq 1 10 | tee test1 test2
```
seq genererar alla siffror mellan 1 och 10, en per rad
tee skickar vidare strömmen till filerna test1 och test2



## 6. Slutsatser Del 5

```bash
ls / > lsoutput.txt
```
Skriver till filen allt som finns i under rooten

```bash
ls / hh > lsoutput2.txt
```

Returnererar ett fel att mappen hh inte finns, då skriver den ut felet på skärmen i och med att vi inte har definierat att vi vill fånga den strömmen.
```bash
ls / > lserror.txt
```
Här lyssnar vi på strömmen för fel, dock så sker det inga fel och då skrivs inget till filen lserror.txt.
```bash
ls /hh > lserror2.txt
````

Här skrivs felet ut i lserror2.txt eftersom det uppstår ett fel och vi lyssnar på STDERROR strömmen.

STDIN =&gt; Ger inputten, den tas vanligast från tangentbordet men kan också hämtas från filer eller liknande. Kan ändras med &lt;.

STDOUT =&gt; Ger outputten, den skickas vanligen till skärmen men kan skickas till filer etc.

STDERROR =&gt; Ger felmeddelanden, skickas oftast ut från skärmen. Möjligt att ändra med 2&gt;, där kommer fel att skickas. Kan också skickas till dev/null om man inte är intresserad av att logga eller hantera felen.

Ls / &gt;&gt; lsoutput ger isteället fär &gt;(enkelt &gt;) ger att man lägger till i slutet av filen istället för att skriva över filen.
