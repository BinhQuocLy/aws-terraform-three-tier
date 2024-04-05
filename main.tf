module "vpc" {
  source = "./modules/vpc"
}

module "ec2" {
  source                  = "./modules/ec2"
  vpc_id                  = module.vpc.vpc_id
  public_subnet_1_web_id  = module.vpc.public_subnet_1_web_id
  private_subnet_1_app_id = module.vpc.private_subnet_1_app_id
  public_subnet_2_web_id  = module.vpc.public_subnet_2_web_id
  private_subnet_2_app_id = module.vpc.private_subnet_2_app_id
  public_sg_id            = module.vpc.public_sg_id
  private_sg_id           = module.vpc.private_sg_id
}

module "route53" {
  source      = "./modules/route53"
  vpc_id      = module.vpc.vpc_id
  root_domain = "test.com"
  app_domain  = "app.test.com"
}
