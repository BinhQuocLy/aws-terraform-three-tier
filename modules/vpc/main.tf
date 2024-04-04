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
# Public Subnet 1 (Availability Zone 1)
resource "aws_subnet" "tf_test_public_subnet_1" {
  vpc_id                  = aws_vpc.tf_test_vpc.id
  availability_zone       = "ap-southeast-1a"
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "tf_test_public_subnet_1"
  }
}

# Private Subnet 1 For App (Availability Zone 1)
resource "aws_subnet" "tf_test_private_subnet_1_app" {
  vpc_id                  = aws_vpc.tf_test_vpc.id
  availability_zone       = "ap-southeast-1a"
  cidr_block              = "10.0.1.0/24"

  tags = {
    Name = "tf_test_private_subnet_1_app"
  }
}

# Private Subnet 1 For DB (Availability Zone 1)
resource "aws_subnet" "tf_test_private_subnet_1_db" {
  vpc_id                  = aws_vpc.tf_test_vpc.id
  availability_zone       = "ap-southeast-1a"
  cidr_block              = "10.0.2.0/24"

  tags = {
    Name = "tf_test_private_subnet_1_db"
  }
}

# Public Subnet 2 (Availability Zone 2)
resource "aws_subnet" "tf_test_public_subnet_2" {
  vpc_id                  = aws_vpc.tf_test_vpc.id
  availability_zone       = "ap-southeast-1b"
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "tf_test_public_subnet_2"
  }
}

# Private Subnet 2 For App (Availability Zone 2)
resource "aws_subnet" "tf_test_private_subnet_2_app" {
  vpc_id                  = aws_vpc.tf_test_vpc.id
  availability_zone       = "ap-southeast-1b"
  cidr_block              = "10.0.4.0/24"

  tags = {
    Name = "tf_test_private_subnet_2_app"
  }
}

# Private Subnet 2 For DB (Availability Zone 2)
resource "aws_subnet" "tf_test_private_subnet_2_db" {
  vpc_id                  = aws_vpc.tf_test_vpc.id
  availability_zone       = "ap-southeast-1b"
  cidr_block              = "10.0.5.0/24"

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
    aws_subnet.tf_test_public_subnet_1.id,
    aws_subnet.tf_test_public_subnet_2.id,
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
