# ----------------------------------------------------------------------
# Crear rango de Service Networking para Private IP de Cloud SQL
# ----------------------------------------------------------------------
resource "google_compute_global_address" "private_sql_range" {
  name          = "${var.db_instance_name}-private-range"
  project       = var.project_id
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 24
  network       = var.vpc_self_link
  address       = null
}

# ----------------------------------------------------------------------
# Establecer peering para servicios de Google (Private Service Connect)
# ----------------------------------------------------------------------
resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = var.vpc_self_link
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_sql_range.name]
}

# ----------------------------------------------------------------------
# Instancia Cloud SQL MySQL (solo Private IP, sin pública)
# ----------------------------------------------------------------------
resource "google_sql_database_instance" "mysql" {
  name             = var.db_instance_name
  project          = var.project_id
  region           = var.region
  database_version = "MYSQL_8_0"

  settings {
    tier = var.db_tier

    ip_configuration {
      ipv4_enabled    = false
      private_network = var.vpc_self_link
    }

    backup_configuration {
      enabled                        = true
      binary_log_enabled             = true
      start_time                     = "03:00"
      transaction_log_retention_days = 7
    }

    maintenance_window {
      day  = 7
      hour = 3
    }
  }

  deletion_protection = false

  depends_on = [
    google_service_networking_connection.private_vpc_connection
  ]
}

# ----------------------------------------------------------------------
# Usuario inicial MySQL
# ----------------------------------------------------------------------
resource "google_sql_user" "main_user" {
  project  = var.project_id
  instance = google_sql_database_instance.mysql.name
  name     = var.db_user
  password = var.db_password
}
