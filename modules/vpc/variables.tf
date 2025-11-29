variable "project_id" {
  type        = string
  description = "ID del proyecto GCP"
}

variable "vpc_name" {
  type        = string
  description = "Nombre de la VPC"
}

variable "region" {
  type        = string
  description = "Región para las subredes"
}

variable "public_subnet_cidr" {
  type        = string
  description = "CIDR para la subred pública"
}

variable "private_subnet_cidr" {
  type        = string
  description = "CIDR para la subred privada"
}
