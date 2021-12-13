locals {
  vpc_component       = "vpc" # Virtual Private Cloud (VPC)
  flow_logs_component = "vpc-flow-logs"
  s3_bucket_component = "s3"
}

resource "aws_vpc" "main" {
  cidr_block           = var.cidr
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    {
      Component = local.vpc_component
      Name      = join("-", [var.common_tags.Environment, var.common_tags.Product, local.vpc_component])
    }
  )
}

resource "aws_flow_log" "main" {
  count = var.flow_logs ? 1 : 0

  log_destination      = aws_s3_bucket.vpc_flow_logs[0].arn
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.main.id

  tags = merge(
    {
      Component = local.flow_logs_component
      Name      = join("-", [var.common_tags.Environment, var.common_tags.Product, local.flow_logs_component])
    }
  )
}

resource "aws_s3_bucket" "vpc_flow_logs" {
  count = var.flow_logs ? 1 : 0

  acl           = "private"
  bucket        = "vpc-flow-logs-${aws_vpc.main.id}"
  force_destroy = true

  tags = merge(
    {
      Component = local.s3_bucket_component
      Name      = join("-", [var.common_tags.Environment, var.common_tags.Product, local.s3_bucket_component])
    }
  )
}
