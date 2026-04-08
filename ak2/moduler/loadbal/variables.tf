variable "lokasjon" {
	description = "Region"
	type = string
}

variable "ressurs_gruppe" {
	description = "Navn til ressursgruppe"
	type = string
}

variable "pubip2" {
	description = "Navn på public IP"
	type = string
}

variable "pubipid" {
	description = "ID til public IP"
	type = string
}

variable "nic01" {
	description = "ID for NIC 1"
	type = string
}

variable "nic02" {
	description = "ID for NIC 2"
	type = string
}

variable "loadbalancer" {
	description = "Navn på load balancer"
	type = string
	
}