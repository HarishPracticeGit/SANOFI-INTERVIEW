variable "vnet_name" {
  type        = string
  description = "Name of the Virtual Network"
}

variable "address_space" {
  type        = list(string)
  description = "The address space that is used by the virtual network."
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group in which to create the virtual network"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to apply to resources"
}

variable "subnets" {
  type = list(object({
    name             = string
    address_prefixes = list(string)
  }))
  description = "List of subnets"
  default     = []
}