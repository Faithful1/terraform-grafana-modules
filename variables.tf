# variable "env" {
#   type        = string
#   default     = "dev"
#   description = "Env to deploy to"
# }

variable "image" {
  type = map(any)
  default = {
    dev  = "nodered/node-red:latest"
    prod = "nodered/node-red:latest-minimal"
  }
  description = "image for container"
}

variable "ext_port" {
  type = map

  validation {
    condition     = max(var.ext_port["dev"]...) <= 65535 && min(var.ext_port["dev"]...) >= 1980
    error_message = "The external port must be valid port range 0 - 65535."
  }

  validation {
    condition     = max(var.ext_port["prod"]...) < 1980 && min(var.ext_port["prod"]...) >= 1880
    error_message = "The external port must be valid port range 0 - 65535."
  }
}

locals {
  container_count = length(var.ext_port[terraform.workspace])
  # container_count = length(lookup(var.ext_port, var.env))
}

variable "int_port" {
  type = number

  # validation {
  #   condition = var.int_port == 1880
  #   error_message = "The internal port must be 1880."
  # }
}
