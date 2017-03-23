Emil Westholm 820811-7153

# Övning 10

Jag ämnar bara att svara på Del 1.

## Del 1
### Hur gick arbetet?
Det började med att jag missuppfattade att det skulle göras i Bash, så jag fick börja om och göra det i Bash istället :-(. Jag skrev ett bygg skript till övning 6 som anropas av byggservern men då var det mer att paketera en massa kommandon(make) i en fil med && i mellan för att få reda på om något smällde. Det var därför kul att göra det igen i check5.sh när man lärt sig mer om hur man skriver riktiga skript i Bash.

Efter den här övningen förstår jag mer storheten med att varje kommando är så litet som möjligt och att man kan plocka ihop dem till en helhet, inte bara till en "one liner" att köra i consolen utan även som fulla script.

Har kört lite Powershell tidigare, och det är väl från Bash de har hämtat mycket. Tycker det fortfarande är svårt att hantera syntaxen då den är så skiljd från C/C++/C#/Javascript. Exempelvis:
- Otypat, är det en sträng eller en int? Tar ett tag att förstå vad som är vad.
- if och fi
- när man kan ha if eq kontra ==
- echo och return från funktioner
- konstigt att programmet "bara" startar utan Main. Blir lite röriga filer ibland kan jag tycka

Tycker det överlag gått bra, men som sagt lite ovant att skriva program/script i Bash.

### Begränsningar och förbättringar?

### timetrack.sh
- När man kör start igen på en redan pågående körning så borde man bli promptad med om man verkligen vill starta om.
- Spara 10 senaste tidtagningarna

### checkuser.sh
- Kunna skicka in roll och få träff om någon i en given roll är inloggad
- Kunna få information om när personen senast var inloggad om den inte är det

### check5.sh
- Lägga till en ```make test``` i makefilen som kör ett testprogram. Då kan man verkligen se att programmet fungerar också.
- Spara undan varje resultat i en fil, då scriptet högst troligt kommer köras från en byggserver eller liknande och man kommer vilja gå in i efterhand och leta efter eventuella problem.