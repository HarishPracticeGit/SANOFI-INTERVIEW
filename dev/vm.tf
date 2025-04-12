# creating virtual machine
module "dev-vm1" {
  source              = "../modules/compute"
  vm_name             = "vm-east-1"
  location            = "East US"
  resource_group_name = "sanofi-dev-rg"
  subnet_id           = module.dev_vnet_east.subnet_ids["dev-subnet1"] # If you expose subnet_ids as output
  admin_username      = data.azurerm_key_vault_secret.admin_username.value
  admin_password      = data.azurerm_key_vault_secret.admin_password.value
  create_public_ip    = true
  tags = {
    environment = "dev"
  }
}

# creating virtual machine
module "dev-vm2" {
  source              = "../modules/compute"
  vm_name             = "vm-west-1"
  location            = "West US"
  resource_group_name = "sanofi-dev-rg"
  subnet_id           = module.Dev_vnet_west.subnet_ids["dev-backend"]
  admin_username      = data.azurerm_key_vault_secret.admin_username.value
  admin_password      = data.azurerm_key_vault_secret.admin_password.value
  create_public_ip    = true
  tags = {
    environment = "dev"
  }
}