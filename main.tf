terraform {
  required_version = ">= 1.0.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# -----------------------------------------
# VPC
# -----------------------------------------
module "vpc" {
  source              = "./modules/vpc"
  project_id          = var.project_id
  vpc_name            = var.vpc_name
  region              = var.region
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
}

# -----------------------------------------
# NAT (para subred privada)
# -----------------------------------------
module "nat" {
  source                   = "./modules/nat"
  project_id               = var.project_id
  region                   = var.region
  vpc_name                 = module.vpc.vpc_name
  private_subnet_self_link = module.vpc.private_subnet_self_link
}

# -----------------------------------------
# FIREWALL
# -----------------------------------------
module "firewall" {
  source                   = "./modules/firewall"
  project_id               = var.project_id
  vpc_name                 = module.vpc.vpc_name
  public_subnet_self_link  = module.vpc.public_subnet_self_link
  private_subnet_self_link = module.vpc.private_subnet_self_link
}

# -----------------------------------------
# BASTION HOST (SIN IP PÚBLICA, SSH solo por IAP)
# -----------------------------------------
module "bastion" {
  source                  = "./modules/bastion"
  project_id              = var.project_id
  zone                    = var.zone
  bastion_name            = var.bastion_name
  subnet_self_link        = module.vpc.public_subnet_self_link
  service_account_email   = var.bastion_service_account
}

# -----------------------------------------
# CLOUD SQL (PRIVATE IP)
# -----------------------------------------
module "sql" {
  source                  = "./modules/sql"
  project_id              = var.project_id
  region                  = var.region
  vpc_self_link           = module.vpc.vpc_self_link
  private_subnet_ip_range = var.private_sql_range
  db_instance_name        = var.db_instance_name
  db_tier                 = var.db_tier
  db_user                 = var.db_user
  db_password             = var.db_password
}

# -----------------------------------------
# COMPUTE (Instance Template + IGM + Autoscaling)
# -----------------------------------------
module "compute" {
  source                  = "./modules/compute"
  project_id              = var.project_id
  region                  = var.region
  zone                    = var.zone
  instance_name_prefix    = var.instance_name_prefix
  private_subnet_self_link = module.vpc.private_subnet_self_link
  service_account_email   = var.compute_service_account
  machine_type            = var.machine_type
  min_replicas            = var.min_replicas
  max_replicas            = var.max_replicas
  cpu_target              = var.cpu_target
}

# -----------------------------------------
# LOAD BALANCER GLOBAL HTTP
# -----------------------------------------
module "lb" {
  source               = "./modules/lb"
  project_id           = var.project_id
  instance_group_name  = module.compute.instance_group_name
  region               = var.region
  lb_name              = var.lb_name
}
