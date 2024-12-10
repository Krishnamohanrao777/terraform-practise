#Creation of  Resoure Group
resource "azurerm_resource_group" "RG" {
  name     = "Custom-RG"
  location = "Central India"
}

# Creation of Virtual Network
resource "azurerm_virtual_network" "vnet" {
name = "Custom-Vnet"
address_space = [ "10.0.0.0/16" ]
location = azurerm_resource_group.RG.location
resource_group_name = azurerm_resource_group.RG.name
}

#Creation of Subnet 
resource "azurerm_subnet" "sub" {
name = "Custom-Subnet"
resource_group_name = azurerm_resource_group.RG.name
virtual_network_name = azurerm_virtual_network.vnet.name
address_prefixes = [ "10.0.0.0/24" ]
}

#Creation of public IP address
resource "azurerm_public_ip" "Pub_ip" {
name = "Custom-pub_ip"
resource_group_name = azurerm_resource_group.RG.name
location = azurerm_resource_group.RG.location
allocation_method = "Dynamic"
}

#Creation of Network Interface
resource "azurerm_network_interface" "nic" {
  name = "custom-nic"
  location = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name
  ip_configuration {
    name = "custom-ip-conf"
    subnet_id = azurerm_subnet.sub.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.Pub_ip.id
  }
}

#Creation of Virtual Machine
resource "azurerm_virtual_machine" "name" {
  
}