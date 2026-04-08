resource "azurerm_virtual_network" "vnetwork_01" {
	name = var.vnet
	address_space = var.vnet_range
	location = var.lokasjon
	resource_group_name = var.ressurs_gruppe
}

resource "azurerm_subnet" "subnet_01" {
	name = var.subnet[0]
	resource_group_name = var.ressurs_gruppe
	virtual_network_name = azurerm_virtual_network.vnetwork_01.name
	address_prefixes = [var.subnet_range[0]]
}

resource "azurerm_public_ip" "public_ip_01" {
	name = var.pubip2
	location = var.lokasjon
	resource_group_name = var.ressurs_gruppe
	allocation_method = "Static"
}

resource "azurerm_network_security_group" "nsg_01" {
	name = "remdro_subnet_01_nsg"
	location = var.lokasjon
	resource_group_name = var.ressurs_gruppe
	
	security_rule {
		name = "Web"
		priority = 1080
		direction = "Inbound"
		access = "Allow"
		protocol = "Tcp"
		source_port_range = "*"
		destination_port_range = "80"
		source_address_prefix = "*"
		destination_address_prefix = var.subnet_range[0]
	}

	security_rule {
		name                       = "ssh"
		priority                   = 1001
		direction                  = "Inbound"
		access                     = "Allow"
		protocol                   = "Tcp"
		source_port_range          = "*"
		destination_port_range     = "22"
		source_address_prefix      = var.pubipans
		destination_address_prefix = var.subnet_range[0]
  }
}

resource "azurerm_subnet_network_security_group_association" "sub01_nsg01_asso" {
	subnet_id = azurerm_subnet.subnet_01.id
	network_security_group_id = azurerm_network_security_group.nsg_01.id
}

resource "azurerm_network_interface" "nic_01" {
	name = "remdro_nic_01"
	location = var.lokasjon
	resource_group_name = var.ressurs_gruppe
	
	ip_configuration {
		name = "remdro_nic_01_conf"
		subnet_id = azurerm_subnet.subnet_01.id
		private_ip_address_allocation = "Dynamic"
	}
}

resource "azurerm_network_interface" "nic_02" {
	name = "remdro_nic_02"
	location = var.lokasjon
	resource_group_name = var.ressurs_gruppe
	
	ip_configuration {
		name = "remdro_nic_02_conf"
		subnet_id = azurerm_subnet.subnet_01.id
		private_ip_address_allocation = "Dynamic"
	}
}