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

echo "UPLOADING YOUR IMAGE INTO THE IN-BUCKET"
aws s3 cp "$IMAGE" "s3://$IN_BUCKET/$IMAGE"

echo "DEPLOYING LAMBDA"
rm -f "$LAMBDA_ZIP"
zip "$LAMBDA_ZIP" function.py

echo "REMOVING ANY EXISTING LAMBDA"
aws lambda delete-function --function-name "$FUNCTION" --region "$REGION" || true

ARN_ROLE=$(aws iam get-role --role-name "$LAMBDA_ROLE" --query 'Role.Arn' --output text)

echo "CREATING NEW LAMBDA FUNCTION"
aws lambda create-function --function-name "$FUNCTION" --runtime python3.14 --role "$ARN_ROLE" --handler "$LAMBDA_HANDLER" --zip-file "fileb://$LAMBDA_ZIP" --timeout 30 --memory-size 256 --environment "Variables={OUT_BUCKET=$OUT_BUCKET}" --region "$REGION"

echo