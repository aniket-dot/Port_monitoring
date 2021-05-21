def lambda_handler(event, context):
    import boto3
    #session = boto3.Session(profile_name="default", region_name='us-east-1')
    client = boto3.client('ec2')
    #Ec2_client = session.client(service_name='ec2')
    SSM_client = boto3.client('ssm', region_name='us-east-1')
    params={
                    '#commands’:[“sudo netstat  -nptl > port_test.txt”
                    'commands’:[“for i in `cat /home/aniket/test11/file1.txt | awk {'print $2'}
                                  do
x=$(ssh -o StrictHostKeyChecking=no -o  ConnectTimeout=10 aniket@i -p2222 "cat /etc/nagios/nrpe.cfg | grep -o -P ' -p [0-9]{0,4}' nrpe.txt | cut -d " " -f3")
x=$(ssh -o StrictHostKeyChecking=no -o  ConnectTimeout=10 aniket@$i -p2222 "cat netstat -nptl | grep -o -P ':[0-9]{0,4}' | cut -d ":" -f2 | sort -u")
echo "$i;;$"
echo "$i;;$"
done”
   
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
