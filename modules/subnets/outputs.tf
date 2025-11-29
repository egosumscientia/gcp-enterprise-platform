output "subnet_names" {
  value = [
    google_compute_subnetwork.public_a.name,
    google_compute_subnetwork.public_b.name,
    google_compute_subnetwork.private_a.name,
    google_compute_subnetwork.private_b.name
  ]
}
