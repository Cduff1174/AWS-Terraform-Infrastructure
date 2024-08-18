provider "aws" {
    region = us-east-1
}

# VPC
resource "aws_vpc" "main"{
    cidr_block = "10.0.1.0/16"
    enable_dns_support = true
    enable_dns_hostnames = true

    tags = {
        Name = "project-infra-vpc"
    }
}

# AWS Public Subnet
resource "aws_subnet" "public" {
    vpc_id = "vpc-03a13b996ff04936f"
    cidr_block = "10.0.0.0/20"
    availability_zone = us-east-1a
    map_public_ip_on_launch = true

    tags = {
        Name = "project-public-subnet"
    }
}

# Private Subnet
resource "aws_subnet" "private" {
    vpc_id = "vpc-03a13b996ff04936f"
    cidr_block = "10.0.144.0/20"
    availability_zone = us-east-1a

    tags = {
        Name = "project-private-subnet"
    }
}

# Internet Gateway
resource "aws_internet_gateway" "gw" {
    vpc_id = "vpc-03a13b996ff04936f"
    tags = {
        Name = "project-igw"
    }
}

# Route_Table
resource "aws_route_table" "public" {
    vpc_id = "vpc-03a13b996ff04936f"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = igw-0e679d58477a54b87
    }
    tags = {
        Name = "project-igw"
    }
}

# AWS Route Association Public
resource "aws_route_table_association" "public_assoc" {
    subnet_id = subnet-0b4301cd4b489b480
    route_table_id = rtb-0044756df8a19323a
}

# Security Group
resource "aws_security_group" "main_sg"{
    vpc_id = aws_vpc.main.id

    ingress {
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
        Name = "main-security-group-infra1"
    }
}