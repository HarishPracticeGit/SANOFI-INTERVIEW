# creating virtual machine
module "prod-vm2" {
  source              = "../modules/compute"
  vm_name             = "vm-east-1"
  location            = "East US"
  resource_group_name = "sanofi-prod-rg"
  subnet_id           = module.prod_vnet_east.subnet_ids["prod-subnet2"]
  admin_username      = data.azurerm_key_vault_secret.admin_username.value
  admin_password      = data.azurerm_key_vault_secret.admin_password.value
  create_public_ip    = true
  tags = {
    environment = "prod"
  }
}