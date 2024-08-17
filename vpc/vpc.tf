provider "aws" {
    region = us-east-1
}

# VPC
resource "aws_vpc" "main"{
    cidr_block = 10.0.1.0/24
    enable_dns_support = true
    enable_dns_hostnames = true

    tags = {
        Name = "aws-infra-vpc"
    }
}

# AWS Public Subnet
resource "aws_subnet" "public" {
    vpc_id = aws_vpc.main.id
    cidr_block = 172.3.1.0.0/20
    availability_zone = us-east-1e
    map_public_ip_on_launch = true

    tags = {
        Name = "public-subnet"
    }
}

# Private Subnet
resource "aws_subnet" "private" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.private_subnet_cidr
    availability_zone - var.availability_zone

    tags = {
        Name = "private-subnet"
    }
}

# Internet Gateway
resource "aws_internet_gateway" "gw" {
    vpc_id = aws_vpc.main.id
    tags = {
        Name = "aws-infra1-igw"
    }
}

# Route_Table
resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = igw-0d17df51d8073c631
    }
    tags = {
        Name = "aws-infra1-route-table"
    }
}

# AWS Route Association Public
resource "aws_route_table_association" "public_assoc" {
    subnet_id = subnet-0e26a3ccb9cba3231
    route_table_id = rtb-0d2a4ff3b84615cfa
}

# Security Group
resource "aws_security_group" "main_sg"{
    vpc_id = aws_vpc.main.id

    ingresss {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress{
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks =["0.0.0.0/0"]
    }

    tags = {
        Name = "main-security-group"
    }
}