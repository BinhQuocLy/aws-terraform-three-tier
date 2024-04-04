## =========================================================================
## EC2 Instances
## =========================================================================
# AZ1 Public Instance
resource "aws_instance" "tf_test_public_instance_1" {
  ami                    = "ami-097c4e1feeea169e5"
  instance_type          = "t2.nano"
  subnet_id              = var.public_subnet_1_id
  vpc_security_group_ids = [var.public_sg_id]

  tags = {
    Name = "tf_test_public_instance_1"
  }
}

# AZ1 Private Instance For App
resource "aws_instance" "tf_test_private_instance_1" {
  ami                    = "ami-097c4e1feeea169e5"
  instance_type          = "t2.nano"
  subnet_id              = var.private_subnet_1_app_id
  vpc_security_group_ids = [var.private_sg_id]

  tags = {
    Name = "tf_test_private_instance_1"
  }
}

# AZ2 Public Instance
resource "aws_instance" "tf_test_public_instance_2" {
  ami                    = "ami-097c4e1feeea169e5"
  instance_type          = "t2.nano"
  subnet_id              = var.public_subnet_2_id
  vpc_security_group_ids = [var.public_sg_id]

  tags = {
    Name = "tf_test_public_instance_2"
  }
}

# AZ2 Private Instance For App
resource "aws_instance" "tf_test_private_instance_2" {
  ami                    = "ami-097c4e1feeea169e5"
  instance_type          = "t2.nano"
  subnet_id              = var.private_subnet_2_app_id
  vpc_security_group_ids = [var.private_sg_id]

  tags = {
    Name = "tf_test_private_instance_2"
  }
}
