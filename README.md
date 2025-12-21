# M346

Ein cloudbasierter Gesichtserkennungsservice, der auf AWS implementiert wird. Dieses Projekt demonstriert den Einsatz von AWS-Services wie Lambda und S3 zur Bereitstellung eines vollautomatischen Face Recognition Systems.

## Projektübersicht

Dieses Projekt implementiert einen skalierbaren Face Recognition Service in der AWS Cloud. Das System nutzt verschiedene AWS-Services, um Bilder hochzuladen, zu verarbeiten und Gesichter zu erkennen.

### Hauptfunktionen

- **Automatische Gesichtserkennung**: Erkennung von Gesichtern in hochgeladenen Bildern
- **Serverless Architektur**: Nutzung von AWS Lambda für ereignisgesteuerte Verarbeitung
- **Skalierbarkeit**: Automatische Skalierung basierend auf der Last
- **Cloud-Storage**: Sichere Speicherung von Bildern in AWS S3

## Architektur

Das System basiert auf einer Serverless-Architektur und nutzt folgende AWS-Services:

- **AWS Lambda**: Ausführung der Face Recognition Logik
- **AWS Rekognition**: KI-gestützter Service für Gesichtserkennung
- **AWS S3**: Speicherung der hochgeladenen Bilder
- **IAM**: Zugriffsverwaltung und Berechtigungen

## Schnellstart

### Voraussetzungen

- AWS-Account mit entsprechenden Berechtigungen
- AWS CLI installiert und konfiguriert
- Python 3.9 oder höher
- Bash-Shell (für init.sh Script)

### Installation

1. Repository klonen:
```bash
git clone https://github.com/Kurosbani/M346.git
cd M346
```

2. AWS-Infrastruktur initialisieren:
```bash
chmod +x init.sh
./init.sh
```

3. Lambda-Funktion deployen:
```bash
aws lambda create-function \
  --function-name FaceRecognitionFunction \
  --runtime python3.9 \
  --zip-file fileb://function.zip \
  --handler function.lambda_handler \
  --role arn:aws:iam::YOUR_ACCOUNT_ID:role/LambdaExecutionRole
```

### Erste Schritte

Nach der Installation können Sie ein Test-Bild hochladen:

```bash
python imgtest.py
```

## Dokumentation

Für detaillierte Informationen zu einzelnen Komponenten siehe:

- **[Architektur-Details](docs/ARCHITECTURE.md)**: Ausführliche Beschreibung der Systemarchitektur
- **[Deployment-Guide](docs/DEPLOYMENT.md)**: Schritt-für-Schritt Anleitung zum Deployment
- **[API-Dokumentation](docs/API.md)**: Lambda-Funktion und API-Endpoints
- **[Troubleshooting](docs/TROUBLESHOOTING.md)**: Häufige Probleme und Lösungen

## Konfiguration

### Umgebungsvariablen

Die Lambda-Funktion benötigt folgende Umgebungsvariablen:

```bash
BUCKET_NAME=your-s3-bucket-name
REKOGNITION_COLLECTION=face-collection
AWS_REGION=eu-central-1
```

### IAM-Berechtigungen

Die Lambda-Funktion benötigt folgende IAM-Policies:
- S3 Read/Write Zugriff
- Rekognition Service Zugriff
- CloudWatch Logs Zugriff

## Testen

Führen Sie die Tests mit dem bereitgestellten Script aus:

```bash
python imgtest.py
```

## Kosten

Geschätzte monatliche Kosten für typische Nutzung:
- AWS Lambda: ~$0.20 (erste 1M Anfragen kostenlos)
- AWS Rekognition: ~$1-5 je nach Bildanzahl
- S3 Storage: ~$0.023 pro GB
- Datenübertragung: Variabel

## Beitragen

Contributions sind willkommen! Bitte erstelle einen Pull Request oder öffne ein Issue.

## Lizenz

Dieses Projekt ist für Bildungszwecke im Rahmen des Moduls M346 erstellt worden.

## Autoren

- [Kurosbani](https://github.com/Kurosbani)

## Weiterführende Links

- [AWS Lambda Dokumentation](https://docs.aws.amazon.com/lambda/)
- [AWS Rekognition Dokumentation](https://docs.aws.amazon.com/rekognition/)
- [AWS Best Practices](https://aws.amazon.com/architecture/well-architected/)
