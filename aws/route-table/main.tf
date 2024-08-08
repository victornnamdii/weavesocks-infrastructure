resource "aws_route_table" "sock_shop_route_table" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }
}

resource "aws_route_table_association" "sock_shop_route_table_association1" {
  subnet_id      = var.public_subnet1
  route_table_id = aws_route_table.sock_shop_route_table.id
}

resource "aws_route_table_association" "sock_shop_route_table_association2" {
  subnet_id      = var.public_subnet2
  route_table_id = aws_route_table.sock_shop_route_table.id
}
