module "traefik-waw1" {
  source = "../modules/traefik"
  dc = "waw1"
}

module "traefik-bhs5" {
  source = "../modules/traefik"
  dc = "bhs5"
}

module "traefik-de1" {
  source = "../modules/traefik"
  dc = "de1"
}