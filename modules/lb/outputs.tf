output "backend_service" {
  value = google_compute_backend_service.backend.self_link
}

output "health_check" {
  value = google_compute_health_check.hc.self_link
}

output "forwarding_rule" {
  value = google_compute_global_forwarding_rule.http.self_link
}
