
resource "nomad_job" "traefik" {
  jobspec = templatefile("${path.module}/templates/traefik.hcl", {
    dc = var.dc
  })
}
resource "nomad_job" "test" {
  jobspec = templatefile("${path.module}/templates/test.hcl", {
    dc = var.dc
  })
}
