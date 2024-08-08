output "public_subnet1" {
  value = aws_subnet.sock_shop_pub_subnet1.id
}

output "public_subnet2" {
  value = aws_subnet.sock_shop_pub_subnet2.id
}

output "private_subnet1" {
  value = aws_subnet.sock_shop_priv_subnet1.id
}

output "private_subnet2" {
  value = aws_subnet.sock_shop_priv_subnet2.id
}
