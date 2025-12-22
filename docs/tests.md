# Test Fälle 
## Test 1) 
### Fall: Ein Bild von einer beliebten Person wird mit dem richtigen Bildformat gegeben
Das Bild:

<img width="273" height="261" alt="mj" src="https://github.com/user-attachments/assets/795c304a-2994-4b92-85a7-1e89e118c001" />

Das ist ein PNG Bild von der berühmten Person Michael Jackson

#### Erwatetes Resultat: 
Die ausgegeben JSON Datei wird eine einzige Person als Michael Jackson erkennen

#### Wahrer Resultat:
<img width="220" height="170" alt="image" src="https://github.com/user-attachments/assets/24c43ea0-89a4-4e4a-827d-6b36588c4f99" />

Eine einzige Person wurde als Miachel Jackson erkannt

Der Test Fall ist richtig 


## Test 2) 
### Fall: Ein Bild von einer unbekannten Person wird mit dem richtigen Bildformat gegeben
Das Bild: 

<img width="868" height="372" alt="tom" src="https://github.com/user-attachments/assets/3c090011-08d5-4b9a-aea0-66dc3b6d4bdc" />

Das Bild ist ein PNG Bild von Tom, er ist nicht so berühmt um teil des Face recognitions zu sein

#### Erwatetes Resultat:
Die augegebene JSON Datei wird fast leer sein, keine Gesichter werden erkannt

#### Wahrer Resultat:
<img width="201" height="157" alt="image" src="https://github.com/user-attachments/assets/22024dc7-e2bd-4ecd-b98a-c197481b21ae" />

Tom wird als Jordan Roughead erkannt, aber nur mit einem sicherheitsgrad von 76%

Der Test Fall ist falsch, doch es kann leicht passieren, dass doch neimand erkannt wird


## Test 3) 
### Fall: Ein Bild von mehreren beliebten Personen wird mit richtigen Bildformat gegeben
Das Bild: 

<img width="441" height="265" alt="rock" src="https://github.com/user-attachments/assets/be42cb5d-e2f6-4877-be18-54a56dadc1c1" />

Das Bild ist ein PNG Bild das Dwayne Johnson und Roman Reigns beinhaltet

#### Erwatetes Resultat:
Die augegebene JSON Datei wird 2 Personen Erkennen, die Dwayne Johnson und Roman Reigns sind

#### Wahrer Resultat:
<img width="347" height="479" alt="image" src="https://github.com/user-attachments/assets/033509b5-30a4-49a3-b0c4-01aab100cb61" />

Zwei Leute wurden erkannt, Dwayne Johnson und Roman Reigns

Der Test Fall ist richtig


## Test 4) 
### Fall: Ein Bild von einer beliebten und unbekannten Personen wird mit richtigen Bildformat gegeben
Das Bild: 

<img width="712" height="428" alt="Screenshot 2025-12-22 142200" src="https://github.com/user-attachments/assets/57357aed-d42b-47f5-b92c-f01cf7197244" />

Das Bild ist ein PNG Bild das Lady Gaga und zwei unbekannte Personen beinhaltet

#### Erwatetes Resultat:
Die augegebene JSON Datei wird nur eine Person ausgeben, die Lady Gaga ist

#### Wahrer Resultat:
<img width="355" height="348" alt="image" src="https://github.com/user-attachments/assets/e142b1d2-ed32-4beb-98ab-bdc471d68885" />

Nur eine Person wurde erkannt, diese Person ist Lady Gaga

Der Test Fall ist richtig


## Test 5) 
### Fall: Ein Bild von einer Beliebten Person wird mit falschen Bildformat gegeben
Das Bild: 

![albert](https://github.com/user-attachments/assets/a9619026-93ec-4278-981c-9758abc603fe)

Das Bild ist ein GIF von Albert Einstein, unser Skript kann nur PNGs oder JPGs wahrnehmen
#### Erwatetes Resultat:
Es wird einen Error geben während der Skript läuft, also keine JSON Resultate werden zurückgegeben

#### Wahrer Resultat:

<img width="334" height="30" alt="image" src="https://github.com/user-attachments/assets/1996ff82-9fa2-416d-9134-545dd59efcef" />


Ein Error wurde gegeben als es versucht hat ein passendes Bild zu suchen

Der Test Fall ist richtig


## Test 6) 
### Fall: Keine Datei wird gegeben
Kein Bild wird gegeben dieses Mal

#### Erwatetes Resultat:
Es wird einen Error geben während der Skript läuft, also keine JSON Resultate werden zurückgegeben

#### Wahrer Resultat:
<img width="319" height="21" alt="image" src="https://github.com/user-attachments/assets/c3b891eb-17c7-43e2-b055-7e98eab934a5" />


Ein Error wurde gegeben, es konnte nichts finden und hat den Skript deshalb abgebrochen

Der Test Fall ist richtig

## Test 7) 
### Fall: Eine Datei die kein bild ist, aber mit .jpg/.png endet wird gegeben
Die Datei: 

<img width="132" height="30" alt="image" src="https://github.com/user-attachments/assets/d9c69157-c452-4ba1-a278-a49acd5ca26a" />

Die Datei ist eigentlich eine .AHK Datei, aber die wurde umbenannt um ein .PNG zu sein
#### Erwatetes Resultat:
Das Skript nimmt die Datei wahr, aber das JSON Resultat erkennt keine Gesichter und ist deshalb fast leer

#### Wahrer Resultat:

<img width="327" height="89" alt="image" src="https://github.com/user-attachments/assets/94255b83-0e36-4cbc-86d7-c85307272b94" />

Der Ablauf vom Skript ging wie es sollte, bise es verscuht hat den JSON Resultat herunterzuladen wobei es stecken geblieben ist.

Der Test Fall ist einigerweise richtig



