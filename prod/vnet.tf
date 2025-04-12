# creating virtual network and subnetworks
module "prod_vnet_east" {
  source              = "../modules/network"
  vnet_name           = "vnet-east-prod"
  address_space       = ["10.10.0.0/16"]
  location            = "East US"
  resource_group_name = "sanofi-prod-rg"
  tags = {
    environment = "prod"
  }
  subnets = [
    {
      name             = "prod-subnet1"
      address_prefixes = ["10.10.1.0/24"]
    },
    {
      name             = "prod-subnet2"
      address_prefixes = ["10.10.2.0/24"]
      service_endpoints = ["Microsoft.Storage"]
    }
  ]
}