variable "project_id" {
  type = string
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "zone" {
  type    = string
  default = "us-central1-a"
}

variable "vpc_name" {
  type    = string
  default = "enterprise-vpc"
}

variable "public_subnet_cidr" {
  type    = string
  default = "10.10.1.0/24"
}

variable "private_subnet_cidr" {
  type    = string
  default = "10.10.2.0/24"
}

# --------- BASTION -----------
variable "bastion_name" {
  type    = string
  default = "bastion-host"
}

variable "bastion_service_account" {
  type        = string
  description = "Service account del bastion"
}

# --------- CLOUD SQL ----------
variable "private_sql_range" {
  type        = string
  description = "Rango específico para Service Networking (private IP SQL)"
  default     = "10.20.0.0/24"
}

variable "db_instance_name" {
  type    = string
  default = "mysql-enterprise"
}

variable "db_tier" {
  type    = string
  default = "db-n1-standard-1"
}

variable "db_user" {
  type    = string
  default = "dbadmin"
}

variable "db_password" {
  type      = string
  sensitive = true
}

# --------- COMPUTE -----------
variable "instance_name_prefix" {
  type    = string
  default = "monolith"
}

variable "compute_service_account" {
  type        = string
  description = "Service Account para instancias del monolito"
}

variable "machine_type" {
  type    = string
  default = "e2-medium"
}

variable "min_replicas" {
  type    = number
  default = 2
}

variable "max_replicas" {
  type    = number
  default = 5
}

variable "cpu_target" {
  type    = number
  default = 60
}

# --------- LOAD BALANCER ---------
variable "lb_name" {
  type    = string
  default = "enterprise-lb"
}
