## ==================================================================
## Virtual Private Cloud (VPC)
## ==================================================================
resource "aws_vpc" "tf_test_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "tf_test_vpc"
  }
}

## ==================================================================
## Subnets
## ==================================================================
# AZ1 Public Subnet For Web
resource "aws_subnet" "tf_test_public_subnet_1_web" {
  vpc_id                  = aws_vpc.tf_test_vpc.id
  availability_zone       = "ap-southeast-1a"
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "tf_test_public_subnet_1_web"
  }
}

# AZ1 Private Subnet For App
resource "aws_subnet" "tf_test_private_subnet_1_app" {
  vpc_id            = aws_vpc.tf_test_vpc.id
  availability_zone = "ap-southeast-1a"
  cidr_block        = "10.0.1.0/24"

  tags = {
    Name = "tf_test_private_subnet_1_app"
  }
}

# AZ1 Private Subnet For DB
resource "aws_subnet" "tf_test_private_subnet_1_db" {
  vpc_id            = aws_vpc.tf_test_vpc.id
  availability_zone = "ap-southeast-1a"
  cidr_block        = "10.0.2.0/24"

  tags = {
    Name = "tf_test_private_subnet_1_db"
  }
}

# AZ2 Public Subnet For Web
resource "aws_subnet" "tf_test_public_subnet_2_web" {
  vpc_id                  = aws_vpc.tf_test_vpc.id
  availability_zone       = "ap-southeast-1b"
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "tf_test_public_subnet_2_web"
  }
}

# AZ2 Private Subnet For App
resource "aws_subnet" "tf_test_private_subnet_2_app" {
  vpc_id            = aws_vpc.tf_test_vpc.id
  availability_zone = "ap-southeast-1b"
  cidr_block        = "10.0.4.0/24"

  tags = {
    Name = "tf_test_private_subnet_2_app"
  }
}

# AZ2 Private Subnet For DB
resource "aws_subnet" "tf_test_private_subnet_2_db" {
  vpc_id            = aws_vpc.tf_test_vpc.id
  availability_zone = "ap-southeast-1b"
  cidr_block        = "10.0.5.0/24"

  tags = {
    Name = "tf_test_private_subnet_2_db"
  }
}

## ==================================================================
## Internet Gateway
## ==================================================================
resource "aws_internet_gateway" "tf_test_igw" {
  vpc_id = aws_vpc.tf_test_vpc.id

  tags = {
    Name = "tf_test_igw"
  }
}

## ==================================================================
## Route Tables
## ==================================================================
# Public Route Table
resource "aws_route_table" "tf_test_public_rt" {
  vpc_id = aws_vpc.tf_test_vpc.id

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf_test_igw.id
  }

  tags = {
    Name = "tf_test_public_rt"
  }
}

# Private Route Table
resource "aws_route_table" "tf_test_private_rt" {
  vpc_id = aws_vpc.tf_test_vpc.id

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }

  tags = {
    Name = "tf_test_private_rt"
  }
}

# Public Route Table Association
resource "aws_route_table_association" "tf_test_public_rt_assoc1" {
  count = 2
  subnet_id = element([
    aws_subnet.tf_test_public_subnet_1_web.id,
    aws_subnet.tf_test_public_subnet_2_web.id,
  ], count.index)
  route_table_id = aws_route_table.tf_test_public_rt.id
}

# Private Route Table Association
resource "aws_route_table_association" "tf_test_private_rt_assoc1" {
  count = 4
  subnet_id = element([
    aws_subnet.tf_test_private_subnet_1_app.id,
    aws_subnet.tf_test_private_subnet_1_db.id,
    aws_subnet.tf_test_private_subnet_2_app.id,
    aws_subnet.tf_test_private_subnet_2_db.id
  ], count.index)
  route_table_id = aws_route_table.tf_test_private_rt.id
}

## ==================================================================
## Security Groups
## ==================================================================
# Public Security Group (Inbound:22,80,443; Outbound:"ALL")
resource "aws_security_group" "tf_test_public_sg" {
  name   = "tf_test_public_sg"
  vpc_id = aws_vpc.tf_test_vpc.id

  tags = {
    Name = "tf_test_public_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "tf_allow_inbound_ssh_public" {
  description       = "SSH"
  security_group_id = aws_security_group.tf_test_public_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22

  tags = {
    Name = "tf_allow_inbound_ssh"
  }
}

resource "aws_vpc_security_group_ingress_rule" "tf_allow_inbound_http" {
  description       = "HTTPS"
  security_group_id = aws_security_group.tf_test_public_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80

  tags = {
    Name = "tf_allow_inbound_http"
  }
}

resource "aws_vpc_security_group_ingress_rule" "tf_allow_inbound_https" {
  description       = "HTTPS"
  security_group_id = aws_security_group.tf_test_public_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443

  tags = {
    Name = "tf_allow_inbound_https"
  }
}

resource "aws_vpc_security_group_egress_rule" "tf_allow_outbound_all" {
  security_group_id = aws_security_group.tf_test_public_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"

  tags = {
    Name = "tf_allow_outbound_all"
  }
}

# Private Security Group (Inbound:22; Outbound:"NO")
resource "aws_security_group" "tf_test_private_sg" {
  name   = "tf_test_private_sg"
  vpc_id = aws_vpc.tf_test_vpc.id

  tags = {
    Name = "tf_test_private_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "tf_allow_inbound_ssh_private" {
  description       = "SSH"
  security_group_id = aws_security_group.tf_test_private_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22

  tags = {
    Name = "tf_allow_inbound_ssh_private"
  }
}

## =========================================================================
## EC2 Instance Connect Endpoint (Optional)
## =========================================================================
# AZ1 Private Subnet For App, Public Security Group
resource "aws_ec2_instance_connect_endpoint" "tf_test_eice" {
  subnet_id          = aws_subnet.tf_test_private_subnet_1_app.id
  security_group_ids = [aws_security_group.tf_test_public_sg.id]

  tags = {
    Name = "tf_test_eice"
  }
}
