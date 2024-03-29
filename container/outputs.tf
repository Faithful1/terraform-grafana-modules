# # output the IP address of the container
# output "container-ip-address" {
#   value       = [for i in docker_container.app_container[*] : join(":", [i.ip_address], i.ports[*]["external"])]
#   description = "The ip address of the container"
# }

# output "container-name" {
#   value       = docker_container.app_container[*].name
#   description = "The name of the nodered container"
# }

output "application_access" {
  value = { for x in docker_container.app_container[*] : x.name => join(":", [x.ip_address], x.ports[*]["external"]) }
}