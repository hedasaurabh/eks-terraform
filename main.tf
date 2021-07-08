provider "aws" {
  region = "us-east-1"
}

//data "aws_vpcs" "vpc-name" {
//    tags = {
//      "Name" = var.vpc-name
//    }
//}

data "aws_vpc" "vpc-arn" {
    tags = {
        Name = var.vpc-name
    } 
}

//output "vpc_id" {
//    value = data.aws_vpcs.vpc-name
//}

//output "vpc-arn" {
//  value = data.aws_vpc.vpc-arn.id
//}


data "aws_iam_role" "eks-iam-role" {
  name = var.eks-iam-role
}

data "aws_iam_role" "nodegroup-iam-role" {
  name = var.nodegroup-iam-role
}

//output "eks-iam-role" {
//    value = data.aws_iam_role.eks-iam-role.arn
//}

data "aws_subnet_ids" "subnet_list" {
    vpc_id = data.aws_vpc.vpc-arn.id

}

//output "subnet" {
//    value = data.aws_subnet_ids.subnet_list.ids
//}

resource "aws_security_group" "eks-cluster-sg-terraform" {
  name        = "eks-cluster-sg-terraform"
  description = "SG created for EKS cluster using Terrafirm"
  vpc_id      = data.aws_vpc.vpc-arn.id
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eks-cluster-sg-terraform"
  }
}

resource "aws_eks_cluster" "eks-terraform" {
    name = var.eks-cluster-name
    role_arn = data.aws_iam_role.eks-iam-role.arn
    vpc_config {
      subnet_ids = data.aws_subnet_ids.subnet_list.ids
      security_group_ids = [aws_security_group.eks-cluster-sg-terraform.id]
    }
}

resource "aws_eks_node_group" "private-group" {
  cluster_name = aws_eks_cluster.eks-terraform.name
  node_group_name = var.node_group_name
  node_role_arn = data.aws_iam_role.nodegroup-iam-role.arn
  subnet_ids = var.node-group-subnet
  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 2
  } 
}