resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  project                 = var.project_id
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
}

# ---------------------------
# Subred pública
# ---------------------------
resource "google_compute_subnetwork" "public_subnet" {
  name                  = "${var.vpc_name}-public-subnet"
  project               = var.project_id
  region                = var.region
  ip_cidr_range         = var.public_subnet_cidr
  network               = google_compute_network.vpc.self_link
  private_ip_google_access = true   # acceso interno a APIs Google
}

# ---------------------------
# Subred privada
# ---------------------------
resource "google_compute_subnetwork" "private_subnet" {
  name                  = "${var.vpc_name}-private-subnet"
  project               = var.project_id
  region                = var.region
  ip_cidr_range         = var.private_subnet_cidr
  network               = google_compute_network.vpc.self_link
  private_ip_google_access = true
}

# -------------------------------------------------------------------
# Rutas internas (no incluye NAT; NAT se agrega desde módulo NAT)
# -------------------------------------------------------------------
resource "google_compute_route" "private_to_public" {
  name           = "${var.vpc_name}-private-to-public"
  project        = var.project_id
  network        = google_compute_network.vpc.name
  dest_range     = var.public_subnet_cidr
  next_hop_gateway = "default-internet-gateway"
  priority       = 1000
}

