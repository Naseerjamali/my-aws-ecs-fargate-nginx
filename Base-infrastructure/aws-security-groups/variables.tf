variable "name" {
  description = "the name of your stack, e.g. \"demo\""
}

variable "vpc_id" {
  description = "VPC id of ecs-vpc"
}


variable "container_port" {
  description = "The port where the Docker is exposed"
}