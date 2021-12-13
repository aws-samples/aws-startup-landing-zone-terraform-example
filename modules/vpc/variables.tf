variable "cidr" {
  type        = string
  description = "VPC's CIDR range ie. 10.0.0.0/16"
}

variable "flow_logs" {
  type        = bool
  description = "Enable VPC flow logs"
  default     = false
}

variable "common_tags" {
  type = object({
    Environment = string
    Product     = string
  })
  description = "Default AWS resource's tags"
}
