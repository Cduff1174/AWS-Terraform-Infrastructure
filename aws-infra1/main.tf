provider "aws" {
    region = var.aws_region
}

module "vpc" {
    source = "./vpc"
}

module "ec2" {
    source = "./ec2"
}

module "elb" {
    source = "./elb"
}

module "rds" {
    source = "./rds"
}

module "s3" {
    source = "./s3"
}

module "sso" {
    source = "./sso"
}