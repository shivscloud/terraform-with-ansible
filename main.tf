provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source     = "./modules/vpc"
  vpc_cidr   = "10.0.0.0/16"
  availability_zones = var.az
  subnets    = var.subnets
}

module "sg" {
  source     = "./modules/sg"
  vpc_id   = module.vpc.vpc_id
  
}

module "ec2" {
  source              = "./modules/ec2"
  ami_id              = var.ami_id
  subnet_ids           = module.vpc.subnet_ids
  security_group_ids  = [module.sg.security_group_id]
}