# VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "mern-project-vpc"
  }
}
# Public Subnet
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet
  availability_zone = "${var.aws_region}a"
  map_public_ip_on_launch = true

  tags = {
    Name = "mern-project-public-subnet"
  }
}
# Private Subnet
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet
  availability_zone = "${var.aws_region}a"
  map_public_ip_on_launch = false

  tags = {
    Name = "mern-project-private-subnet"
  }
}
# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "mern-project-igw"
  }
}
# Elastic IP + NAT Gateway
resource "aws_eip" "nat" {
  domain= "vpc" 

  tags = {
    Name = "mern-project-nat-eip"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = "mern-project-nat-gateway"
  }
}
# Route Table for Public Subnet
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}
# associate public subnet with route table
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
}
# Route Table for Private Subnet
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }
}
# associate private subnet with route table
resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private_rt.id
}
# Security Group for Web Instances
resource "aws_security_group" "web_sg" {
  name        = "mern-project-web-sg"
  description = "Allow HTTP and SSH traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] 
  }
}
# Security Group for Database Instances
resource "aws_security_group" "db_sg" {
  name        = "mern-project-db-sg"
  description = "Allow MongoDB traffic from web instances"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    security_groups = [aws_security_group.web_sg.id] 
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.web_sg.id] 
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] 
  }
}
# # Web Server Instances
resource "aws_instance" "web" {
  ami           = "ami-091138d0f0d41ff90"
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public.id
  key_name      = var.key_name
  security_groups = [aws_security_group.web_sg.id]

  tags = {
    Name = "mern-project-web-server"
  }
}
# Manager Server Instances
resource "aws_instance" "manager" {
  ami           = "ami-091138d0f0d41ff90"
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public.id
  key_name      = var.key_name
  security_groups = [aws_security_group.web_sg.id]

  tags = {
    Name = "mern-project-manager-server"
  }
} 
# Database Server Instances
resource "aws_instance" "db" {
  ami           = "ami-091138d0f0d41ff90"
  instance_type = var.instance_type
  subnet_id     = aws_subnet.private.id
  key_name      = var.key_name
  security_groups = [aws_security_group.db_sg.id]

  tags = {
    Name = "mern-project-db-server"
  }
}
