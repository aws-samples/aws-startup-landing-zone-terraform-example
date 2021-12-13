locals {
  public_subnet_component      = "pub-sn" # Public Subnet
  public_route_table_component = "pub-rt"
  zone                         = element(split("-", var.availability_zone), 2)
  prefix                       = join("-", [var.common_tags.Environment, var.common_tags.Product])
}

resource "aws_subnet" "main" {
  availability_zone       = var.availability_zone
  cidr_block              = var.cidr_block
  map_public_ip_on_launch = false
  vpc_id                  = var.vpc_id


  tags = merge(
    {
      Component = local.public_subnet_component
      Name      = join("-", [local.prefix, local.public_subnet_component, local.zone])
    }
  )
}

resource "aws_route_table" "main" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.internet_gateway_id
  }

  tags = merge(
    {
      Component = local.public_route_table_component
      Name      = join("-", [local.prefix, local.public_route_table_component, local.zone])
    }
  )
}

resource "aws_route_table_association" "main" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.main.id
}
