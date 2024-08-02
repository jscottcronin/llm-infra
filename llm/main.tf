terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = var.region
}

data "aws_ssm_parameter" "latest_image_tag" {
  name = "/app/${var.api_name}/latest-image-tag"
}

module "vpc" {
  source   = "./modules/vpc"
  name     = var.project_name
  cidr     = var.vpc_cidr
  az_count = 3
}

module "ecs" {
  source               = "./modules/ecs"
  name                 = var.project_name
  vpc_id               = module.vpc.vpc_id
  private_subnet_ids   = module.vpc.private_subnet_ids
  container_image      = "${var.container_image}:${data.aws_ssm_parameter.latest_image_tag.value}"
  container_port       = var.container_port
  alb_target_group_arn = module.alb.target_group_arn
}

module "alb" {
  source            = "./modules/alb"
  name              = var.project_name
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  container_port    = var.container_port
}
