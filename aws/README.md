# AWS Infrastructure

This directory contains the infrastructure for the Amazon Web Services utilized for this project.

## Table of Contents

- [Infrastructure Diagram](#internet-gateways)
- [File Structure](#file-structure)
- [Design Decisions](#design-decisions)
  - [VPC](#vpc)
  - [Internet Gateways](#internet-gateways)
  - [Subnets](#subnets)
  - [Elastic Ips](#elastic-ips)
  - [NAT Gateways](#nat-gateways)
  - [Route Tables](#route-tables)
  - [Route Table Associations](#route-table-associations)
  - [Security Groups](#security-groups)
  - [IAM Role Policies](#iam-role-policies)
  - [Elastic Kubernetes Service](#elastic-kubernetes-service)

## Infrastructure Diagram

## File Structure

The following is an overview of the file structure for this infrastructure:

```
aws/
├── modules/
  ├── eip/
  ├── eks/
  ├── iam/
  ├── igw/
  ├── nat-gateways/
  ├── route-table-associations/
  ├── route-tables/
  ├── security-group/
  ├── subnets/
  └── vpc/
├── data.tf/
├── main.tf/
├── outputs.tf
└── variables.tf
```

- [modules](./modules/): Contains the terraform modules for each AWS resource used for this infrastructure.
  - [eip](./modules/eip/): Contains the configuration for the AWS Elastic IPs used for this infrastructure.
  - [eks](./modules/eks/): Contains the configuration for the AWS Elastic Kubernetes Service used for this infrastructure.
  - [iam](./modules/iam/): Contains the configuration for the AWS IAM roles and policies used for this infrastructure.
  - [igw](./modules/igw/): Contains the configuration for the AWS Internet Gateways used for this infrastructure.
  - [nat-gateways](./modules/nat-gateways/): Contains the configuration for the AWS NAT gateways used for this infrastructure.
  - [route-table](./modules/route-table/): Contains the configuration for the AWS Route tables used for this infrastructure.
  - [routing-table-associations](./modules/routing-table-associations/): Contains the configuration for the AWS route table associations used for this infrastructure.
  - [security-group](./modules/security-group/): Contains the configuration for the AWS security group used for this infrastructure.
  - [subnets](./modules/subnets/): Contains the configuration for the AWS Subnets used for this infrastructure.
  - [vpc](./modules/vpc/): Contains the configuration for the Virtual Private Cloud and policies used for this infrastructure.
- [data.tf](data.tf): Contains data sources for Terraform.
- [main.tf](main.tf): Contains the main infrastructure setup for AWS
- [outputs.tf](outputs.tf): Contains outputs for this module to be used by other modules.

## Design Decisions

The decisions i took that resulted in this infrastructure can be found below:

### VPC

AWS Virtual Private Clouds (VPCs) are isolated virtual networks within the AWS cloud that allow you to securely connect and manage resources. Amazon Elastic Kubernetes (EKS) Clusters require VPCs to manage networking and secure communication between cluster components.

The configuration for the VPC can be found at [modules/vpc/main.tf](./modules/vpc/main.tf).

- For the CIDR (Classless Inter-Domain Routing) block, i used a value of `10.0.0.0/16` which provides a range of IP addresses from `10.0.0.0` to `10.0.255.255`, offering a total of `65,536` addresses. This helps helps in routing traffic within the VPC

- EKS requires that their VPCs support DNS, hence why `enable_dns_support` and `enable_dns_hostnames` was set to true.

- For cost effiency, `instance_tenancy` was set to `default`, so the EC2 instances in which the VPC will be hosted can be shared.

- I didn't need an IPv6 CIDR block, so i set `assign_generated_ipv6_cidr_block` to false.

The ID for the VPC is then outputted from [modules/vpc/outputs.tf](./modules/vpc/outputs.tf) so other modules in the infrastructure can use it.

### Internet Gateways

The EKS Cluster would require inbound and outbound traffic to the internet, so i had to add an `Internet Gateway` (IGW) to my VPC. The IGW enables communication between instances in the VPC and the internet. It serves as a bridge between the VPC and the external network.

The configuration for the IGW can be found at [modules/igw/main.tf](./modules/igw/main.tf).

- The outputted VPC id from the `vpc` module is connected to the Internet Gateway through `vpc_id` so the Internet gateway can be linked to the VPC created.

The IDs for the IGWs is then outputted from [modules/igw/outputs.tf](./modules/igw/outputs.tf) so other modules in the infrastructure can use them.

### Subnets

Private and Public Subnets were created to help with routing and controlling the flow of traffic between dufferent parts of the VPC's network. They were created in two different availability zones to enhance the EKS' availability and fault tolerance in case one availability zone is down.

The configuration for the Subnets can be found at [modules/subnets/main.tf](./modules/subnets/main.tf).

- The outputted VPC id from the `vpc` module is connected to all subnets through `vpc_id` so the subnets can be linked to the VPC created.

- Each subnet was given different CIDR blocks under the VPC's CIDR block to provide network isolation.

- The two public subnets were put in two different availability zones to enhance the EKS' availability and fault tolerance in case one availability zone is down. The same was done for the private subnets. This is also an AWS recommendation for production deployments.

- Foor public subnets, each instance launched on it needed to be assigned a public IP. This was done by setting `map_public_ip_on_launch` to `true`.

- The tag `"kubernetes.io/cluster/<cluster_name>" = "shared"` allows the EKS cluster to discover the subnet and use it.

- The tag `"kubernetes.io/role/elb" = 1` allows public load balancers to be placed in public subnets

- The tag `"kubernetes.io/role/internal-elb" = 1` allows private load balancers to be placed in private subnets

The IDs for each subnet are then outputted from [modules/subnets/outputs.tf](./modules/subnets/outputs.tf) so other modules in the infrastructure can use them.

### Elastic IPs

Instances in the VPC's private subnet would need to communicate with the internet for things like software installation and updates, to be able to do this, NAT Gateways would be used to allow instances in the private subnet communicate with the internet. The NAT Gateways would require public static IP adddresses to be allocated to them to help with the internet communication. AWS Elastic IPs (EIP) are suitable for this purpose.

The configuration for the EIPs can be found at [modules/eip/main.tf](./modules/eip/main.tf).

- The file contains just 2 terraform `aws_eip` resources, which their IDs are then outputted from [modules/eip/outputs.tf](./modules/eip/outputs.tf) so the nat gateway module can use them.

### NAT Gateways

As mentioned above, instances in the VPC's private subnet would need to communicate with the internet for things like software installation and updates, to be able to do this, NAT Gateways would be used to allow instances in the private subnet communicate with the internet.

The configuration for the NAT Gateways can be found at [modules/nat-gateways/main.tf](./modules/nat-gateways/main.tf).

- The IDs of the EIPs created are then linked to the NAT Gateways and so are the subnets using `allocation_id` and `subnet_id` fields respectively.

The IDs for each NAT gateway are then outputted from [modules/nat-gateways/outputs.tf](./modules/nat-gateways/outputs.tf) so other modules in the infrastructure can use them.

### Route Tables

Route tables contain rules that determine where traffic from the subnets are directed to. And since the subnets contain internet gateways and nat gateways that should allow communication with the internet, I decided to use route tables to direct traffic from the IGWs and NAT gateways to the internet.

The configuration for the route tables can be found at [modules/route-tables/main.tf](./modules/route-tables/main.tf).

- A public route table is created for the internet gateway.

  - The route table is connected to the created VPC using `vpc_id` attribute
  - A route is created where `0.0.0.0/0` CIDR block also known as the internet is specified as the Destination
  - The IGW created is linked to the route created using the `gateway_id`.
  - This routes traffic from the VPC to the internet through the internet gateway

- Two private route tables are created for the two NAT gateways created above
  - The route table is connected to the created VPC using `vpc_id` attribute
  - A route is created where `0.0.0.0/0` CIDR block also known as the internet is specified as the Destination
  - The two NAT gateways created is linked to the route created using the `gateway_id`.
  - This routes traffic from the VPC to the internet through the NAT gateway

The IDs for each route table are then outputted from [modules/route-tables/outputs.tf](./modules/route-tables/outputs.tf) so other modules in the infrastructure can use them.

### Route Table Associations

To specify which subnet would use each of the route tables created, a `Route Table Association` is created to map each subnet to the required route table.

The configuration for the route table associations can be found at [modules/route-table-associations/main.tf](./modules/route-table-associations/main.tf).

- The public subnets are mapped to the public route table using their subnet ID (`subnet_id`) and the ID of the public route table (`route_table_id`).

- The private subnets are mapped to the two private route tables using their subnet ID (`subnet_id`) and the ID of the private route tables (`route_table_id`).

### Security Groups

For security reasons, external access to the VPC needs to be limited to only ports for serving the app. These ports are `80` for http, and `443` for https. Also, we need to permit outbound traffic from the VPC. To set these firewall rules, a security group was created.

The configuration for the security group can be found at [modules/security-group/main.tf](./modules/security-group/main.tf).

- The VPC was connected to the security group using the `vpc_id` attribute.
- Two `ingress` rules were added to the security group
  - The first one permits HTTP traffic to the VPC's port `80` and also routes it to port `80`. The `cidr_block` `0.0.0.0/0` attribute specifies that all internet traffic is allowed.
  - The second one permits HTTPS traffic to the VPC's port `443` and also routes it to port `443`. The `cidr_block` `0.0.0.0/0` attribute specifies that all internet traffic is allowed.
- One `egress` rule was added to the security group
  - It allows all outbound traffic from the VPC to the internet

### IAM Role Policies

The Elastic Kubernetes Service (EKS) would need permissions to be able to manage and operate clusters. Permissions like retrieving information about clusters, retrieving information about EC2 instances and much more. The EC2 instances which would be the worker nodes would also require permissions to interact with EKS, manage network interfaces and security groups associated with Kubernetes Pods, and also view and pull container images from Amazon Elastic Container Regsitry(ECR).

The configuration for the IAM roles and their policies can be found at [modules/iam/main.tf](./modules/iam/main.tf).

So two IAM roles were created. One for EKS and the other for EC2 (worker nodes).

- For the EKS cluster role, `AmazonEKSClusterPolicy` policy was attached to it to allow the EKS manage and operate clusters

  - `aws_iam_role.eks_cluster` contains the role trust policy for for the EKS
  - `aws_iam_role_policy_attachment.eks_cluster_policy` contains the `AmazonEKSClusterPolicy` policy attachment for the EKS cluster role

- For the worker nodes, `AmazonEKSWorkerNodePolicy` was attached so the EC2 intances willl be able to interact with EKS. `AmazonEKS_CNI_Policy` was attached so they would also be able to manage network interfaces and security groups associated with Kubernetes Pods, `AmazonEC2ContainerRegistryReadOnly` was attached so they would be to view and pull container images from Amazon Elastic Container Regsitry(ECR) without allowing modifications.
  - `aws_iam_role.eks_nodes` contains the role trust policy for the EC2 instances
  - `aws_iam_role_policy_attachment.eks_worker_node_policy` contains the `AmazonEKSWorkerNodePolicy` policy attachment for the node group
  - `aws_iam_role_policy_attachment.eks_cni_policy` contains the `AmazonEKS_CNI_Policy` policy attachment for the node group
  - `aws_iam_role_policy_attachment.ec2_container_registry_policy` contains the `AmazonEC2ContainerRegistryReadOnly` policy attachment for the node group

The Amazon Resource Name (ARN) for each IAM role are then outputted from [modules/iam/outputs.tf](./modules/iam/outputs.tf) so the EKS module in the infrastructure can use it.

### Elastic Kubernetes Service

Since the sock shop app would be deployed on Kubernetes, we would need Kubeernetes clusters, and Amazon Elastic Kubernetes Service provides that. It simplifies the deployment, management, and scaling of Kubernetes clusters in the cloud.

The configuration for the EKS clusters and the Kubernetes nodes can be found at [modules/eks/main.tf](./modules/eks/main.tf).

- `aws_eks_cluster.sock_shop_eks` contains the configuration for the EKS cluster.
  - The latest version of Kubernetes as at the day which the infrastructure was built which is `1.30` was used for better support and performance enhancements.
  - The ARN of the EKS cluster IAM role defined was connected to the EKS cluster to grant it necessary permissions
  - For the VPC configuration, private IP access to the EKS cluster wasnot required so `endpoint_private_access` was set to `false`. The EKS was going to be accessible through the internet so `endpoint_public_access` was set to `true`.
  - The IDs of the subnets created were also passed to the VPC configuration of the EKS cluster so it can be used for internal communication.

- `aws_eks_node_group.sock_shop_eks_nodes` contains the configuration for the Kubernetes nodes used in the cluster.
  - The name of the EKS cluster created was passed to the nodes configuration through `cluster_name` to set their relationship.
  - The ARN of the node group IAM role defined was connected to the node configuration to grant it necessary permissions
  - The nodes were then passed only private subnet IDs to minimize direct exposure to the internet. This was to enhance security and minimize vulnerablilities of the worker nodes by preventing external threats.
  - The `ami_type` was set to `AL2_x86_64` because i preferred Linux as my Base OS.
  - The `capacity_type` was set to `ON_DEMAND` so the EC2 instances will be available immediately.
  - The disk size was set to 20GB as it was enough for the Sock Shop microservices
  - To prevent the AMI from carrying out automatic updates, `force_update_version` was set to `false`. As i preferred the AMI to use it's initial version unless i perform a manual update.
  - The instance type was set to `t3.large` as it  was best suited for my infrastructure. The infrastructure would require up to 35 pods, and `t3.large`  was capable of hosting that amount of pods per node unlike instances with lower capacity than it.
  - For the `scaling_config`, 1 node was enough for this project,  as it would not be facing a lot of traffic. This was why the `max_size`,  `desired_size` and `min_size` attributes were all set to 1. This was done to  also minimize costs.

The Cluster Endpoint, and CA certificate are then outputted from [modules/eks/outputs.tf](./modules/eks/outputs.tf) so the K8s module in the infrastructure can use it.