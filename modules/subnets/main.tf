resource "google_compute_subnetwork" "public_a" {
  name          = "subnet-public-a"
  ip_cidr_range = "10.0.1.0/24"
  region        = "us-central1"
  network       = var.vpc_name
}

resource "google_compute_subnetwork" "public_b" {
  name          = "subnet-public-b"
  ip_cidr_range = "10.0.2.0/24"
  region        = "us-central1"
  network       = var.vpc_name
}

resource "google_compute_subnetwork" "private_a" {
  name          = "subnet-private-a"
  ip_cidr_range = "10.0.10.0/24"
  region        = "us-central1"
  network       = var.vpc_name
  private_ip_google_access = true
}

resource "google_compute_subnetwork" "private_b" {
  name          = "subnet-private-b"
  ip_cidr_range = "10.0.11.0/24"
  region        = "us-central1"
  network       = var.vpc_name
  private_ip_google_access = true
}
