provider "yandex" {
  service_account_key_file = var.service_acc_key
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone_id
}

resource "yandex_compute_instance" "app" {
  name        = "reddit-app-${count.index}"
  platform_id = "standard-v3"
  count       = var.inst_count

  resources {
    cores         = 2
    memory        = 4
    core_fraction = 20

  }
  scheduling_policy {
    preemptible = true
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
    }
  }
  network_interface {
    nat       = true
    subnet_id = var.subnet_id

  }

  provisioner "file" {
    source      = "files/puma.service"
    destination = "/tmp/puma.service"

  }
  provisioner "remote-exec" {
    script = "files/deploy.sh"

  }
  connection {
    type        = "ssh"
    host        = self.network_interface.0.nat_ip_address
    agent       = false
    user        = "ubuntu"
    private_key = file("~/.ssh/admin")
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }

}
