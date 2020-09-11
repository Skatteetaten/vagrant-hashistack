module "countdash" {
  source = "../.."
}

provider "vault" {
  address = "http://127.0.0.1:8200"
}

terraform {
  required_providers {
    vault = {
      version = ">=2.13.0"
    }
    nomad = {
      version = ">=1.4.0"
    }
  }
}