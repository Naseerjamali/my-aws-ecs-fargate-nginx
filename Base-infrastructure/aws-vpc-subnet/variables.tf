variable "name" {
  description = "the name of your stack, e.g. \"demo\""
}


variable "cidr" {
  description = "The CIDR block for the VPC."
}

variable "public_subnets" {
  type        = list(string)
  description = "Public Subnet CIDR values"
}

variable "private_subnets" {
  type        = list(string)
  description = "Private Subnet CIDR values"
}

variable "availability_zones" {
  type        = list(string)
  description = "Availability_zones for ecs-vpc"
}

variable "aws_region" {
    type      = string
}