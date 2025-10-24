#!/bin/bash
# List of commands to add various ports/protocols to an existing Security Group
# Formatted so the rules can be ran to add additional rules when using the Security Group Creation Scripts

NETWORKPREFIX="10.0.0.0/8"
# Other Private Subnet Examples
# NETWORKPREFIX="172.16.0.0/12"
# NETWORKPREFIX="192.168.0.0/16"

# May need to specify Region now (which is unnecessary if providing Security Group ID), SMTP has example, may update all in the near future if needed
REGION="us-east-1"

# Identify the Security Group ID to where you want to add these rules
SECURITY_GROUP_ID="put_in_id"

# Do NOT run the entire list, only run the ones you need to add to a Security Group, this is updated as I deploy apps to AWS

### Domain Controller / DNS / LDAP Server ###
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=53,ToPort=53,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow DNS from $NETWORKPREFIX (TCP/53)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=udp,FromPort=53,ToPort=53,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow DNS from $NETWORKPREFIX (UDP/53)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=88,ToPort=88,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow KRB5 from $NETWORKPREFIX (TCP/88)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=389,ToPort=389,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow LDAP from $NETWORKPREFIX (TCP/389)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=636,ToPort=636,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow LDAPS from $NETWORKPREFIX (TCP/636)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=3269,ToPort=3269,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow LDAPS from $NETWORKPREFIX (TCP/3269)\"}]" --no-cli-pager

### IBM Datacap ###
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=2402,ToPort=2402,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow port 2402 from $NETWORKPREFIX (TCP)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=2809,ToPort=2810,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow port 2809-2810 from $NETWORKPREFIX (TCP)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=9060,ToPort=9061,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow port 9060-9061 from $NETWORKPREFIX (TCP)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=9043,ToPort=9045,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow port 9043-9045 from $NETWORKPREFIX (TCP)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=9080,ToPort=9083,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow port 9080-9083 from $NETWORKPREFIX (TCP)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=8880,ToPort=8882,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow port 9080-9083 from $NETWORKPREFIX (TCP)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=9044,ToPort=9044,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow port 9044 from $NETWORKPREFIX (TCP)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=9443,ToPort=9444,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow port 9443-9444 from $NETWORKPREFIX (TCP)\"}]" --no-cli-pager

### Nessus ###
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=8000,ToPort=8000,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow 8000-HTTPS from $NETWORKPREFIX (TCP/8000)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=8834,ToPort=8834,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow 8834 from $NETWORKPREFIX (TCP/8000)\"}]" --no-cli-pager

### SMTP Relay Server ###
aws ec2 authorize-security-group-ingress --region $REGION --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=25,ToPort=25,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow SMTP from $NETWORKPREFIX (TCP/25)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --region $REGION --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=587,ToPort=587,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow SMTP from $NETWORKPREFIX (TCP/587)\"}]" --no-cli-pager

### Solarwinds ARM ###
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=2002,ToPort=2002,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow FSLogga from $NETWORKPREFIX (TCP/2002)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=udp,FromPort=541,ToPort=541,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow SNMP Trap from $NETWORKPREFIX (UDP/541)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=15671,ToPort=15671,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow RabbitMQ from $NETWORKPREFIX (TCP/15671)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=5985,ToPort=5986,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow WinRM from $NETWORKPREFIX (TCP/5985-6)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=55555,ToPort=55555,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow ARM from $NETWORKPREFIX (TCP/55555)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=55580,ToPort=55580,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow ARM from $NETWORKPREFIX (TCP/55580)\"}]" --no-cli-pager

### Solarwinds Orion (Also add web/sql if needed) ###
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=udp,FromPort=162,ToPort=162,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow SNMP Trap from $NETWORKPREFIX (UDP/162)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=udp,FromPort=514,ToPort=514,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow Syslog from $NETWORKPREFIX (UDP/514)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=4369,ToPort=4369,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow RabbitMQ from $NETWORKPREFIX (TCP/4369)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=5671,ToPort=5671,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow RabbitMQ from $NETWORKPREFIX (TCP/5671)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=17732,ToPort=17733,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow SW Service from $NETWORKPREFIX (TCP/17732-17733)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=17774,ToPort=17774,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow SW Service from $NETWORKPREFIX (TCP/17774)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=17777,ToPort=17778,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow SW Service from $NETWORKPREFIX (TCP/17777-17778)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=25672,ToPort=25672,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow RabbitMQ from $NETWORKPREFIX (TCP/25672)\"}]" --no-cli-pager

### Unifi Management App ###
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=6789,ToPort=6789,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow 6789 from $NETWORKPREFIX (TCP/6789)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=8080,ToPort=8080,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow 8080-HTTP from $NETWORKPREFIX (TCP/8080)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=8443,ToPort=8443,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow 8443 from $NETWORKPREFIX (TCP/8443)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=8880,ToPort=8880,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow 8880 from $NETWORKPREFIX (TCP/8880)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=27117,ToPort=27117,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow 27117 from $NETWORKPREFIX (TCP/27117)\"}]" --no-cli-pager


##### Reference from other Security Group Scripts #####

# From Linux Internal Security Group
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

# From Web / SQL Security Group
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=80,ToPort=80,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow HTTP from $NETWORKPREFIX (TCP/80)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=443,ToPort=443,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow HTTPS from $NETWORKPREFIX (TCP/443)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=1433,ToPort=1433,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow MS SQL from $NETWORKPREFIX (TCP/1433)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=3306,ToPort=3306,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow MariaDB-MySQL from $NETWORKPREFIX (TCP/3306)\"}]" --no-cli-pager
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --ip-permissions "IpProtocol=tcp,FromPort=5432,ToPort=5432,IpRanges=[{CidrIp=$NETWORKPREFIX,Description=\"Allow PostgreSQL from $NETWORKPREFIX (TCP/5432)\"}]" --no-cli-pager

# From Windows Domain/Internal Security Group
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

