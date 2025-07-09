#!/bin/bash
#
# Description: AWS Cloudshell Script to Create a Windows Server Instance with Sane Defaults
# 
# Author: Mike Petersen
# Date: 2024-06-05
# Version: 1.0
#
# Requires these existing Asset Names: region, vpc_name, key_name, secuirty_group_name, subnet_name, iam_role
# Requires these names for the new instance: instance_name, tags
# Requires these options to be specified: instance_type, windowsbase

# AWS Region
region="us-east-1"

#VPC Name
VPC_NAME="full-name-of-vpc-us-east-1-vpc"

# Server Name
instance_name="short-vpc-name-servername"

# Key Pair
key_name="keypair-name"

# Default Security Group Name to use
security_group_name="securitygroupname-us-east-1-sg"

# Subnet Name
subnet_name="subnetname-us-east-1-private-subnet-b"

# IAM Role
iam_role="iamrolename-ssm-ec2-role"

#Tags - adjust accordingly
tags=[{Key=Name,Value=$instance_name},{Key=BusinessUnit,Value=BusinessUnit},{Key=Function,Value=FunctionName},{Key=Environment,Value=Production},{Key=Application,Value=ApplicationName}]

# EC2 Instance Details
instance_type="m6i.xlarge"

# Windows Operating System Name
windowsbase="Windows_Server-2022-English-Full-Base"

# EBS Root / C Volume Details
root_volume_size=60
root_volume_type="gp3"
root_volume_throughput=125
root_volume_iops=3000

# Second EBS Volume
additional_volume_size=50
additional_volume_type="gp3"
additional_volume_throughput=125
additional_volume_iops=3000

# Protect Instance from Termination (future planned, enabled by default)
# termination_protection=true

# Create Public IP Address (future planned, disabled by default)
#create_public_ip=false

## Pull the AWS IDs from names above

# Operating System Image Product Code
# Use the latest Windows Relase provided by amazon
ami_id=$(aws ec2 describe-images \
  --region us-east-1 \
  --owners amazon \
  --filters "Name=name,Values=$windowsbase-*" \
  --query "Images | sort_by(@, &CreationDate) | [-1].ImageId" \
  --output text)

security_group_id=$(aws ec2 describe-security-groups \
  --region $region \
  --filters "Name=group-name,Values=$security_group_name" \
  --query "SecurityGroups[0].GroupId" \
  --output text)

subnet_id=$(aws ec2 describe-subnets \
  --region $region \
  --filters "Name=tag:Name,Values=$subnet_name" \
  --query "Subnets[0].SubnetId" \
  --output text)

# Launch EC2 Instance with additional volume
instance_id=$(aws ec2 run-instances \
  --region $region \
  --image-id $ami_id \
  --instance-type $instance_type \
  --key-name $key_name \
  --security-group-ids $security_group_id \
  --subnet-id $subnet_id \
  --block-device-mappings "[{\"DeviceName\":\"/dev/sda1\",\"Ebs\":{\"VolumeSize\":$root_volume_size,\"VolumeType\":\"$root_volume_type\",\"Encrypted\":true,\"Iops\":$root_volume_iops,\"Throughput\":$root_volume_throughput}},{\"DeviceName\":\"/dev/sdb\",\"Ebs\":{\"VolumeSize\":$additional_volume_size,\"VolumeType\":\"$additional_volume_type\",\"Encrypted\":true,\"Iops\":$additional_volume_iops,\"Throughput\":$additional_volume_throughput}}]" \
  --tag-specifications "ResourceType=instance,Tags=$tags" \
  --iam-instance-profile Name=$iam_role \
  --disable-api-termination \
  --output json \
  --query "Instances[0].InstanceId")


# Launch EC2 Instance without additional volume - Remove above and uncomment below
# instance_id=$(aws ec2 run-instances \
#  --region $region \
#  --image-id $ami_id \
#  --instance-type $instance_type \
#  --key-name $key_name \
#  --security-group-ids $security_group_id \
#  --subnet-id $subnet_id \
#  --block-device-mappings "[{\"DeviceName\":\"/dev/sda1\",\"Ebs\":{\"VolumeSize\":$root_volume_size,\"VolumeType\":\"$root_volume_type\",\"Encrypted\":true,\"Iops\":$root_volume_iops,\"Throughput\":$root_volume_throughput}}]" \
#  --tag-specifications "ResourceType=instance,Tags=$tags" \
#  --iam-instance-profile Name=$iam_role \
#  --disable-api-termination \
#  --output json \
#  --query "Instances[0].InstanceId")


echo "EC2 instance $instance_id is being created."


