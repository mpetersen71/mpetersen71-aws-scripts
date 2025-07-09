# mpetersen71-aws-scripts

This repository contains a collection of AWS CloudShell scripts used to automate the provisioning and configuration of AWS resources such as VPCs, EC2 instances, Security Groups, and more.

These scripts are designed to be used within the [AWS CloudShell environment](https://docs.aws.amazon.com/cloudshell/latest/userguide/) or by using the CloudShell interface within the AWS Web Console.

---

## Contents

| Folder/File                   | Description                                               |
|-------------------------------|-----------------------------------------------------------|
| `ec2/ec2-server-windows.sh`   | Deploys a Windows EC2 Instance within your VPC            |

---

## Prerequisites

- An active AWS account
- [AWS CloudShell](https://us-east-1.console.aws.amazon.com/cloudshell/)
- Proper IAM permissions to create and manage AWS resources
- Basic understanding of AWS CLI

---

## Getting Started

1. Open AWS CloudShell
2. Clone this repository:
   ```bash
   git clone https://github.com/mpetersen71/mpetersen71-aws-scripts.git
   cd mpetersen71-aws-scripts

### Disclaimer
These scripts are provided as-is for educational and personal use. Use caution when running scripts that create or delete AWS resources. Always review the code before executing.

### License
GNU GPL3 License – see the LICENSE file for details.

### Contributing
This is a personal project, but contributions or suggestions are welcome! Feel free to open an issue or submit a pull request.

