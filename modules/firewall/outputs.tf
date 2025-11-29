output "iap_rule_name" {
  value = google_compute_firewall.allow_iap_ssh.name
}

output "lb_rule_name" {
  value = google_compute_firewall.allow_lb_http_https.name
}

output "internal_rule_name" {
  value = google_compute_firewall.allow_internal.name
}

output "egress_rule_name" {
  value = google_compute_firewall.allow_egress.name
}
