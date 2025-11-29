variable "project_id" {
  type        = string
  description = "ID del proyecto GCP"
}

variable "region" {
  type        = string
  description = "Región donde correrá el Instance Group"
}

variable "zone" {
  type        = string
  description = "Zona para el Instance Template"
}

variable "instance_name_prefix" {
  type        = string
  description = "Prefijo para las instancias del monolito"
  default     = "monolith"
}

variable "private_subnet_self_link" {
  type        = string
  description = "Self link de la subred privada"
}

variable "service_account_email" {
  type        = string
  description = "Service Account para esta VM"
}

variable "machine_type" {
  type        = string
  default     = "e2-medium"
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
