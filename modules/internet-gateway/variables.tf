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
