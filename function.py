#Autor: Benjamin Dedic
#Datum: 21/12/2025

#Als vorlage wurde der Beispielscode von AWS genommen:
#https://docs.aws.amazon.com/de_de/rekognition/latest/dg/celebrities-procedure-image.html

import boto3
import json
import os

def lambda_handler(event, context):
    # Extrahiert Bucket- und Foto Name vom S3 trigger event
    bucket = event['Records'][0]['s3']['bucket']['name']
    photo = event['Records'][0]['s3']['object']['key']
    
    # Output bucket (MIT UMGEBUNGSVARIABLEN GESETZT)
    output_bucket = os.environ['OUT_BUCKET']
    
    # Erstellt Clients für Bilderkennung und Dateispeicherung
    client = boto3.client('rekognition')
    s3 = boto3.client('s3')
    
    # Ruft die API auf um Celebrities im Bild zu erkennen
    response = client.recognize_celebrities(
        Image={
            'S3Object': {
                'Bucket': bucket,
                'Name': photo
            }
        }
    )
    
    # Erstellt resultst Liste
    results = {
        'source_image': photo,
        'celebrity_count': len(response['CelebrityFaces']),
        'celebrities': []
    }
    
    # Durchläuft alle erkannten Celebrities und speichert sie in der results Liste
    for celebrity in response['CelebrityFaces']:
        results['celebrities'].append({
            'Name': celebrity['Name'],
            'Id': celebrity['Id'],
            'KnownGender': celebrity['KnownGender']['Type'],
            'Confidence': celebrity['MatchConfidence'],
            'Urls': celebrity['Urls']
        })
    
    # Erstellt den Namen der JSON aus dem Namen des Bildes 
    # (image.jpg → image.json)
    output_key = photo.rsplit('.', 1)[0] + '.json'
    
    # Speichert ergebnisse als JSON im output Bucket
    s3.put_object(
        Bucket=output_bucket,
        Key=output_key,
        Body=json.dumps(results, indent=2),
        ContentType='application/json'
    )
    
    # Bestätigung in cloudwatch
    print(f"Results saved to s3://{output_bucket}/{output_key}")
    
    # Gibt bei erfolg positiven status code und speicherort
    return {
        'statusCode': 200,
        'output_location': f"s3://{output_bucket}/{output_key}"
    }
