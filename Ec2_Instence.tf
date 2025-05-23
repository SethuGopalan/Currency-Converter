# Specify the provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.76.1"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.6"
    }
  }
}
# Configure the AWS Provider
provider "aws" {
  profile = "terraform"
  region  = "us-east-1"


}
# Import IAM Instance Profile from the IAM Script
# data "aws_iam_instance_profile" "ec2_instance_profile" {
#   name = "ec2-instance-profile" 
# }

# Create a Security Group for EC2
resource "aws_security_group" "ec2_security_group" {
  name        = "ec2-security-group"
  description = "Allow SSH and HTTP traffic"

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create an EC2 Instance
resource "aws_instance" "web_server" {
  ami           = "ami-0c02fb55956c7d316" 
  instance_type = "t2.micro"
  key_name      = "Dev-Ops" 
  security_groups = [
    aws_security_group.ec2_security_group.name
  ]

  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name

  tags = {
    Name = "Terraform-EC2"
  }
}
