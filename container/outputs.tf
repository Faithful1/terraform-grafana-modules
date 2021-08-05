# output the IP address of the container
output "container-name" {
  value       = docker_container.nodered_container[*].name
  description = "The name of the nodered container"
}

output "container-ip-address" {
  value       = [for i in docker_container.nodered_container[*] : join(":", [i.ip_address], i.ports[*]["external"])]
  description = "The ip address of the container"
}
