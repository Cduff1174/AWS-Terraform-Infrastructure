# Private Subnet 1 in AZ us-east-1a
resource "aws_subnet" "private_subnet_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.144.0/20"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "project-private-subnet-1"
  }
}

# Private Subnet 2 in AZ us-east-1b
resource "aws_subnet" "private_subnet_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.160.0/20"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "private-subnet-az2"
  }
}

# RDS Subnet Group including subnets in different AZs
resource "aws_db_subnet_group" "my_db_subnet_group" {
  name        = "mydb-subnet-infra1"
  subnet_ids  = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]

  tags = {
    Name = "MyDBSubnetGroup"
  }
}
# RDS Instance
resource "aws_db_instance" "my_database" {
  allocated_storage       = 20
  storage_type            = "gp2"
  instance_class          = "db.t3.micro"        # Correct argument
  engine                  = "mysql"
  engine_version          = "8.0"
  username                = "admin"              # Correct argument
  password                = var.db_master_password   # Use the variable for password
  db_subnet_group_name    = aws_db_subnet_group.my_db_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.my_security_group.id]
  backup_retention_period = 7
  publicly_accessible     = false

  tags = {
    Name = "MyDatabase"
  }
}


# Security Group for RDS
resource "aws_security_group" "my_security_group" {
  name        = "my-db-security-group"
  description = "Allow database access"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "MyDatabaseSecurityGroup"
  }
}
