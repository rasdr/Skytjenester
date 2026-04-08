module "resource_group_1" {
	source = "./moduler/resgroup"
	ressurs_gruppe = var.ressurs_gruppe
	lokasjon = var.lokasjon
}

module "network" {
	source = "./moduler/network"
	ressurs_gruppe = var.ressurs_gruppe
	lokasjon = var.lokasjon
	vnet = var.vnet
	vnet_range = var.vnet_range
	subnet = var.subnet
	subnet_range = var.subnet_range
	pubipans = var.pubipans
	pubip2 = var.pubip2
	
	depends_on = [module.resource_group_1]
}

module "vms" {
	source = "./moduler/vms"
	ressurs_gruppe = var.ressurs_gruppe
	lokasjon = var.lokasjon
	vmnavn = var.vmnavn
	vmsize = var.vmsize
	admuser = var.admuser
	admpass = var.admpass
	nic01 = module.network.nic01
	nic02 = module.network.nic02
	
	depends_on = [module.network]
}

module "loadbal" {
	source = "./moduler/loadbal"
	ressurs_gruppe = var.ressurs_gruppe
	lokasjon = var.lokasjon
	pubip2 = var.pubip2
	loadbalancer = var.loadbalancer
	nic01 = module.network.nic01
	nic02 = module.network.nic02
	pubipid = module.network.pubipid
	
	depends_on = [module.network]
}