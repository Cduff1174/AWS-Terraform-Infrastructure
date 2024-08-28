resource "aws_instance" "public_ec2" {
  ami           = "ami-066784287e358dad1"  # Replace with your AMI ID
  instance_type = "t2.micro"      # Replace with your desired instance type
  key_name      = "bastioninfra1"  # Replace with your key pair name

  iam_instance_profile = aws_iam_instance_profile.public_ec2_instance_profile.name
  subnet_id             = aws_subnet.public.id  # Use Terraform reference to subnet ID
  security_groups        = [aws_security_group.public_ec2_sg.id]  # Use a list for security groups

  tags = {
    Name = "PublicEC2Instance"
  }

  # Optional: Add user data script or other configurations here
}

