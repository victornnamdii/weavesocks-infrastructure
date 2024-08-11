resource "aws_nat_gateway" "gw1" {
  allocation_id = var.eip1_id
  subnet_id     = var.public_1_id

  tags = {
    Name = "NAT 1"
  }
}

resource "aws_nat_gateway" "gw2" {
  allocation_id = var.eip2_id
  subnet_id     = var.public_2_id

  tags = {
    Name = "NAT 2"
  }
}
