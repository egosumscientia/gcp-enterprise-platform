variable "project_id" {
  type        = string
  description = "ID del proyecto GCP"
}

variable "region" {
  type        = string
  description = "Región donde se creará Cloud SQL"
}

variable "vpc_self_link" {
  type        = string
  description = "Self link de la VPC para Private IP"
}

variable "private_subnet_ip_range" {
  type        = string
  description = "Rango de IP para el Private Service Connection"
}

variable "db_instance_name" {
  type        = string
  description = "Nombre de la instancia MySQL"
  default     = "mysql-enterprise"
}

variable "db_tier" {
  type        = string
  description = "Tier/máquina de Cloud SQL"
  default     = "db-n1-standard-1"
}

variable "db_user" {
  type        = string
  description = "Usuario principal"
  default     = "dbadmin"
}

variable "db_password" {
  type        = string
  description = "Password del usuario principal"
  sensitive   = true
}
