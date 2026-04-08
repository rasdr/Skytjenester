resource "azurerm_linux_virtual_machine" "vm1" {
	name = "${var.vmnavn}1"
	location = var.lokasjon
	resource_group_name = var.ressurs_gruppe
	network_interface_ids = [var.nic01]
	size = var.vmsize
	computer_name = "vm01"
	
	admin_username = var.admuser
	admin_password = var.admpass
	disable_password_authentication = false
	
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

resource "azurerm_linux_virtual_machine" "vm2" {
	name = "${var.vmnavn}2"
	location = var.lokasjon
	resource_group_name = var.ressurs_gruppe
	network_interface_ids = [var.nic02]
	size = var.vmsize
	computer_name = "vm02"
	
	admin_username = var.admuser
	admin_password = var.admpass
	disable_password_authentication = false
	
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
