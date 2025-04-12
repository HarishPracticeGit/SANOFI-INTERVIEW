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

module "prod_vnet_east2" {
  source              = "../modules/network"
  vnet_name           = "vnet1-east-prod"
  address_space       = ["10.50.0.0/16"]
  location            = "East US"
  resource_group_name = "sanofi-prod-rg"
  tags = {
    environment = "prod"
  }
  subnets = [
    {
      name             = "prod1-subnet1"
      address_prefixes = ["10.50.1.0/24"]
    },
    {
      name             = "prod2-subnet2"
      address_prefixes = ["10.50.2.0/24"]
      service_endpoints = ["Microsoft.Storage"]
    }
  ]
}