# Skript

## Hier ist die vollständige erklärung des Skripts und was es macht
## Funktion
Das Ziel vom Skript ist, eine Gegebene Bild Datei nehmen, und durch einer Lambda Funktion erkennen, ob es eine beliebte Person beinhaltet und welche sie ist.

Die Resultate der Gesichtserkennung werden am Lokalen Gerät als eine JSON Datei zurückgegeben.

## Ablauf
### 1. User Definieren)
<img width="778" height="160" alt="image" src="https://github.com/user-attachments/assets/5e8179e3-8007-47ac-b349-e79da3323e87" />

Dieser Abschnitt definiert den Benutzer Account, Region und schreibt sie mit echo aus.

### 2. Lambda Konfiguration)
<img width="1003" height="193" alt="image" src="https://github.com/user-attachments/assets/d1e2240c-e771-4a70-8399-8cbc246e07b0" />

Dieser Abschnitt definiert die Lambda Rolle, ARN Rolle, Namen der angewendeter Funktion, angewendeter Python Code und schreibt das Nötigste mit echo aus.

### 3. Variablen)
<img width="760" height="217" alt="image" src="https://github.com/user-attachments/assets/763eec1a-09b8-49a0-8ddb-941323b1c8e2" />

Definiert Allgemeine Variablen wie den Benutzer Namen, IN und OUT Bucket namen, welches Bild gegeben wurde, in welchen Pfad die JSON Datei zurückgegeben wird, und der Name der JSON Datei.

### 4. Buckets löschen und erstellen)
<img width="556" height="351" alt="image" src="https://github.com/user-attachments/assets/5cef554c-e678-4eac-9499-c7682be6be39" />

#### Buckets löschen
Als aller erstes müssen die IN und Out buckets geleert werden und dann vollständig gelöscht, damit es Platz für neue Buckets gibt, wenn man den Skript das aller erste mal ausführt sagt die Konsole dir bescheid dass es nichts zu löschen gibt. Alles ist okay wenn das passiert denn der Skript wird gezwungen weiter zu laufen.

#### Buckets erstellen
Ein IN und ein OUT Bucket werden erstellt.

### 5. Lambda löschen und deployen)
<img width="1645" height="128" alt="image" src="https://github.com/user-attachments/assets/822a0fcc-82f2-4e62-ba9a-515ddda67e0e" />

#### Lambda löschen)
Falls eine vorherige Lambda schon existiert, wird sie gelöscht um Platz für eine neue Lambda zu schaffen, falls keine vorhanden war wird die Konsole es dir bescheid sagen, es ist auch komplett Normal da der Skript wieder gezwungen wird, weiter zu laufen.

#### Lambda deployen)
Erstellt eine neue Lambda Funktion mit der LabRole Rolle, Python 3.14, gegebene ARN Rolle, verwendet die gegebene Python Datei als ZIP, hat eine Memory von 128 und ist mit den Buckets verknüpft.

### 6. S3 Trigger)
<img width="1818" height="77" alt="image" src="https://github.com/user-attachments/assets/e25b64f7-4cf3-49f1-8686-871a17e646e9" />

Erstellt den S3 Trigger, das erkennen kann, ob eine Datei im IN Bucket hinzugefügt wurde die nachträglich zur Funktion geleitett wird.

### 7. S3 Trigger Benachrichtigung)
<img width="1131" height="331" alt="image" src="https://github.com/user-attachments/assets/189a2443-0c51-4f82-bc8f-ae6c9f7f9816" />

Erstellt eine JSON Datei die im Lokalen PC gespeichert wird, diese JSON Datei beschreibt was der S3 Trigger macht und wo es macht.

### 8. Bild Datei hochladen)
<img width="525" height="85" alt="image" src="https://github.com/user-attachments/assets/6ca61235-d283-4d7f-baa7-80762fb9618a" />

Die Bild Datei, die vom Benutzer gegeben wurde wir im IN Bucket hochgeladen

### 9. Resultat herunterladen)
<img width="1106" height="166" alt="image" src="https://github.com/user-attachments/assets/48816f67-796b-4252-ad3c-294289f705e2" />

Als erstes wartet der Skript, bis die Bild Datei zu 100% hochgeladen wurde, dann ladet es die endgültigen Resultate von der Gesichtserkennung zum Lokalen Gerät.

### Die Notwendige Komponente um den Skript auszuführen:
- Python
- AWS Konto (getestet mit Lab Account)
- Linux betriebssystem wie Ubuntu um init.sh zu ausführen
