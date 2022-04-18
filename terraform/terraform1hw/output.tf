
output "external_ip_address_app" {

  value = yandex_compute_instance.app[*].network_interface.0.nat_ip_address

}


output "lb_ip_address_app" {

  value = yandex_lb_network_load_balancer.lb-l1.listener.*.external_address_spec[0].*.address

}
