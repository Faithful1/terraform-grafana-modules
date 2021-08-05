module "image" {
  source   = "./image"
  image_in = var.image[terraform.workspace] //this will access the key within the image map that corresponds to the workspace
}

module "container" {
  source            = "./container"
#   depends_on        = [null_resource.dockervol]
  count             = local.container_count
  name_in           = join("-", ["nodered", terraform.workspace, random_string.random[count.index].result])
  image_in          = module.image.image_out
  int_port_in       = var.int_port
  ext_port_in       = var.ext_port[terraform.workspace][count.index]
#   container_path_in = "/data"
#   host_path_in      = "${path.cwd}/noderedvol"
}

# generate random string
resource "random_string" "random" {
  count   = local.container_count
  length  = 4
  special = false
  upper   = false
}

# resource "null_resource" "dockervol" {
#   provisioner "local-exec" {
#     command = "mkdir noderedvol/ || true && sudo chown -R 1000:1000 noderedvol/"
#   }
# }

locals {
  container_count = length(var.ext_port[terraform.workspace])
  # container_count = length(lookup(var.ext_port, var.env))
}