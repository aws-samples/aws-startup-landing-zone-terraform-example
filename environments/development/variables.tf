variable "aws_availability_zones" {
  type        = list(string)
  description = "List of availability zone in the region"
}

variable "aws_region" {
  type        = string
  description = "AWS region such as 'ap-southeast-1' (Singapore)"
  default     = "ap-southeast-1"
}

variable "aws_elastic_ip_allocation_ids" {
  type        = list(string)
  description = "List of Elastic IP's allocation ID"
}

variable "enable_vpc_flow_logs" {
  type        = bool
  description = "Enable VPC Flow Logs"
  default     = true
}

variable "environment" {
  type        = string
  description = "Environment where AWS resources are deployed"
  default     = "dev"
}

variable "product" {
  type        = string
  description = "Product name"
}

variable "public_subnet_cidrs" {
  type        = map(string)
  description = "List of public subnet's CIDRs"
}

variable "private_subnet_cidrs" {
  type        = map(string)
  description = "List of private subnet's CIDRs"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC's CIDR range ie. 10.0.0.0/16"
}
