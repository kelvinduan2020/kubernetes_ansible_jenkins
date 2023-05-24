data "aws_availability_zones" "azs" {}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name   = "${var.env_prefix}-vpc"
  cidr   = var.vpc_cidr_block
  azs    = data.aws_availability_zones.azs.names
  public_subnets = [
    cidrsubnet(var.vpc_cidr_block, 8, 1),
    cidrsubnet(var.vpc_cidr_block, 8, 2)
  ]
  # private_subnets = [
  #   cidrsubnet(var.vpc_cidr_block, 8, 3),
  #   cidrsubnet(var.vpc_cidr_block, 8, 4)
  # ]
  # database_subnets = [
  #   cidrsubnet(var.vpc_cidr_block, 8, 5),
  #   cidrsubnet(var.vpc_cidr_block, 8, 6)
  # ]
  # create_database_subnet_group = true

  enable_nat_gateway   = false
  single_nat_gateway   = false
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    "kubernetes.io/cluster/${var.env_prefix}-eks-cluster" = "shared"
  }
}