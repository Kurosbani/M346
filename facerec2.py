import boto3
import json

def lambda_handler(event, context):
    # Extract bucket and photo from S3 trigger event
    bucket = event['Records'][0]['s3']['bucket']['name']
    photo = event['Records'][0]['s3']['object']['key']
    
    # Output bucket (different from input)
    output_bucket = 'your-output-bucket-name'
    
    client = boto3.client('rekognition')
    s3 = boto3.client('s3')
    
    response = client.recognize_celebrities(
        Image={
            'S3Object': {
                'Bucket': bucket,
                'Name': photo
            }
        }
    )
    
    # Build results object
    results = {
        'source_image': photo,
        'celebrity_count': len(response['CelebrityFaces']),
        'celebrities': []
    }
    
    for celebrity in response['CelebrityFaces']:
        results['celebrities'].append({
            'Name': celebrity['Name'],
            'Id': celebrity['Id'],
            'KnownGender': celebrity['KnownGender']['Type'],
            'Confidence': celebrity['MatchConfidence'],
            'Urls': celebrity['Urls']
        })
    
    # Create output filename (e.g., image.jpg → image.json)
    output_key = photo.rsplit('.', 1)[0] + '.json'
    
    # Save to output bucket
    s3.put_object(
        Bucket=output_bucket,
        Key=output_key,
        Body=json.dumps(results, indent=2),
        ContentType='application/json'
    )
    
    print(f"Results saved to s3://{output_bucket}/{output_key}")
    
    return {
        'statusCode': 200,
        'output_location': f"s3://{output_bucket}/{output_key}"
    }
