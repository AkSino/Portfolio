# Create a VPC
resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "vpc-main"
  }
}

# Create a subnet
resource "aws_subnet" "jenkins_subnet" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.jenkins_subnet_cidr
  availability_zone       = var.availability_zone
  tags = {
    Name = "subnet-jenkins"
  }
}

# Create a security group
resource "aws_security_group" "main_security_group" {
  name        = "secug-main"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_vpc.main_vpc.id

  # Ingress rules
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_ssh
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_http
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_http
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_http
  }

  # Egress rule (allow all outbound traffic)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "secug-main"
  }
}

# Create Elastic IP
resource "aws_eip" "ip-jenkins-server" {
  instance = var.instance_id
  domain   = "vpc"
}

# Setting up a gateway
resource "aws_internet_gateway" "jenkins-server-gw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "jenkins-server-gw"
  }
}

resource "aws_route_table" "route-table-jenkins-server" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.jenkins-server-gw.id}"
  }
  tags = {
    Name = "jenkins-server-route-table"
  }
}
resource "aws_route_table_association" "subnet-association" {
  subnet_id      = "${aws_subnet.jenkins_subnet.id}"
  route_table_id = "${aws_route_table.route-table-jenkins-server.id}"
}
