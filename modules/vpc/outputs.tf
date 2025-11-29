output "vpc_name" {
  value = google_compute_network.vpc.name
}

output "vpc_self_link" {
  value = google_compute_network.vpc.self_link
}

output "public_subnet" {
  value = google_compute_subnetwork.public_subnet.self_link
}

output "private_subnet" {
  value = google_compute_subnetwork.private_subnet.self_link
}

output "public_subnet_self_link" {
  value = google_compute_subnetwork.public_subnet.self_link
}

output "private_subnet_self_link" {
  value = google_compute_subnetwork.private_subnet.self_link
}
