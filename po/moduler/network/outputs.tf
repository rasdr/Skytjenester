output "nic01" {
	description = "ID for NIC 1"
	value = azurerm_network_interface.nic_01.id
}

output "pubipid" {
	description = "ID for public IP"
	value = azurerm_public_ip.public_ip_01.id
}