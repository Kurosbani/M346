#!/bin/bash

# User definieren
set -euo pipefail
REGION=$(aws configure get region)
USER=$(aws sts get-caller-identity --query Account --output text)
echo "AWS Region: $REGION"
echo "AWS Account: $USER"


# Lambda/Function konfiguration
LAMBDA_ROLE="${LAMBDA_ROLE:-LabRole}"
ARN_ROLE=$(aws iam get-role --role-name "$LAMBDA_ROLE" --query 'Role.Arn' --output text)
FUNCTION="${FUNCTION:-RecognizingCelebritiesM346}"
LAMBDA_FILE="function.py"
LAMBDA_ZIP="function.zip"
LAMBDA_HANDLER="function.lambda_handler"
echo "Lambda role: $LAMBDA_ROLE"
echo "Lambda Function: $FUNCTION"

# Variablen
USER_NAME="${USER_NAME:-$(whoami)}"
IN_BUCKET="${IN_BUCKET:-celebrecognizer-in-bucket-$USER_NAME}"
OUT_BUCKET="${OUT_BUCKET:-celebrecognizer-out-bucket-$USER_NAME}"
IMAGE="${IMAGE:-$(ls *.jpg *.png 2>/dev/null | head -n 1 || true)}"
RESULT_FILE="${IMAGE%.*}.json"
RESULT_PATH="./$RESULT_FILE"
echo "IN Bucket: $IN_BUCKET"
echo "OUT Bucket: $OUT_BUCKET"
echo


echo "--- DELETING ANY PRE-EXISTING BUCKETS ---"
# Der IN Bucket wird ausgeleert und gelöscht
aws s3 rm "s3://$IN_BUCKET" --recursive || true
aws s3 rb "s3://$IN_BUCKET" --force || true

# Der OUT Bucket wird ausgeleert und gelöscht
aws s3 rm "s3://$OUT_BUCKET" --recursive || true
aws s3 rb "s3://$OUT_BUCKET" --force || true
echo


echo "--- CREATING IN AND OUT BUCKET ---"
# Erstellt ein neues IN und OUT Bucket
aws s3 mb s3://$IN_BUCKET
aws s3 mb s3://$OUT_BUCKET 
echo


echo "--- DEPLOYING LAMBDA ---"
# Löscht die gezippte Python Datei und Komprimiert die originale Python Datei zu ZIP
rm -f "$LAMBDA_ZIP"
zip "$LAMBDA_ZIP" function.py

echo "--- REMOVING ANY PRE-EXISTING LAMBDA ---"
# Löscht vorherige Lambda Funktion falls schon eine existiert
aws lambda delete-function --function-name "$FUNCTION" --region "$REGION" || true

echo "--- CREATING NEW LAMBDA FUNCTION ---"
# Ertellt eine neue Lambda Funktion
aws lambda create-function --function-name "$FUNCTION" --runtime python3.14 --role "$ARN_ROLE" --handler "$LAMBDA_HANDLER" --zip-file "fileb://$LAMBDA_ZIP" --timeout 15 --memory-size 128 --environment "Variables={OUT_BUCKET=$OUT_BUCKET}" --region "$REGION"
echo


echo "--- ADDING S3 TRIGGER ---"
# Erstellt den S3 Trigger
aws lambda add-permission --function-name "$FUNCTION" --statement-id s3invoke --action "lambda:InvokeFunction" --principal s3.amazonaws.com --source-arn "arn:aws:s3:::$IN_BUCKET" --region "$REGION" || true
echo


echo "--- ADDING S3 EVENT NOTIFICATION ---"
# Erstellt eine Benachrichtigung fürs S3 Trigger
cat > s3-notification.json <<EOF
{
  "LambdaFunctionConfigurations": [
    {
      "LambdaFunctionArn": "arn:aws:lambda:$REGION:$USER:function:$FUNCTION",
      "Events": ["s3:ObjectCreated:*"]
    }
  ]
}
EOF

echo "--- DOWNLOADING S3 EVENT NOTIFICATION ---"
# Ladet die Benachrichtigung im lokalen Gerät herunter
aws s3api put-bucket-notification-configuration --bucket "$IN_BUCKET" --notification-configuration file://s3-notification.json
echo


echo "--- UPLOADING YOUR IMAGE INTO THE IN-BUCKET ---"
# Ladet die vom Benutzer gegebene Datei im IN Bucket hoch
aws s3 cp "$IMAGE" "s3://$IN_BUCKET/$IMAGE"
echo


echo "--- DOWNLOADING RECOGNITION RESULTS ---"
# Wartet, bis die vom Benutzer gegebene Datei im IN Bucket vorhanden ist, nur die erste Datei wird im IN Bucket hochgeladen
until aws s3 ls "s3://$OUT_BUCKET/$RESULT_FILE" >/dev/null 2>&1; do
  sleep 2
done

# Ladet den Resultat der Gesichtserkennung im lokalen Gerät herunter
aws s3 cp "s3://$OUT_BUCKET/$RESULT_FILE" "$RESULT_PATH"
