resource "aws_route_table" "sock_shop_public_rt" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }

  tags = {
    Name = "public"
  }
}

resource "aws_route_table" "sock_shop_private_rt_1" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.nat_gw1_id
  }

  tags = {
    Name = "private1"
  }
}

resource "aws_route_table" "sock_shop_private_rt_2" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.nat_gw2_id
  }

  tags = {
    Name = "private2"
  }
}
