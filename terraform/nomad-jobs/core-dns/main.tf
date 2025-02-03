

module "core-dns-waw1" {
  source = "../modules/core-dns"
  dc = "waw1"
}

module "core-dns-bhs5" {
  source = "../modules/core-dns"
  dc = "bhs5"
}

module "core-dns-de1" {
  source = "../modules/core-dns"
  dc = "de1"
}