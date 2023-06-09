terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws-region
}


# VPC Module
module "vpc" {
  source             = "./Base-infrastructure/aws-vpc-subnet"
  name               = var.name
  aws_region         = var.aws-region
  cidr               = var.cidr
  private_subnets    = var.private_subnets
  public_subnets     = var.public_subnets
  availability_zones = var.availability_zones
}


# Security groups Module
module "security_groups" {
  source         = "./Base-infrastructure/aws-security-groups"
  name           = var.name
  vpc_id         = module.vpc.id
  container_port = var.container_port
}

# ALB Module
module "alb" {
  source              = "./Base-infrastructure/aws-alb"
  name                = var.name
  vpc_id              = module.vpc.id
  subnets             = module.vpc.public_subnets
  alb_security_groups = [module.security_groups.alb]
  alb_tls_cert_arn    = var.tsl_certificate_arn
  health_check_path   = var.health_check_path
  container_port      = var.container_port
}


module "ecr" {
  source = "./ecs-infrastructure/aws-ecr"
  name   = var.name
}

#module "secrets" {
# source              = "./secrets"
#name                = var.name
#environment         = var.environment
# application-secrets = var.application-secrets
#}


module "ecs" {
  source = "./ecs-infrastructure/aws-ecs-cluster"
  name   = var.name
  #environment                 = var.environment
  region                      = var.aws-region
  subnets                     = module.vpc.private_subnets
  aws_alb_target_group_arn    = module.alb.aws_alb_target_group_arn
  ecs_service_security_groups = module.security_groups.ecs-task-sg
  container_port              = var.container_port
  container_cpu               = var.container_cpu
  container_memory            = var.container_memory
  service_desired_count       = var.service_desired_count
  container_environment = [
    { name = "LOG_LEVEL",
    value = "DEBUG" },
    { name = "PORT",
    value = var.container_port }
  ]
  #container_secrets      = module.secrets.secrets_map
  container_image = "nginx" #module.ecr.aws_ecr_repository_url
  #container_secrets_arns = module.secrets.application_secrets_arn
}
