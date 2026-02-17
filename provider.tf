terraform {
  
  backend "gcs" {
    bucket                      = "gc-fr-<CODE_PROJET>-tfstate-01"
    prefix                      = "<ENV>/terraform.tfstate"
    impersonate_service_account = "<SA_NAME>"
  }
}
provider "google" {
  #credentials = file(var.credentials)
  region      = var.organization.region
}
provider "google-beta" {
  impersonate_service_account = "<SA_NAME>"
}
# end provider.tf for bootstrap