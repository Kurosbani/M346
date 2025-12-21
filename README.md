# M346

## Benötigte Programme:

1. Python

    Instaliere Python mit den folgenden Link:

    https://www.python.org/downloads/  

2. Ubuntu

    Falls du Windows verwendest, installiere wsl mit PowerShell als Administrator:

    ```
    wsl --install Ubuntu
    ```

3. AWS CLI

    Instaliere aws cli mit den folgenden Link:

    https://awscli.amazonaws.com/AWSCLIV2.msi

    Falls es nicht klappt, verwende diesen Befehl im Ubuntu:

   ```
    sudo snap install aws-cli
    ```

## Ablauf der Ausführung:

1.  Entpacke die ZIP Datei. 
Für Windows users, entpacke sie unter den Ubuntu verzeichnis.

2. Füge dein Bild im Projekt Ordner rein, der Name ist egal, es muss einfach in .jpg oder .png enden.

3. Melde dich im aws an mit diesem bash Command:
      ```
      aws configure
     ```
     Für den session Token, kopiere deine Daten im AWS academy learner lab unter aws Details und füge sie im ~/.aws/credentials ein.

4.  Mach init.sh ausführbar mit dem folgenden Command:
    ```
    sudo chmod +x init.sh
    ```