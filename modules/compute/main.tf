# ----------------------------------------------------------------------
# Instance Template (Ubuntu 22.04 LTS)
# ----------------------------------------------------------------------
resource "google_compute_instance_template" "template" {
  name_prefix  = var.instance_name_prefix
  project      = var.project_id
  machine_type = var.machine_type
  region       = var.region

  tags = ["monolith-app"]

  disk {
    source_image = "projects/ubuntu-os-cloud/global/images/family/ubuntu-2204-lts"
    auto_delete  = true
    boot         = true
    disk_type    = "pd-balanced"
    disk_size_gb = 20
  }

  network_interface {
    subnetwork   = var.private_subnet_self_link
  }

  service_account {
    email  = var.service_account_email
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

# ----------------------------------------------------------------------
# Instance Group Manager (IGM)
# ----------------------------------------------------------------------
resource "google_compute_region_instance_group_manager" "igm" {
  name               = "${var.instance_name_prefix}-igm"
  project            = var.project_id
  region             = var.region
  base_instance_name = var.instance_name_prefix

  version {
    instance_template = google_compute_instance_template.template.self_link
  }

  target_size = var.min_replicas

  lifecycle {
    create_before_destroy = true
  }
}

# ----------------------------------------------------------------------
# Autoscaling sin scripts, basado SOLO en CPU
# ----------------------------------------------------------------------
resource "google_compute_region_autoscaler" "autoscaler" {
  name    = "${var.instance_name_prefix}-autoscaler"
  project = var.project_id
  region  = var.region
  target  = google_compute_region_instance_group_manager.igm.self_link

  autoscaling_policy {
    min_replicas = var.min_replicas
    max_replicas = var.max_replicas

    cpu_utilization {
      target = var.cpu_target / 100
    }

    cooldown_period = 60
  }
}
