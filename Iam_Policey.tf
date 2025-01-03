# Specify the provider
# provider "aws" {
#   region = "us-east-1" # Change to your preferred region
# }

# Create an IAM Role
resource "aws_iam_role" "ec2_role" {
  name = "ec2-instance-role"
  assume_role_policy = jsonencode({
    Version : "2012-10-17",
    Statement : [{
      Effect : "Allow",
      Principal : {
        Service : "ec2.amazonaws.com"
      },
      Action : "sts:AssumeRole"
    }]
  })
}

# Create an IAM Policy
resource "aws_iam_policy" "ec2_policy" {
  name = "ec2-policy"
  policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Effect : "Allow",
        Action : [
          "s3:*",
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource : "*"
      }
    ]
  })
}

resource "aws_iam_policy" "ec2_acces_policy" {
  name = "ec2-acces-policy"
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "ec2:RunInstances",
            "ec2:DescribeInstances",
            "ec2:CreateTags",
            "iam:PassRole"
          ],
          "Resource" : "*"
        }
      ]
  })


}

# Attach the IAM Policy to the Role
resource "aws_iam_role_policy_attachment" "ec2_policy_attach" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.ec2_policy.arn
}
resource "aws_iam_role_policy_attachment" "ec2_acces_policy_attach" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.ec2_acces_policy.arn

}

# Create an IAM Instance Profile
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2-instance-profile"
  role = aws_iam_role.ec2_role.name
}
