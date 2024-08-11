resource "aws_vpc" "sock_shop_vpc" {
  cidr_block = "10.0.0.0/16"

  instance_tenancy = "default"

  enable_dns_support = true

  enable_dns_hostnames = true

  assign_generated_ipv6_cidr_block = false

  tags = {
    Name = "sock_shop"
  }
}
