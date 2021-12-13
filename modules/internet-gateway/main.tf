locals {
  component = "igw" # Internet gateway
  prefix    = join("-", [var.common_tags.Environment, var.common_tags.Product])
}

resource "aws_internet_gateway" "main" {
  vpc_id = var.vpc_id

  tags = merge(
    {
      Component = local.component
      Name      = join("-", [local.prefix, local.component])
    }
  )
}
