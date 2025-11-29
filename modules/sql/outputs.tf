output "instance_connection_name" {
  description = "Nombre de conexión a Cloud SQL"
  value       = google_sql_database_instance.mysql.connection_name
}

output "private_ip" {
  description = "IP privada de la instancia Cloud SQL"
  value       = google_sql_database_instance.mysql.private_ip_address
}

output "mysql_instance_name" {
  description = "Nombre de la instancia MySQL"
  value       = google_sql_database_instance.mysql.name
}
