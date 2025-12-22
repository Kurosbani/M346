# M346

In diesem M346 Projekt handelt es sich um einen cloudbasierten Gesichtserkennungsservice, der auf AWS implementiert wird. Dieses Projekt benutzt den Einsatz von AWS-Services wie Lambda und S3 für einen Face Recognition System. 

## Benötigte Programme:

### 1. Ubuntu

Falls du Windows verwendest, installiere wsl mit PowerShell als Administrator:

```
wsl --install Ubuntu
```

### 2. Python

Instaliere Python mit den folgenden Link:

https://www.python.org/downloads/  

Oder direkt in der CLI:
```
sudo apt install python3
```

### 3. AWS CLI

Instaliere aws cli mit den folgenden Link:

https://awscli.amazonaws.com/AWSCLIV2.msi

Falls es nicht klappt, verwende diesen Befehl im Ubuntu:

```
sudo snap install aws-cli
```

## Ablauf der Ausführung:

### 1.  Entpacke die ZIP Datei. 
Für Windows users, entpacke sie unter deinen Ubuntu Homeverzeichnis, zb:
```
\\wsl.localhost\Ubuntu\home\benj
```

### 2. Bild im Projektordner einfügen. 
Als Beispielsdatei wurde ein Bild von Jeff Bezos als image.jpg gespeichert.
Für eigene Bilder ist der Name egal, es muss einfach in .jpg oder .png enden.

### 3. Melde dich im aws an mit diesem bash Command:
```
aws configure
```
Folge den anweisungen direkt in der CLI, du musst deinen Token eingeben welchen du auf der AWS Academy Learner Lab unter Details findest, als alternative kannst du auch deinen Token in ```~/.aws/credentials``` speichern.

### 4.  Mach init.sh ausführbar mit dem folgenden Command:
```
sudo chmod +x init.sh
```
Standarmässig kann man den Skript nicht ausführen, ohne ihm die Ausführungsrechte zu geben.

### 5. Ausführen
Der letzte schritt liegt nur noch beim ausführen, nach dem ausführen werden die ergebnisse als json im S3 out-Bucket gespeichert.
```
./init.sh
```

### Weitere Dokus
- [Reflexion](/docs/reflexion.md)
- [Skript](/docs/skript.md)
- [Tests](/docs/tests.md)