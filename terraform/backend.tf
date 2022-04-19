terraform {


  backend "s3" {
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


/*

resource "yandex_storage_bucket" "othw9buck" {

  bucket     = "othw9buck"
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key

  acl = "public-read"


}
resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = "ajeddf805388f8dtfro9"
  description        = "static access key for object storage"
}

*/
