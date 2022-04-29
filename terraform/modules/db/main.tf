terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

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


#Provisioning
# resource "null_resource" "db" {

#   count = var.inst_count



#   #count = var.run_prv ? 1 : 0


#   connection {
#     type = "ssh"
#     host = yandex_compute_instance.db[count.index].network_interface.0.nat_ip_address
#     #host        = var.db_ssh_host
#     agent       = false
#     user        = "ubuntu"
#     private_key = file("/root/.ssh/admin")
#   }

#   provisioner "remote-exec" {

#     inline = [
#       "sudo sed -i 's/bindIp: 127.0.0.1/bindIp: 0.0.0.0/g' /etc/mongod.conf",
#       "sudo systemctl  restart mongod"
#     ]

#   }
#   depends_on = [
#     yandex_compute_instance.db
#   ]
# }

locals {

  instance_ips_db_st = yandex_compute_instance.db[*].network_interface.0.nat_ip_address
  instance_na_db_st  = yandex_compute_instance.db[*].name
}

resource "local_file" "get_inst_data_stage" {

  content = templatefile("./instdb.tpl", {

    instance_names_db_st = local.instance_na_db_st,
    ips_db_st            = local.instance_ips_db_st,
    app_name             = "reddit-"
    envt                 = var.env_type

  })

  filename = "../stage/inst_db_st.tpl"

  provisioner "local-exec" {

    when       = destroy
    command    = "mv ../stage/inst_db_st.tpl ../stage/inst_db_st.tpl.back | mv ../stage/inst_all_st.tpl ../stage/inst_all_st.tpl.back"
    on_failure = continue

  }

  provisioner "local-exec" {
    when = create

    command = "touch ../stage/inst_all_st.tpl | cat ../stage/inst_db_st.tpl | tee -a ../stage/inst_all_st.tpl"

    on_failure = continue

  }

}
