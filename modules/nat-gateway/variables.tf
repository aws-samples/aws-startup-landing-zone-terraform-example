variable "availability_zone" {
  type        = string
  description = "An availability zone for the region"
}

variable "eip_allocation_id" {
  type        = string
  description = "The Allocation ID of the Elastic IP address for the gateway"
}

variable "public_subnet_id" {
  type        = string
  description = "The public subnet ID in which to place the gateway."
}

variable "common_tags" {
  type = object({
    Environment = string
    Product     = string
  })
  description = "Default AWS resource's tags"
}
