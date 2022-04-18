
output "external_ip_address_app" {

  value = module.app.external_ip_address_app

}


output "external_ip_address_db" {

  value = module.db.external_ip_address_db

}
#output "lb_ip_address_app" {

# value = yandex_lb_network_load_balancer.lb-l1.listener.*.external_address_spec[0].*.address

#}
