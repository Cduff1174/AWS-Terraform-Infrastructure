resource "aws_instance" "web" {
    ami = var.ami_id
    instance_type = var.instace_type
    subnet_id = module.vpc.public_subnet_id
    security_groups = [module.vpc.default_security_group]

    tags = {
        Name = "web-server"
    }
}