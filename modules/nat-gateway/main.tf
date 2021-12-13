locals {
  nat_component = "nat" # NAT Gateway
  zone          = element(split("-", var.availability_zone), 2)
  prefix        = join("-", [var.common_tags.Environment, var.common_tags.Product])
}

resource "aws_nat_gateway" "main" {
  allocation_id = var.eip_allocation_id
  subnet_id     = var.public_subnet_id

  tags = merge(
    {
      Component = local.nat_component
      Name      = join("-", [local.prefix, local.nat_component, local.zone])
    }
  )
}
