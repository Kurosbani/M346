#!/bin/bash

# Setting
set -euo pipefail
REGION=$(aws configure get region)
USER=$(aws sts get-caller-identity --query Account --output text)
echo "AWS Region: $REGION"
echo "AWS Account: $USER"
echo

# Environment
LAMBDA_ROLE="${LAMBDA_ROLE:-LabRole}"
ARN_ROLE=$(aws iam get-role --role-name "$LAMBDA_ROLE" --query 'Role.Arn' --output text)
FUNCTION="${FUNCTION:-RecognizingCelebritiesM346}"
LAMBDA_FILE="function.py"

LAMBDA_ZIP="function.zip"
LAMBDA_HANDLER="function.lambda_handler"

# Variables
USER_NAME="${USER_NAME:-$(whoami)}"
IN_BUCKET="${IN_BUCKET:-celebrecognizer-in-bucket-$USER_NAME}"
OUT_BUCKET="${OUT_BUCKET:-celebrecognizer-out-bucket-$USER_NAME}"
IMAGE="${IMAGE:-image.jpg}"

echo "DELETING PRE-EXISTING BUCKETS"
# Remove IN-BUCKET
aws s3 rm "s3://$IN_BUCKET" --recursive || true
aws s3 rb "s3://$IN_BUCKET" --force || true

# Remove OUT-BUCKEt
aws s3 rm "s3://$OUT_BUCKET" --recursive || true
aws s3 rb "s3://$OUT_BUCKET" --force || true
echo

echo "CREATING IN AND OUT BUCKET"
aws s3 mb s3://$IN_BUCKET
aws s3 mb s3://$OUT_BUCKET 
echo

echo "DEPLOYING LAMBDA"
rm -f "$LAMBDA_ZIP"
zip "$LAMBDA_ZIP" function.py

echo "REMOVING ANY EXISTING LAMBDA"
aws lambda delete-function --function-name "$FUNCTION" --region "$REGION" || true

echo "CREATING NEW LAMBDA FUNCTION"
aws lambda create-function --function-name "$FUNCTION" --runtime python3.14 --role "$ARN_ROLE" --handler "$LAMBDA_HANDLER" --zip-file "fileb://$LAMBDA_ZIP" --timeout 15 --memory-size 128 --environment "Variables={OUT_BUCKET=$OUT_BUCKET}" --region "$REGION"

echo

echo "ADDING S3 TRIGGER"
aws lambda add-permission --function-name "$FUNCTION" --statement-id s3invoke --action "lambda:InvokeFunction" --principal s3.amazonaws.com --source-arn "arn:aws:s3:::$IN_BUCKET" --region "$REGION" || true
echo

echo "ADDING S3 EVENT NOTIFICATION"
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

aws s3api put-bucket-notification-configuration --bucket "$IN_BUCKET" --notification-configuration file://s3-notification.json
echo

echo "UPLOADING YOUR IMAGE INTO THE IN-BUCKET"
aws s3 cp "$IMAGE" "s3://$IN_BUCKET/$IMAGE"