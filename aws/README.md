# AWS Infrastructure

This directory contains the infrastructure for the Amazon Web Services utilized for this project.

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
  ├── subnets/
  ├── routing-table/
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
  - [routing-table](./modules/routing-table/): Contains the configuration for the AWS Route tables used for this infrastructure.
  - [routing-table-associations](./modules/routing-table-associations/): Contains the configuration for the AWS route table associations used for this infrastructure.
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

- EKS requires that their VPCs support DNS, hence why **enable_dns_support** and **enable_dns_hostnames** was set to true.

- For cost effiency, **instance_tenancy** was set to **default**, so the EC2 instances in which the VPC will be hosted can be shared.

- I didn't need an IPv6 CIDR block, so i set **assign_generated_ipv6_cidr_block** to false.

The VPC's id was then outputted so it could be used by other modules in this infrastructure.

### Internet Gateways

The EKS Cluster would require communication with the internet, so i had to add an `Internet Gateway` (IGW) to my VPC. The IGW enables communication between instances in the VPC and the internet. It serves as a bridge between the VPC and the external network.

The configuration for the IGW can be found at [modules/igw/main.tf](./modules/igw/main.tf).

- The outputted VPC id from the `vpc` module is connected to the Internet Gateway through `vpc_id` so the Internet gateway can be linked to the VPC created.

The IGW's id was then outputted so it could be used by other modules in this infrastructure.


### Subnets

Private and Public Subnets were created to help with routing and controlling the flow of traffic between dufferent parts of the VPC's network. They were created in two different availability zones to enhance the EKS' availability and fault tolerance in case one availability zone is down.

The configuration for the IGW can be found at [modules/subnets/main.tf](./modules/subnets/main.tf).

- The outputted VPC id from the `vpc` module is connected to all subnets through `vpc_id` so the subnets can be linked to the VPC created.

- Each subnet was given different CIDR blocks under the VPC's CIDR block to provide network isolation.

- The two public subnets were put in two different availability zones to enhance the EKS' availability and fault tolerance in case one availability zone is down. The same was done for the private subnets. This is also an AWS recommendation for production deployments.

- Foor public subnets, each instance launched on it needed to be assigned a public IP. This was done by setting `map_public_ip_on_launch` to `true`.

- The tag `"kubernetes.io/cluster/<cluster_name>" = "shared"` allows the EKS cluster to discover the subnet and use it.

- The tag `"kubernetes.io/role/elb" = 1` allows public load balancers to be placed in public subnets

- The tag `"kubernetes.io/role/internal-elb" = 1` allows private load balancers to be placed in private subnets