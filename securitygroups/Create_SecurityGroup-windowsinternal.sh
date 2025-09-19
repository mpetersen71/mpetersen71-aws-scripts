#!/bin/bash
#Adjust Names

NETWORKPREFIX="10.0.0.0/8"
# Other Private Subnet Examples
# NETWORKPREFIX="172.16.0.0/12"
# NETWORKPREFIX="$NETWORKPREFIX"

AWSACCOUNTNAME="my-awsaccount-name"

VPCNAME="$AWSACCOUNTNAME-vpc"
VPCSHORTNAME="$AWSACCOUNTNAME-us-east-1"

# Define the security group name and description
SECURITY_GROUP_NAME="$VPCSHORTNAME-windowsdomain-net-sg"
SECURITY_GROUP_DESCRIPTION="Windows Server Security Group that allows Windows Domain Client and other Communication per Microsoft from $NETWORKPREFIX"

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

aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=udp,FromPort=123,ToPort=123,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow Windows Time from $NETWORKPREFIX (UDP/123)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=135,ToPort=135,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow Remote Procedure Call RPC from $NETWORKPREFIX (TCP/135)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=udp,FromPort=137,ToPort=137,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow NetBIOS Name Resolution from $NETWORKPREFIX (UDP/137)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=udp,FromPort=138,ToPort=138,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow NetBIOS Datagram Service from $NETWORKPREFIX (UDP/138)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=139,ToPort=139,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow NetBIOS Session Service from $NETWORKPREFIX (TCP/139)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=udp,FromPort=161,ToPort=161,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow SNMP from $NETWORKPREFIX (UDP/161)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=445,ToPort=445,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow SMB from $NETWORKPREFIX (TCP/445)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=593,ToPort=593,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow RPC over HTTPS from $NETWORKPREFIX (TCP/593)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=1801,ToPort=1801,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow MSMQ from $NETWORKPREFIX (TCP/1801\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=udp,FromPort=1801,ToPort=1801,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow MSMQ from $NETWORKPREFIX (UDP/1801\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=udp,FromPort=1900,ToPort=1900,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow SSDP from $NETWORKPREFIX (UDP/1900)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=2101,ToPort=2101,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow MSMQ-DCs from $NETWORKPREFIX (TCP/2101)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=2103,ToPort=2103,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow MSMQ-RPC from $NETWORKPREFIX (TCP/2103)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=2105,ToPort=2105,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow MSMQ-RPC from $NETWORKPREFIX (TCP/2105)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=2107,ToPort=2107,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow MSMQ-Mgmt from $NETWORKPREFIX (TCP/2107)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=2869,ToPort=2869,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow SSDP Event Notification from $NETWORKPREFIX (TCP/2869)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=3389,ToPort=3389,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow RDP from $NETWORKPREFIX (TCP/3389)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=udp,FromPort=3389,ToPort=3389,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow RDP from $NETWORKPREFIX (UDP/3389)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=udp,FromPort=3527,ToPort=3527,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow MSMQ-Ping from $NETWORKPREFIX (UDP/3527)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=5000,ToPort=5000,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow SSDP Legacy Event Notification from $NETWORKPREFIX (TCP/5000)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=5985,ToPort=5985,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow WinRM 2 from $NETWORKPREFIX (TCP/5985)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=5986,ToPort=5986,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow WinRM 2 from $NETWORKPREFIX (TCP/5986)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=49152,ToPort=65535,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow Dyanmic Port Range from $NETWORKPREFIX. (TCP/49152+)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=udp,FromPort=49152,ToPort=65535,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow Dyanmic Port Range from $NETWORKPREFIX. (UDP/49152+)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=389,ToPort=389,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow LDAP from $NETWORKPREFIX (TCP/389)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=636,ToPort=636,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow LDAPS from $NETWORKPREFIX (TCP/636)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=3269,ToPort=3269,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow LDAPS from $NETWORKPREFIX (TCP/3269)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=88,ToPort=88,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow KRB5 from $NETWORKPREFIX (TCP/88)\"}]" --no-cli-pager

