variable "lokasjon" {
	description = "Region"
	type = string
}

variable "ressurs_gruppe" {
	description = "Navn til ressursgruppe"
	type = string
}

variable "vmnavn" {
	description = "Navn på VM"
	type = string
}

variable "vmsize" {
	description = "Størrelse på VM"
	type = string
}

variable "admuser" {
	description = "Adminbruker"
	type = string
}

variable "admpass" {
	description = "Passord til vm-er"
	type = string
}

variable "nic01" {
	description = "ID til NIC 1"
	type = string
}