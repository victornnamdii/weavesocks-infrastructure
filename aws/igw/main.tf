resource "aws_internet_gateway" "sock_shop_igw" {
  vpc_id = var.vpc_id
}