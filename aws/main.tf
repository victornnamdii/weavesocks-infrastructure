module "vpc" {
  source = "./modules/vpc"
}

module "igw" {
  source = "./modules/igw"
  vpc_id = module.vpc.vpc_id
}

module "subnets" {
  source       = "./modules/subnets"
  vpc_id       = module.vpc.vpc_id
  cluster_name = var.cluster_name
}

module "eip" {
  source     = "./modules/eip"
  depends_on = [module.igw]
}

module "nat_gateways" {
  source      = "./modules/nat-gateways"
  eip1_id     = module.eip.eip1_id
  eip2_id     = module.eip.eip2_id
  public_1_id = module.subnets.public_1_id
  public_2_id = module.subnets.public_2_id
}

module "routing_table" {
  source     = "./modules/routing-table"
  vpc_id     = module.vpc.vpc_id
  igw_id     = module.igw.igw_id
  nat_gw1_id = module.nat_gateways.nat_gw1_id
  nat_gw2_id = module.nat_gateways.nat_gw2_id
}

module "route_table_associations" {
  source          = "./modules/route-table-associations"
  public_1_id     = module.subnets.public_1_id
  public_2_id     = module.subnets.public_2_id
  public_rt_id    = module.routing_table.public_rt_id
  private_1_id    = module.subnets.private_1_id
  private_2_id    = module.subnets.private_2_id
  private_rt_1_id = module.routing_table.private_rt_1_id
  private_rt_2_id = module.routing_table.private_rt_2_id
}

module "iam" {
  source = "./modules/iam"
}

module "eks" {
  source       = "./modules/eks"
  cluster_name = var.cluster_name
  cluster_arn  = module.iam.cluster_arn
  public_1_id  = module.subnets.public_1_id
  public_2_id  = module.subnets.public_2_id
  private_1_id = module.subnets.private_1_id
  private_2_id = module.subnets.private_2_id
  nodes_arn    = module.iam.nodes_arn

  depends_on = [module.iam]
}

data "aws_eks_cluster_auth" "auth" {
  name = module.eks.cluster_name
}
