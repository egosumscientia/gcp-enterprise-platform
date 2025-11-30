# ----------------------------------------------------------------------
# Bastion Host con IP pública
# ----------------------------------------------------------------------

resource "google_compute_instance" "bastion" {
  name         = var.bastion_name
  project      = var.project_id
  zone         = var.zone
  machine_type = "e2-medium"

  tags = ["bastion"]

  # Imagen base Ubuntu 22.04 LTS
  boot_disk {
    initialize_params {
      image = "projects/ubuntu-os-cloud/global/images/family/ubuntu-2204-lts"
      size  = 20
      type  = "pd-balanced"
    }
  }

  # Interfaz de red CON IP pública efímera
  network_interface {
    subnetwork = var.subnet_self_link

    # Este bloque crea la IP pública automáticamente
    access_config {}
  }

  # Service Account con permisos mínimos
  service_account {
    email  = var.service_account_email
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  # Startup script mínimo (opcional)
  metadata_startup_script = <<-EOF
    #!/bin/bash
    apt-get update -y
    apt-get install -y htop curl
  EOF

  # Habilitar logs, monitoring y serial port (útil para IAP)
  metadata = {
    enable-oslogin     = "TRUE"
    serial-port-enable = "TRUE"
  }
}
