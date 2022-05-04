terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
    local = {
      source = "hashicorp/local"
    }
  }
}



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

#Provisioning
# resource "null_resource" "app" {
#   #   #count = var.run_prv ? 1 : 0

#   count = var.inst_count
#   connection {
#     type        = "ssh"
#     host        = yandex_compute_instance.app[count.index].network_interface.0.nat_ip_address
#     agent       = false
#     user        = "ubuntu"
#     private_key = file("/home/eugene/.ssh/admin")
#   }

#   #   provisioner "file" {
#   #     source      = "/home/teraf1/modules/app/files/puma.service"
#   #     destination = "/tmp/puma.service"

#   #   }
#   provisioner "remote-exec" {
#     script = "../modules/app/files/deploy.sh"

#   }

#   # provisioner "remote-exec" {
#   #   inline = [
#   #     #       "sudo sed -i 's/Environment=/Environment=DATABASE_URL= ${element(tolist("${var.db_ip}"), count.index)}:27017/g' /tmp/puma.service",
#   #     #       #"sudo sed -i 's/Environment=/Environment=DATABASE_URL=${element("${module.db[*].external_ip_address_db[0]}", count.index)}:27017/g' /tmp/puma.service",
#   #     #       #"sudo sed -i 's/Environment=/Environment=DATABASE_URL=${module.db[count.index].external_ip_address_db[0]}:27017/g' /tmp/puma.service",
#   #     #       "sudo mv /tmp/puma.service /etc/systemd/system/puma.service",
#   #     "sudo systemctl daemon-reload",
#   #     "sudo systemctl start puma",
#   #     "sudo systemctl enable puma"
#   #     #       #"echo ${join(" ", element("${var.db_ip}", count.index))})"


#   #   ]

#   # }
#   # depends_on = [
#   #   yandex_compute_instance.app
#   # ]
# }

locals {

  instance_ips_app_st = yandex_compute_instance.app[*].network_interface.0.nat_ip_address
  instance_na_app_st  = yandex_compute_instance.app[*].name
  instance_env_type   = var.env_type
}

resource "local_file" "get_inst_data_stage" {

  content = templatefile("./instapp.tpl", {

    instance_names_app_st = local.instance_na_app_st,
    ips_app_st            = local.instance_ips_app_st,
    app_name              = "reddit-"
    envt                  = var.env_type


  })

  filename = "../${var.env_type}/inst_app_${var.env_type}"




}

resource "null_resource" "templates" {

  triggers = {

    env_type = var.env_type
  }


  provisioner "local-exec" {

    when       = destroy
    command    = "mv ../${self.triggers.env_type}/inst_app_${self.triggers.env_type} ../${self.triggers.env_type}/inst_app_${self.triggers.env_type}.back | mv ../${self.triggers.env_type}/inst_all_${self.triggers.env_type} ../${self.triggers.env_type}/inst_all_${self.triggers.env_type}.back"
    on_failure = continue

  }
  provisioner "local-exec" {
    when = create

    command = "touch ../${self.triggers.env_type}/inst_all_${self.triggers.env_type} | cat ../${self.triggers.env_type}/inst_app_${self.triggers.env_type} | tee -a ../${self.triggers.env_type}/inst_all_${self.triggers.env_type}"

    on_failure = continue

  }


}
