variable "project_id" {
  type        = string
  description = "ID del proyecto GCP"
}

variable "instance_group_name" {
  type        = string
  description = "Nombre del Instance Group que actuará como backend"
}

variable "region" {
  type        = string
  description = "Región del Instance Group"
}

variable "lb_name" {
  type        = string
  description = "Nombre base del Load Balancer"
  default     = "enterprise-lb"
}
