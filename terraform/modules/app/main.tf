resource "yandex_compute_instance" "app" {
  name        = "reddit-app-${count.index}-${var.env_type}"
  platform_id = "standard-v3"
  count       = var.inst_count
  labels = {
    "tags" = "reddit-app"
  }

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
      image_id = var.app_disk_image
    }
  }
  network_interface {
    nat       = true
    subnet_id = var.subnet_id
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }

}
resource "null_resource" "app" {
  count = var.run_prv ? 1 : 0


  connection {
    type        = "ssh"
    host        = var.host
    agent       = false
    user        = "ubuntu"
    private_key = file("~/.ssh/appuser")
  }

  provisioner "file" {
    source      = "../modules/app/files/puma.service"
    destination = "/tmp/puma.service"

  }
  provisioner "remote-exec" {
    script = "../modules/app/files/deploy.sh"

  }
  provisioner "remote-exec" {
    inline = [
      "sudo sed 's/Environment=/Environment=DATABASE_URL=${var.db_ip}:27017/g' /etc/systemd/system/puma.service | sudo tee /etc/systemd/system/puma.service",
      "sleep 10",
      "sudo systemctl daemon-reload",
      "sudo systemctl restart puma"

    ]

  }

}
