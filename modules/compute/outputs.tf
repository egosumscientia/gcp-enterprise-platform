output "instance_template" {
  value = google_compute_instance_template.template.self_link
}

output "instance_group" {
  value = google_compute_region_instance_group_manager.igm.self_link
}

output "instance_group_name" {
  value = google_compute_region_instance_group_manager.igm.name
}
