# ----------------------------------------------------------------------
# Health Check
# ----------------------------------------------------------------------
resource "google_compute_health_check" "hc" {
  name    = "${var.lb_name}-hc"
  project = var.project_id

  http_health_check {
    port = 80
  }

  timeout_sec        = 5
  check_interval_sec = 5
}

# ----------------------------------------------------------------------
# Backend Service GLOBAL apuntando al IGM regional
# ----------------------------------------------------------------------
resource "google_compute_backend_service" "backend" {
  name                  = "${var.lb_name}-backend"
  project               = var.project_id
  protocol              = "HTTP"
  timeout_sec           = 30
  health_checks         = [google_compute_health_check.hc.self_link]
  load_balancing_scheme = "EXTERNAL_MANAGED"

  backend {
    group = "projects/${var.project_id}/regions/${var.region}/instanceGroups/${var.instance_group_name}"
  }
}

# ----------------------------------------------------------------------
# URL MAP
# ----------------------------------------------------------------------
resource "google_compute_url_map" "url_map" {
  name    = "${var.lb_name}-urlmap"
  project = var.project_id
  default_service = google_compute_backend_service.backend.self_link
}

# ----------------------------------------------------------------------
# Target HTTP Proxy
# ----------------------------------------------------------------------
resource "google_compute_target_http_proxy" "proxy" {
  name       = "${var.lb_name}-http-proxy"
  project    = var.project_id
  url_map    = google_compute_url_map.url_map.self_link
}

# ----------------------------------------------------------------------
# Forwarding Rule GLOBAL HTTP (puerto 80)
# ----------------------------------------------------------------------
resource "google_compute_global_forwarding_rule" "http" {
  name       = "${var.lb_name}-http-rule"
  project    = var.project_id
  target     = google_compute_target_http_proxy.proxy.self_link
  port_range = "80"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  ip_protocol = "TCP"
}
