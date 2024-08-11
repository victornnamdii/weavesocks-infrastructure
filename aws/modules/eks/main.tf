resource "aws_eks_cluster" "sock_shop_eks" {
  name     = "sock_shop"
  role_arn = var.cluster_arn
  version  = "1.30"

  vpc_config {
    endpoint_private_access = false
    endpoint_public_access  = true

    subnet_ids = [
      var.public_1_id,
      var.public_2_id,
      var.private_1_id,
      var.private_2_id
    ]
  }
}

resource "aws_eks_node_group" "sock_shop_eks_nodes" {
  cluster_name    = aws_eks_cluster.sock_shop_eks.name
  node_group_name = "sock-shop-nodes"
  node_role_arn   = var.nodes_arn

  subnet_ids = [
    var.private_1_id,
    var.private_2_id
  ]

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  ami_type             = "AL2_x86_64"
  capacity_type        = "ON_DEMAND"
  disk_size            = 20
  force_update_version = false

  instance_types = ["t3.large"]

  tags = {
    role = "sock-shop-nodes"
  }

  depends_on = [aws_eks_cluster.sock_shop_eks]
}
