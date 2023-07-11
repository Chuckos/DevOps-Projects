# Code to spin up a new GCP compute

# Create a new GCP compute instance

resource "google_compute_instance" "vm_instance" {
  name         = var.GCP_VM_NAME
  machine_type = var.GCP_MACHINE_TYPE
  zone         = var.GCP_ZONE

  boot_disk {
    initialize_params {
      image = var.GCP_IMAGE
    }
  }

  network_interface {
    network = var.GCP_NETWORK
    access_config {
    }
  }
}
```




