provider "aws" {
  region  = var.region
}

locals {
  common_tags = {
      environment = "${var.environment}"
      owner = "troy@hashicorp.com"
      costcenter = "12345"
    }
}

module "frontend" {
  source  = "app.terraform.io/Troy/server-module/aws"
  version = "1.0.0"
  name              = "frontend"
  tags              = local.common_tags
  vpc_id            = module.network.vpc_id
  vpc_subnet_ids    = module.network.public_subnets[0]
  security_group_id = module.network.security_group_id
  public_key        = var.keypair
  private_ip        = "10.140.101.10"
  upstream_ip       = "10.140.101.11"
}

module "public_api" {
  source  = "app.terraform.io/Troy/server-module/aws"
  version = "1.0.0"
  name              = "public_api"
  tags              = local.common_tags
  vpc_id            = module.network.vpc_id
  vpc_subnet_ids    = module.network.public_subnets[0]
  security_group_id = module.network.security_group_id
  public_key        = var.keypair
  private_ip        = "10.140.101.11"
  upstream_ip       = "10.140.101.12"
}

module "product_api" {
  source  = "app.terraform.io/Troy/server-module/aws"
  version = "1.0.0"
  name              = "product_api"
  tags              = local.common_tags
  vpc_id            = module.network.vpc_id
  vpc_subnet_ids    = module.network.public_subnets[0]
  security_group_id = module.network.security_group_id
  public_key        = var.keypair
  private_ip        = "10.140.101.12"
  upstream_ip       = "10.140.101.13"
}

module "postgres" {
  source  = "app.terraform.io/Troy/server-module/aws"
  version = "1.0.0"
  name              = "postgres"
  tags              = local.common_tags
  vpc_id            = module.network.vpc_id
  vpc_subnet_ids    = module.network.public_subnets[0]
  security_group_id = module.network.security_group_id
  public_key        = var.keypair
  private_ip        = "10.140.101.13"
  upstream_ip       = "10.140.101.14"
}

module "network" {
  source  = "app.terraform.io/Troy/network-module/aws"
  version = "1.0.0"
  name            = "Hashicups"
  azs = ["${var.region}a", "${var.region}b", "${var.region}c"]
  private_subnets = ["10.140.1.0/24", "10.140.2.0/24", "10.140.3.0/24"]
  public_subnets  = ["10.140.101.0/24", "10.140.102.0/24", "10.140.103.0/24"]
  cidr_block      = "10.140.0.0/16"
}