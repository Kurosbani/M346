from boto3 import client

response = client.recognize_celebrities(
    Image={
        'S3Object': {
            'Bucket': 'face-rec-in',
            'Name': 'uuis.jpg'
        }
    }
)