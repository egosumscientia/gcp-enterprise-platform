# ----------------------------------------------------------------------
# SSH SOLO vía IAP (Identity-Aware Proxy)
# ----------------------------------------------------------------------
resource "google_compute_firewall" "allow_iap_ssh" {
  name    = "${var.vpc_name}-allow-iap-ssh"
  project = var.project_id
  network = var.vpc_name

  direction = "INGRESS"
  priority  = 1000

  source_ranges = ["35.235.240.0/20"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  description = "Permite SSH únicamente desde Identity-Aware Proxy"
}

# ----------------------------------------------------------------------
# HTTP/HTTPS SOLO desde Load Balancer Global
# ----------------------------------------------------------------------
resource "google_compute_firewall" "allow_lb_http_https" {
  name    = "${var.vpc_name}-allow-lb-http-https"
  project = var.project_id
  network = var.vpc_name

  direction = "INGRESS"
  priority  = 1000

  source_ranges = [
    "130.211.0.0/22",
    "35.191.0.0/16"
  ]

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  description = "Permite solo HTTP/HTTPS desde el Load Balancer"
}

# ----------------------------------------------------------------------
# Permitir tráfico interno dentro de la VPC (aplicación <-> SQL)
# ----------------------------------------------------------------------
resource "google_compute_firewall" "allow_internal" {
  name    = "${var.vpc_name}-allow-internal"
  project = var.project_id
  network = var.vpc_name

  direction = "INGRESS"
  priority  = 1000

  source_ranges = [
    "10.10.1.0/24",
    "10.10.2.0/24"
  ]

  allow {
    protocol = "all"
  }

  description = "Permite tráfico interno entre subredes privadas"
}

# ----------------------------------------------------------------------
# EGRESS: Permitir salida a cualquier destino (para apt-get, logs, NAT)
# ----------------------------------------------------------------------
resource "google_compute_firewall" "allow_egress" {
  name    = "${var.vpc_name}-allow-egress"
  project = var.project_id
  network = var.vpc_name

  direction = "EGRESS"
  priority  = 1000

  destination_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "all"
  }

  description = "Permite salida a internet por NAT"
}
