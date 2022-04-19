resource "yandex_lb_network_load_balancer" "lb-l1" {
  name = "lb-1"
  type = "external"

  listener {
    name        = "lbs"
    port        = 80
    target_port = 9292

    external_address_spec {

      ip_version = "ipv4"

    }
  }
  attached_target_group {
    target_group_id = yandex_lb_target_group.tg-lb1.id


    healthcheck {
      name = "hz1"

      http_options {

        port = 9292
        path = "/"
      }
    }
  }
}

resource "yandex_lb_target_group" "tg-lb1" {
  name = "tg-1"

  target {

    address   = yandex_compute_instance.app[0].network_interface.0.ip_address
    subnet_id = var.subnet_id
  }
  target {

    address   = yandex_compute_instance.app[1].network_interface.0.ip_address
    subnet_id = var.subnet_id
  }


}
