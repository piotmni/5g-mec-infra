# Register a job
#resource "nomad_job" "test" {
#  jobspec = file("${path.module}/templates/test.hcl")
#}

#resource "nomad_namespace" "namespace_de" {
#  name = "de1"
#}

resource "nomad_job" "basic-web-app" {
  jobspec = templatefile("${path.module}/templates/basic-web-app.hcl", {
    dc = var.dc
  })
}
