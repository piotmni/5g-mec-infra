# Register a job
resource "nomad_job" "core-dns" {
  jobspec = templatefile("${path.module}/templates/core-dns.hcl", {
    dc = var.dc
  })
}
