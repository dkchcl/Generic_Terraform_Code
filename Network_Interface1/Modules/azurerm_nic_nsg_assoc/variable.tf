variable "nic_ids" {
  description = "List of NIC IDs"
  type        = list(string)
}

variable "nsg_ids" {
  description = "NSG ID to associate"
  type        = map(string)
}

