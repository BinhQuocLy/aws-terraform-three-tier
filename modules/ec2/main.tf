## =========================================================================
## EC2 Instances
## =========================================================================
# AZ1 Public Instance For Web
resource "aws_instance" "tf_test_public_instance_1" {
  ami                    = "ami-097c4e1feeea169e5"
  instance_type          = "t2.nano"
  subnet_id              = var.public_subnet_1_web_id
  vpc_security_group_ids = [var.public_sg_id]
  user_data              = file("${path.module}/user_data.sh")

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

# AZ2 Public Instance For Web
resource "aws_instance" "tf_test_public_instance_2" {
  ami                    = "ami-097c4e1feeea169e5"
  instance_type          = "t2.nano"
  subnet_id              = var.public_subnet_2_web_id
  vpc_security_group_ids = [var.public_sg_id]
  user_data              = file("${path.module}/user_data.sh")

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

## =========================================================================
## Target Group
## =========================================================================
# Public Target Group For Web
resource "aws_lb_target_group" "tf_test_public_tg" {
  name     = "tf-test-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group_attachment" "tf_test_tg_public_attac" {
  count            = 2
  target_group_arn = aws_lb_target_group.tf_test_public_tg.arn
  target_id = element([
    aws_instance.tf_test_public_instance_1.id,
    aws_instance.tf_test_public_instance_2.id,
  ], count.index)
  port = 80
}

## =========================================================================
## Application Load Balancer (ALB)
## =========================================================================
# Public Load Balancer For Web
resource "aws_lb" "tf_test_alb" {
  name               = "tf-test-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.public_sg_id]
  subnets            = [var.public_subnet_1_web_id, var.public_subnet_2_web_id]

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_listener" "tf_test_alb_public_listener" {
  load_balancer_arn = aws_lb.tf_test_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tf_test_public_tg.arn
  }
}
