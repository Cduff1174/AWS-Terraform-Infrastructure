resource "aws_iam_role" "public_ec2_role" {
  name = "PublicEC2Role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "public_ec2_policy" {
  name = "S3AccessPolicy"
  role = aws_iam_role.public_ec2_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = "s3:*",
        Resource = "arn:aws:iam::381491955630:role/PublicEC2Role*"
      }
    ]
  })
}

resource "aws_iam_instance_profile" "public_ec2_instance_profile" {
  name = "PublicEC2InstanceProfile"
  role = aws_iam_role.public_ec2_role.name
}
