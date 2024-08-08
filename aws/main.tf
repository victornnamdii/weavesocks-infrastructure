module "eks" {
  source            = "./eks"
  security_group_id = module.security_table.security_group_id
  eks_cluster_arn   = module.iam.eks_cluster_arn
  node_role_arn     = module.iam.node_role_arn
  private_subnet1   = module.subnet.private_subnet1
  private_subnet2   = module.subnet.private_subnet2
  cluster_name      = var.cluster_name
}

module "iam" {
  source       = "./iam"
  cluster_name = var.cluster_name
}

module "igw" {
  source = "./igw"
  vpc_id = module.vpc.sock_shop_vpc_id
}

module "route_table" {
  source         = "./route-table"
  vpc_id         = module.vpc.sock_shop_vpc_id
  igw_id         = module.igw.igw_id
  public_subnet1 = module.subnet.public_subnet1
  public_subnet2 = module.subnet.public_subnet2
}

module "security_table" {
  source = "./security-group"
  vpc_id = module.vpc.sock_shop_vpc_id
}

module "subnet" {
  source = "./subnet"
  vpc_id = module.vpc.sock_shop_vpc_id
}

module "vpc" {
  source = "./vpc"
}
