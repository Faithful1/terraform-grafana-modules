# output the IP address of the container
output "container-ip-address" {
  value       = module.container[*].container-ip-address
  description = "The ip address of the container"
}

output "container-name" {
  value       = flatten(module.container[*].container-name)
  description = "The name of the nodered container"
}


