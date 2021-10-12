variable "vnets" {
  type = map(object({
    name          = string
    location = string
    resource_group_name = string
    dns_servers = list(string)
    address_space = list(string)
    subnets = map(object({
      name           = string
      address_prefix = string
    }))
  }))
  description = "This variable must be called and assigned data at root directory main.tf"
}