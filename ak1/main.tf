terraform {
	required_providers {
		azurerm = {
			source = "hashicorp/azurerm"
			version = "=4.1.0"
		}
	}
}

provider "azurerm" {
	features {}
	subscription_id = "19c280ca-8596-4baa-8ef2-c835a0987300"
}

resource "azurerm_resource_group" "resource_group_1" {
	name = "remdro_rgroup_02"
	location = "Norway East"
}

resource "azurerm_virtual_network" "vnetwork_01" {
	name = "remdro_vnet_01"
	address_space = ["10.0.0.0/16"]
	location = azurerm_resource_group.resource_group_1.location
	resource_group_name = azurerm_resource_group.resource_group_1.name
}

resource "azurerm_subnet" "subnet_01" {
	name = "remdro_subnet_01"
	resource_group_name = azurerm_resource_group.resource_group_1.name
	virtual_network_name = azurerm_virtual_network.vnetwork_01.name
	address_prefixes = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "subnet_02" {
	name = "remdro_subnet_02"
	resource_group_name = azurerm_resource_group.resource_group_1.name
	virtual_network_name = azurerm_virtual_network.vnetwork_01.name
	address_prefixes = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "public_ip_01" {
	name = "remdro_pubip_01"
	location = azurerm_resource_group.resource_group_1.location
	resource_group_name = azurerm_resource_group.resource_group_1.name
	allocation_method = "Static"
}

resource "azurerm_network_security_group" "nsg_01" {
	name = "remdro_subnet_01_nsg"
	location = azurerm_resource_group.resource_group_1.location
	resource_group_name = azurerm_resource_group.resource_group_1.name
	
	security_rule {
		name = "SSH"
		priority = 1001
		direction = "Inbound"
		access = "Allow"
		protocol = "Tcp"
		source_port_range = "*"
		destination_port_range = "22"
		source_address_prefix = "*"
		destination_address_prefix = "*"
	}
}

resource "azurerm_network_security_group" "nsg_02" {
	name = "remdro_subnet_02_nsg"
	location = azurerm_resource_group.resource_group_1.location
	resource_group_name = azurerm_resource_group.resource_group_1.name
	
	security_rule {
		name = "SSH"
		priority = 1001
		direction = "Inbound"
		access = "Allow"
		protocol = "Tcp"
		source_port_range = "*"
		destination_port_range = "22"
		source_address_prefix = "10.0.1.0/24"
		destination_address_prefix = "10.0.2.0/24"
	}
}

resource "azurerm_network_interface" "nic_01" {
	name = "remdro_nic_01"
	location = azurerm_resource_group.resource_group_1.location
	resource_group_name = azurerm_resource_group.resource_group_1.name
	
	ip_configuration {
		name = "remdro_nic_01_conf"
		subnet_id = azurerm_subnet.subnet_01.id
		private_ip_address_allocation = "Dynamic"
		public_ip_address_id = azurerm_public_ip.public_ip_01.id
	}
}

resource "azurerm_network_interface" "nic_02" {
	name = "remdro_nic_02"
	location = azurerm_resource_group.resource_group_1.location
	resource_group_name = azurerm_resource_group.resource_group_1.name
	
	ip_configuration {
		name = "remdro_nic_02_conf"
		subnet_id = azurerm_subnet.subnet_02.id
		private_ip_address_allocation = "Dynamic"
	}
}

resource "azurerm_network_interface_security_group_association" "nic_01_nsg_01" {
	network_interface_id = azurerm_network_interface.nic_01.id
	network_security_group_id = azurerm_network_security_group.nsg_01.id
}

resource "azurerm_network_interface_security_group_association" "nic_02_nsg_02" {
	network_interface_id = azurerm_network_interface.nic_02.id
	network_security_group_id = azurerm_network_security_group.nsg_02.id
}

resource "azurerm_linux_virtual_machine" "vm_01" {
	name = "remdro_linux_01"
	location = azurerm_resource_group.resource_group_1.location
	resource_group_name = azurerm_resource_group.resource_group_1.name
	network_interface_ids = [azurerm_network_interface.nic_01.id]
	size = "Standard_B2ats_v2"
	admin_username = "adm01"
	computer_name = "vm01"
	
	os_disk {
		caching = "ReadWrite"
		storage_account_type = "Premium_LRS"
	}
	
	source_image_reference {
	publisher = "Canonical"
	offer = "ubuntu-24_04-lts"
	sku = "server"
	version = "latest"
	}
	
	admin_ssh_key {
		username = "adm01"
		public_key = file("C:\\Users\\NUCremdro\\Terraform\\ak1\\.ssh\\id_ed25519.pub")
	}
	
}

resource "azurerm_linux_virtual_machine" "vm_02" {
	name = "remdro_linux_02"
	location = azurerm_resource_group.resource_group_1.location
	resource_group_name = azurerm_resource_group.resource_group_1.name
	network_interface_ids = [azurerm_network_interface.nic_02.id]
	size = "Standard_B2ats_v2"
	admin_username = "adm02"
	admin_password = "PassordPassord123"
	disable_password_authentication = false
	computer_name = "vm02"
	
	os_disk {
		caching = "ReadWrite"
		storage_account_type = "Premium_LRS"
	}
	
	source_image_reference {
	publisher = "Canonical"
	offer = "ubuntu-24_04-lts"
	sku = "server"
	version = "latest"
	}
	
}
