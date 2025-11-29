variable "project_id" {
  type        = string
  description = "ID del proyecto GCP"
}

variable "vpc_name" {
  type        = string
  description = "Nombre de la VPC donde aplicar reglas"
}

variable "public_subnet_self_link" {
  type        = string
  description = "Subred pública (para el LB si se requiere)"
}

variable "private_subnet_self_link" {
  type        = string
  description = "Subred privada (instancias del monolito)"
}
