# ----------------------------------------------------------------------
# Cloud Router
# ----------------------------------------------------------------------
resource "google_compute_router" "router" {
  name    = "${var.vpc_name}-router"
  project = var.project_id
  region  = var.region
  network = var.vpc_name
}

# ----------------------------------------------------------------------
# Cloud NAT
# ----------------------------------------------------------------------
resource "google_compute_router_nat" "nat" {
  name                               = "${var.vpc_name}-nat"
  project                            = var.project_id
  region                             = var.region
  router                             = google_compute_router.router.name

  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name                    = var.private_subnet_self_link
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

  enable_endpoint_independent_mapping = true
  min_ports_per_vm                     = 1024
}
