module "countdash" {
  source = "../.."
}

provider "vault" {
  address = "http://127.0.0.1:8200"
}