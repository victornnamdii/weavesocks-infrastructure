resource "aws_eks_cluster" "sock_shop_cluster" {
  name     = var.cluster_name
  role_arn = var.eks_cluster_arn
  version  = "1.30"

  vpc_config {
    subnet_ids = [
      var.private_subnet1,
      var.private_subnet2
    ]
    security_group_ids = [var.security_group_id]
  }
}

resource "aws_eks_node_group" "sock_shop_node_group" {
  cluster_name    = aws_eks_cluster.sock_shop_cluster.name
  node_group_name = "sock-shop-node-group"
  node_role_arn   = var.node_role_arn
  subnet_ids = [
    var.private_subnet1,
    var.private_subnet2
  ]
  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 1
  }
  instance_types = ["t3.medium"]
}
