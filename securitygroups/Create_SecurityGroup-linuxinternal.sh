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
SECURITY_GROUP_NAME="$VPCSHORTNAME-linuxinternal-net-sg"
SECURITY_GROUP_DESCRIPTION="Linux Internal Server Security Group that allows basic Service Ports from $NETWORKPREFIX"

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

aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --protocol icmp --port -1 --cidr $NETWORKPREFIX --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=22,ToPort=22,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow SSH from $NETWORKPREFIX (TCP/22)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=137,ToPort=139,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow NetBIOS Name Resolution from $NETWORKPREFIX (TCP/137-139)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=udp,FromPort=137,ToPort=139,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow NetBIOS Name Resolution from $NETWORKPREFIX (UDP/137-139)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=111,ToPort=111,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow ONC RPC Portmapper from $NETWORKPREFIX (TCP/111)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=udp,FromPort=111,ToPort=111,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow ONC RPC Portmapper from $NETWORKPREFIX (UDP/111)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=631,ToPort=631,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow CUPS from $NETWORKPREFIX (TCP/631)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=udp,FromPort=161,ToPort=161,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow SNMP from $NETWORKPREFIX (UDP/161)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=389,ToPort=389,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow LDAP from $NETWORKPREFIX (TCP/389)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=445,ToPort=445,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow Samba SMB from $NETWORKPREFIX (TCP/445)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=2049,ToPort=2049,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow NFS from $NETWORKPREFIX (TCP/2049\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=udp,FromPort=2049,ToPort=2049,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow NFS from $NETWORKPREFIX (UDP/2049\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=5900,ToPort=5900,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow VNC from $NETWORKPREFIX (TCP/5900)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=5901,ToPort=5901,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow VNC from $NETWORKPREFIX (TCP/5901)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=9090,ToPort=9090,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow Web Mgmt from $NETWORKPREFIX (TCP/9090)\"}]" --no-cli-pager

