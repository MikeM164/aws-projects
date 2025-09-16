import json
import boto3

region = 'us-east-1'
ec2 = boto3.client('ec2', region_name=region)

def lambda_handler(event, context):
    instances = ec2.describe_instances(
    Filters = [
        {
            'Name': 'tag:Name',
            'Values': ['dev-instance'] 
        }
    ]

    )

    for reservation in instances['Reservations']:
        for instance in reservation['Instances']:
            instance_id = instance['InstanceId']
            print(f"Starting instance {instance_id}")
            ec2.start_instances(InstanceIds=[instance_id])
            print(f"Instance {instance_id} started")
