variable "eks-cluster-name" {
  default = "eks-terraform"
  type = string
}

variable "vpc-name" {
    default = "intvpc1"
    type = string
}

variable "eks-iam-role" {
    default = "coupa-eks"
    type = string
}

variable "nodegroup-iam-role" {
  default = "coupa-eks-nodes"
  type = string
}

variable "node-group-subnet" {
    default = ["subnet-b97b40dc","subnet-78612321"]
    type = list(string)
  
}

variable "node_group_name" {
  default = "eks-node-group-1"
}