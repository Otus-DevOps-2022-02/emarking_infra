
provider "yandex" {
  service_account_key_file = var.service_acc_key
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone_id
}

data "terraform_remote_state" "vpc" {

  backend = "s3"
  config = {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "othw9buck"
    key        = "prod/terraform.tfstate"
    region     = "ru-central1"
    access_key = "test"
    secret_key = "test"

    skip_region_validation      = true
    skip_credentials_validation = true

  }

}

module "app" {

  source          = "../modules/app"
  public_key_path = var.public_key_path
  app_disk_image  = var.app_disk_image
  subnet_id       = var.subnet_id
  db_ip           = tostring("${module.db.external_ip_address_db[0]}")
  host            = module.app.external_ip_address_app[0]
  run_prv         = var.run_prv
  env_type        = var.env_type


}
module "db" {

  source          = "../modules/db"
  public_key_path = var.public_key_path
  db_disk_image   = var.db_disk_image
  subnet_id       = var.subnet_id
  host            = module.db.external_ip_address_db[0]
  run_prv         = var.run_prv
  env_type        = var.env_type
}
