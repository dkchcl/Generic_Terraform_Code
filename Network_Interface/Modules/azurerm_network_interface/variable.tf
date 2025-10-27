variable "nics" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string

    vnet_key     = optional(string)
    subnet_index = optional(number)
    # List of IP configuration blocks for the NIC
    ip_configuration = list(object({
      name                                               = string
      subnet_id                                          = string # The ID of the subnet to which this IP config is attached
      private_ip_address_allocation                      = string
      private_ip_address_version                         = optional(string)
      public_ip_address_id                               = optional(string)
      gateway_load_balancer_frontend_ip_configuration_id = optional(string)
      primary                                            = optional(bool)
      private_ip_address                                 = optional(string)
    }))

    auxiliary_mode                 = optional(string)
    auxiliary_sku                  = optional(string)
    dns_servers                    = optional(list(string))
    edge_zone                      = optional(string)
    ip_forwarding_enabled          = optional(bool)
    accelerated_networking_enabled = optional(bool)
    internal_dns_name_label        = optional(string)
    tags                           = optional(map(string))
  }))
}

variable "subnet_ids" {
  type = map(list(string))
}













