variables "aws_region" {
    description = "The AWS region to deploy resources in"
    default = "us-east-1"
}

variables "vpc_cidr" {
    description = "CIDR block for the VPC"
    default = "10.0.0.0/16"
}