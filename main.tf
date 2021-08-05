locals {
  deployment = {
    nodered = {
      container_count = length(var.ext_port["nodered"][terraform.workspace])
      image           = var.image["nodered"][terraform.workspace]
      int             = 1880
      ext             = var.ext_port["nodered"][terraform.workspace]
      container_path  = "/data"
    }
    influxdb = {
     container_count = length(var.ext_port["influxdb"][terraform.workspace])
      image          = var.image["influxdb"][terraform.workspace]
      int            = 8086
      ext            = var.ext_port["influxdb"][terraform.workspace]
      container_path = "/var/lib/influxdb"
    }
  }
}

module "image" {
  source   = "./image"
  for_each = local.deployment
  image_in = each.value.image //this will access the key within the image map that corresponds to the workspace
}

module "container" {
  source            = "./container"
  for_each          = local.deployment
  count_in          = each.value.container_count
  name_in           = each.key
  image_in          = module.image[each.key].image_out
  int_port_in       = each.value.int
  ext_port_in       = each.value.ext
  container_path_in = each.value.container_path
  #   count             = local.container_count // cant use count where there is for_each
  #   ext_port_in       = var.ext_port[terraform.workspace][count.index]
}