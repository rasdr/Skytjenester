variable "subid" {
	description = ""
	type = string
	default = "19c280ca-8596-4baa-8ef2-c835a0987300"
}

variable "lokasjon" {
	description = "Region"
	type = string
	default = "Norway East"
}

variable "ressurs_gruppe" {
	description = "Navn til ressursgruppe"
	type = string
	default = "remdro_rgroup_02"
}

variable "vnet" {
	description = "Navn på vnet"
	type = string
	default = "remdro_vnet_01"
	
}

variable "vnet_range" {
	description = "IP range for vnet"
	type = list(string)
	default = ["10.10.0.0/16"]
	
}

variable "subnet" {
	description = "Navn på subnets"
	type = list(string)
	default = ["remdro_subnet_serv", "remdro_subnet_dc", "remdro_subnet_cli", "remdro_subnet_dmz", "remdro_subnet_mgmt", "remdro_subnet_adm"]
	
}

variable "subnet_range" {
	description = "IP ranges for subnet"
	type = list(string)
	default = ["10.10.10.0/24", "10.10.11.0/24", "10.10.20.0/24", "10.10.30.0/24", "10.10.99.0/24", "10.10.100.0/24"]
	
}

variable "pubip2" {
	description = "Navn på public IP"
	type = string
	default = "remdro_pubip_01"
}

variable "vmnavn" {
	description = "Navn på VM"
	type = string
	default = "remdro_linux_0"
}

variable "vmsize" {
	description = "Størrelse på VM"
	type = string
	default = "Standard_B2ats_v2"
}

variable "admuser" {
	description = "Adminbruker"
	type = string
	default = "admrem"
}

variable "admpass" {
	description = "Passord til vm-er"
	type = string
	default = "PassordPassord123"
}


/*
variable "" {
	description = ""
	type = string
	default = ""
	
}
*/