# Specify the provider


# Import IAM Instance Profile from the IAM Script
# data "aws_iam_instance_profile" "ec2_instance_profile" {
#   name = "ec2-instance-profile" # This must match the IAM profile name in iam.tf
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
  ami           = "ami-0c02fb55956c7d316" # Replace with your preferred AMI ID
  instance_type = "t2.micro"
  key_name      = "Dev-Ops" # Replace with your key pair name
  security_groups = [
    aws_security_group.ec2_security_group.name
  ]

  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name

  tags = {
    Name = "Terraform-EC2"
  }
}
