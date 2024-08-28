variable    "aws_region" {
    description = "The AWS region to deploy resources in"
    default = "us-east-1"
}

variable    "vpc_cidr" {
    description = "CIDR block for the VPC"
    default = "10.0.0.0/16"
}

variable "db_master_password" {
  description = "The master password for the database"
  type        = string
  sensitive   = true
}
