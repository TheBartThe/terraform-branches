module "vpc" {
  source           = "./vpc"
  environment      = var.environment
  region           = var.region
  open_internet    = var.open_internet
  public_subnet_id = module.subnets.public_subnet_id
}

/*
module "ec2" {
source = "./ec2"
environment = var.environment
region = var.region
ami_id = var.ami_id
public_subnet_id = module.subnets.public_subnet_id
private_subnet_id = module.subnets.private_subnet_id
}
*/

module "subnets" {
  source      = "./subnets"
  environment = var.environment
  region      = var.region
  vpc_id      = module.vpc.vpc_id
}

module "asg" {
  source           = "./asg"
  environment      = var.environment
  region           = var.region
  ami_id           = var.ami_id
  instance_type    = var.instance_type
  key_pair         = var.key_pair
  asg_start        = var.asg_start
  asg_stop         = var.asg_stop
  public_subnet_id = module.subnets.public_subnet_id
}
