def lambda_handler(event, context):
    import boto3
    #session = boto3.Session(profile_name="default", region_name='us-east-1')
    client = boto3.client('ec2')
    #Ec2_client = session.client(service_name='ec2')
    SSM_client = boto3.client('ssm', region_name='us-east-1')
    params={
                    'commands’:[“sudo netstat  -nptl > port_test.txt”
   
                    ]
    }
    response = SSM_client.send_command(
        Targets=[
            {
                'Key': 'resource-groups:Name',
                'Values': ['SSM']
            },
        ],
        DocumentName='AWS-RunShellScript',
        DocumentVersion='$DEFAULT',
        DocumentHash=‘hash value’,
        DocumentHashType='Sha256',
        TimeoutSeconds=30,
        Parameters=params,
        ServiceRoleArn='arn:aws:iam::644273795076:role/SNS_Role',
        NotificationConfig={
            'NotificationArn': ‘need to put Arn id’,
            'NotificationEvents': [
              'Success','Failed'
            ],
            'NotificationType': 'Command', #'Invocation'
        },
        CloudWatchOutputConfig={
           # 'CloudWatchLogGroupName': 'string',
            'CloudWatchOutputEnabled': True
        }
    )
