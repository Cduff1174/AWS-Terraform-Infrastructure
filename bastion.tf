# Bastion Host
resource "aws_instance" "bastion" {
    ami = "ami-0ae8f15ae66fe8cda"
    instance_type = "t2.micro"
    subnet_id = "subnet-0b4301cd4b489b480"
    associate_public_ip_address = true
    key_name = "bastioninfra1"

    tags = {
        Name = "BastionHost"
    }

    vpc_security_group_ids = [
        aws_security_group.bastion_sg.id,
    ]
}

# Define Outputs
output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}

output "bastion_id" {
  value = aws_instance.bastion.id
}