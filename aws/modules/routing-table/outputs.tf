output "public_rt_id" {
  value = aws_route_table.sock_shop_public_rt.id
}

output "private_rt_1_id" {
  value = aws_route_table.sock_shop_private_rt_1.id
}

output "private_rt_2_id" {
  value = aws_route_table.sock_shop_private_rt_2.id
}
