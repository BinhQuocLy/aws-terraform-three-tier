module "vpc" {
  source = "./modules/vpc"
  vpc_id = module.vpc.vpc_id
}
