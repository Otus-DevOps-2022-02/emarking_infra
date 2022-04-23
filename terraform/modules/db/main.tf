resource "yandex_compute_instance" "db" {
  name        = "reddit-db-${count.index}-${var.env_type}"
  platform_id = "standard-v3"
  count       = var.inst_count
  labels = {
    "tags" = "reddit-db"
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
      image_id = var.db_disk_image
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

resource "null_resource" "db" {
  count = var.run_prv ? 1 : 0

  #triggers = {

  # db_instance_id = var.inst_count

  #}
  connection {
    type        = "ssh"
    host        = var.host
    agent       = false
    user        = "ubuntu"
    private_key = ${file(var.public_key_path)}
  }

  provisioner "remote-exec" {

    inline = [
      "sudo sed 's/bindIp: 127.0.0.1/bindIp: 0.0.0.0/g' /etc/mongod.conf | sudo tee /etc/mongod.conf",
      "sudo systemctl  restart mongod"
    ]

  }
}
