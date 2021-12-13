terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  required_version = "~> 1.0"

  backend "s3" {
    bucket = "[YOUR_BUCKET_NAME]"
    key    = "network/dev"
    region = "ap-southeast-1"
  }
}

locals {
  common_tags = {
    Environment = var.environment
    Product     = var.product
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = local.common_tags
  }
}

module "vpc" {
  source = "../../modules/vpc"

  cidr      = var.vpc_cidr
  flow_logs = var.enable_vpc_flow_logs

  common_tags = local.common_tags
}

module "igw" {
  source = "../../modules/internet-gateway"

  vpc_id = module.vpc.id

  common_tags = local.common_tags
}

module "public_subnet" {
  for_each            = toset(var.aws_availability_zones)
  source              = "../../modules/public-subnet"
  availability_zone   = each.key
  cidr_block          = var.public_subnet_cidrs[each.key]
  internet_gateway_id = module.igw.id

  vpc_id = module.vpc.id

  common_tags = local.common_tags
}

module "nat_gateway" {
  for_each          = toset(var.aws_availability_zones)
  source            = "../../modules/nat-gateway"
  availability_zone = each.key
  eip_allocation_id = var.aws_elastic_ip_allocation_ids[index(var.aws_availability_zones, each.key)]
  public_subnet_id  = module.public_subnet[each.key].id

  common_tags = local.common_tags
}

module "private_subnet" {
  for_each          = toset(var.aws_availability_zones)
  source            = "../../modules/private-subnet"
  availability_zone = each.key
  cidr_block        = var.private_subnet_cidrs[each.key]
  nat_gateway_id    = module.nat_gateway[each.key].id

  vpc_id = module.vpc.id

  common_tags = local.common_tags
}
