variable "lokasjon" {
	description = "Region"
	type = string
}

variable "ressurs_gruppe" {
	description = "Navn til ressursgruppe"
	type = string
}

variable "vnet" {
	description = "Navn på vnet"
	type = string
	
}

variable "vnet_range" {
	description = "IP range for vnet"
	type = list(string)
	
}

variable "subnet" {
	description = "Navn på subnets"
	type = list(string)
	
}

variable "subnet_range" {
	description = "IP ranges for subnet"
	type = list(string)
	
}

variable "pubip2" {
	description = "Navn på public IP"
	type = string
}