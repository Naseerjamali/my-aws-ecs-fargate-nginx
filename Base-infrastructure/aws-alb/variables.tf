variable "name" {
  description = "the name of your stack, e.g. \"demo\""
}

variable "container_port" {
  description = "Port of container"
}

variable "vpc_id" {
  description = "VPC id of ecs-vpc"
}

variable "alb_security_groups" {
  description = "Comma separated list of security groups"
}

variable "health_check_path" {
  description = "Http path for task health check"
}


variable "alb_tls_cert_arn" {
  description = "The ARN of the certificate that the ALB uses for https"
}

variable "subnets" {
  #type        = list(string)
  description = "Subnets for alb"
}