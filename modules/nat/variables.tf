variable "project_id" {
  type        = string
  description = "ID del proyecto GCP"
}

variable "region" {
  type        = string
  description = "Región donde se creará el NAT y Router"
}

variable "vpc_name" {
  type        = string
  description = "Nombre de la VPC donde se crearán los recursos"
}

variable "private_subnet_self_link" {
  type        = string
  description = "Self link de la subred privada"
}
