variable "availability_zone" {
  type        = string
  description = "An availability zone for the region"
}

variable "cidr_block" {
  type        = string
  description = "Subnet's CIDR range"
}

variable "nat_gateway_id" {
  type        = string
  description = "NAT Gateway ID"
}

variable "vpc_id" {
  type        = string
  description = "ID of VPC to attach this Internet gateway to"
}

variable "common_tags" {
  type = object({
    Environment = string
    Product     = string
  })
  description = "Default AWS resource's tags"
}
