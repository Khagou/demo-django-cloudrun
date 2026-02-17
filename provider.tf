
Homepage
Primary navigation
Project

    S
    SYSTEMU

    Issues
    0
    Merge requests
    0

    wse-gdc-cds-cloud-lille
    GCP
    SYSTEMU

    systemu
    provider.tf

provider.tf
Maxence VERDOM's avatar
export variables avec file
Maxence VERDOM authored 4 months ago
6476f678
provider.tf
1.02 KiB

/**
 * Copyright 2022 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
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

