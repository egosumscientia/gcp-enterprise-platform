resource "google_compute_route" "default_internet" {
  name        = "route-default-internet"
  network     = var.vpc_name
  dest_range  = "0.0.0.0/0"
  next_hop_gateway = "default-internet-gateway"
  priority    = 1000
}
