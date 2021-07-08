provider "aws" {
  region = "us-east-1"
}

data "aws_vpcs" "vpc-name" {
    tags = {
      "Name" = var.vpc-name
    }
}

output "vpc-id" {
    value = data.aws_vpcs.vpc-name.ids
  
}

data "aws_vpc" "vpc-arn" {
    tags = {
        Name = var.vpc-name
    } 
}

output "vpc-arn" {
  value = data.aws_vpc.vpc-arn.arn
}

data "aws_iam_role" "eks-iam-role" {
  name = "coupa-eks"
}

output "eks-iam-role" {
    value = data.aws_iam_role.eks-iam-role.arn
  
}