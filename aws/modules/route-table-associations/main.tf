resource "aws_route_table_association" "public_rt_association_1" {
  subnet_id = var.public_1_id
  route_table_id = var.public_rt_id
}

resource "aws_route_table_association" "public_rt_association_2" {
  subnet_id = var.public_2_id
  route_table_id = var.public_rt_id
}

resource "aws_route_table_association" "private_rt_association_1" {
  subnet_id = var.private_1_id
  route_table_id = var.private_rt_1_id
}

resource "aws_route_table_association" "private_rt_association_2" {
  subnet_id = var.private_2_id
  route_table_id = var.private_rt_2_id
}