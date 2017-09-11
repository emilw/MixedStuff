# Övning 3

## 1. CVS

### 1.1 Skapa nytt repository
```bash
#Skapa central plats för alla CVS repositories
cd /home/lime/Publikt
mkdir cvsroot

#Initierar cvs att peka dit
cvs -d /home/lime/Publikt/cvsroot init

#Initiera så att alla vet var CVS rooten ligger
CVSROOT=/home/lime/Publikt/cvsroot
export CVSROOT
```
### 1.2 Skapa katalog med filer
```bash
#Skapa huvud mapp och filer
mkdir CVSFolder
cd CVSFolder
echo Test content > MainSource.txt
echo Test content 2 > SecondSource.txt
```
### 1.3 Koppla filerna och katalogerna till CVS
```bash
#Koppla alla filer till CVS
cvs import CVSFolder TEST start
N CVSFolder/SecondSource.txt
N CVSFolder/MainSource.txt
```
### 1.4 Ändra filer
```bash
#Koppla alla filer till CVS
cvs checkout CVSFolder
cd CVSFolder
echo Adding one line >> MainSource.txt
#Check status
cvs status
cvs status: Examining .
===================================================================
File: MainSource.txt   	Status: Locally Modified

   Working revision:	1.1.1.1	2017-01-20 10:11:00 +0100
   Repository revision:	1.1.1.1	/home/lime/Publikt/cvsroot/CVSFolder/MainSource.txt,v
   Commit Identifier:	1005881D3F842C82B25
   Sticky Tag:		(none)
   Sticky Date:		(none)
   Sticky Options:	(none)

===================================================================
File: SecondSource.txt 	Status: Up-to-date

   Working revision:	1.1.1.1	2017-01-20 10:11:00 +0100
   Repository revision:	1.1.1.1	/home/lime/Publikt/cvsroot/CVSFolder/SecondSource.txt,v
   Commit Identifier:	1005881D3F842C82B25
   Sticky Tag:		(none)
   Sticky Date:		(none)
   Sticky Options:	(none)

```
### 1.5 Se ändringar lokalt jämfört med CVS repositoryt
```bash
cvs diff
cvs diff: Diffing .
Index: MainSource.txt
===================================================================
RCS file: /home/lime/Publikt/cvsroot/CVSFolder/MainSource.txt,v
retrieving revision 1.1.1.1
diff -r1.1.1.1 MainSource.txt
1a2
> Adding one line
```
### 1.6 Uppdatera ändringarna i CVS repositoryt
```bash
#Skicka ändringarna till repositoryt
cvs commit
/home/lime/Publikt/cvsroot/CVSFolder/MainSource.txt,v  <--  MainSource.txt
new revision: 1.2; previous revision: 1.1

#Se så alla ändringar är med
cvs diff
Diffing .
cvs status
===================================================================
File: MainSource.txt   	Status: Up-to-date

   Working revision:	1.2	2017-01-20 10:26:51 +0100
   Repository revision:	1.2	/home/lime/Publikt/cvsroot/CVSFolder/MainSource.txt,v
   Commit Identifier:	1005881D90445237DA9
   Sticky Tag:		(none)
   Sticky Date:		(none)
   Sticky Options:	(none)

===================================================================
File: SecondSource.txt 	Status: Up-to-date

   Working revision:	1.1.1.1	2017-01-20 10:11:00 +0100
   Repository revision:	1.1.1.1	/home/lime/Publikt/cvsroot/CVSFolder/SecondSource.txt,v
   Commit Identifier:	1005881D3F842C82B25
   Sticky Tag:		(none)
   Sticky Date:		(none)
   Sticky Options:	(none)
```

## 2. Subversion
### Skapa lokal katalog och koppla till Subversion repository
```bash
mkdir SubVersion
cd SubVersion
#Connect the directory to subversion repository with name labb4
svn co svn://130.239.163.12/labb4 . --username labb4
```
### 2.1 Skapa katalog med mina filer
```bash
mkdir emil_westholm
echo "Hello svn world" > emil_westholm/ew.txt
#Lägg till hela mappen i svn
svn add emil_westholm
A         emil_westholm
A         emil_westholm/ew.txt
#Skicka ändringarna till centrala repositoryt
svn commit
Lägger till         emil_westholm
Lägger till         emil_westholm/ew.txt
Skickar filinnehåll .done
Committing transaction...
Arkiverade revision 2483.
```

### 2.2 Ändra i befintlig fil
```bash
#Lägg till mitt namn i slutet av filen
echo Emil Westholm >> users

#Kolla så den är där
tail users
Otto Tuvesson 2016-10-25
Johan Starner 2016-10-31
Ragnar Hedenskog 2016-11-02
Simon Holmberg 2016-11-05
Måns Breitholtz 2016-11-06
Thomas Larsson @ 2016-11-17
Jonas Flygare 2017-01-12
Daniel Hammarberg 2017-01-15
Josef Andersson was here 2017-01-17
Emil Westholm

#Skicka ändringen centralt
svn commit
Skickar             users
Skickar filinnehåll .done
Committing transaction...
Arkiverade revision 2484.
```
### 2.3 Kommandon
```bash
#Se historik för filen users
svn log users | less

#Se information on fil eller mapp
svn info

#Lägga till ändring och trycka den centralt
svn commit

#Se vilka ändringar som skett lokalt
echo Wrong name >> users
svn diff
Index: users
===================================================================
--- users	(revision 2484)
+++ users	(arbetskopia)
@@ -380,3 +380,4 @@
 Daniel Hammarberg 2017-01-15
 Josef Andersson was here 2017-01-17
 Emil Westholm
+Wrong Name

#Se filer som är ändrade
svn status
M       users

#Återställa users filen
svn revert users
#Dra ner det senaste från centralt repository
svn update
```

## 2.4 Skapa ny lokal mapp mot samma repository
```bash
mkdir SubVersion2
cd SubVersion2
svn co svn://130.239.163.12/labb4 . --username labb4
```

## 2.5 Diffar och hantering av dessa
```bash
#Ändra samma rad och lade till en rad i Subversion och Subversion2
nano ew.txt

#Committar i Subversion
svn commit -m "Updated ew.txt"
Skickar             ew.txt
Skickar filinnehåll .done
Committing transaction...
Arkiverade revision 2485.

#Committar i Subversion2
svn commit -m "Updated ew.txt from second client"
Skickar             ew.txt
Skickar filinnehåll .done
Committing transaction...
svn: E160028: Arkiveringen misslyckades (mer information följer):
svn: E160028: File '/emil_westholm/ew.txt' is out of date

#Uppdaterar min lokala version med det senaste
svn update
>df #Ser skillnaden
>e #Redigera filen
>r #Markerad som löst

#Committar i Suberversion2 igen
svn commit -m "Updated ew.txt from second client"
Skickar             ew.txt
Skickar filinnehåll .done
Committing transaction...
Arkiverade revision 2486.


```