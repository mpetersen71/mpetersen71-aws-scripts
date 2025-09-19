#!/bin/bash
#!/bin/bash
#Adjust Name

NETWORKPREFIX="10.0.0.0/8"
# Other Private Subnet Examples
# NETWORKPREFIX="172.16.0.0/12"
# NETWORKPREFIX="192.168.0.0/16"

AWSACCOUNTNAME="my-awsaccount-name"

VPCNAME="$AWSACCOUNTNAME-vpc"
VPCSHORTNAME="$AWSACCOUNTNAME-us-east-1"

# Define the security group name and description
SECURITY_GROUP_NAME="$VPCSHORTNAME-webdbserver-sg"
SECURITY_GROUP_DESCRIPTION="Web Server Security Group that allows HTTP/HTTPS and various Database access from $NETWORKPREFIX"

VPCID=$(aws ec2 describe-vpcs \
  --filters "Name=tag:Name,Values=$VPCNAME" \
  --query 'Vpcs[0].VpcId' \
  --output text
)

# Create a new security group
SECURITY_GROUP_ID=$(aws ec2 create-security-group \
  --group-name "$SECURITY_GROUP_NAME" \
  --description "$SECURITY_GROUP_DESCRIPTION" \
  --vpc-id "$VPCID" \
  --output text \
  --query 'GroupId'
)

echo "Security Group '$SECURITY_GROUP_NAME' created successfully with ID: $SECURITY_GROUP_ID"

aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=80,ToPort=80,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow HTTP from $NETWORKPREFIX (TCP/80)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=443,ToPort=443,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow HTTPS from $NETWORKPREFIX (TCP/443)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=1433,ToPort=1433,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow MS SQL from $NETWORKPREFIX (TCP/1433)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=3306,ToPort=3306,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow MariaDB-MySQL from $NETWORKPREFIX (TCP/3306)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=5432,ToPort=5432,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow PostgreSQL from $NETWORKPREFIX (TCP/5432)\"}]" --no-cli-pager

