module "vpc" {
  source                  = "./modules/vpc"
}

module "ec2" {
  source                  = "./modules/ec2"
  public_subnet_1_id      = module.vpc.public_subnet_1_id
  private_subnet_1_app_id = module.vpc.private_subnet_1_app_id
  public_subnet_2_id      = module.vpc.public_subnet_2_id
  private_subnet_2_app_id = module.vpc.private_subnet_2_app_id
  public_sg_id            = module.vpc.public_sg_id
  private_sg_id           = module.vpc.private_sg_id
  depends_on              = [module.vpc]
}
