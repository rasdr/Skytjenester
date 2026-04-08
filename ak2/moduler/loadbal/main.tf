resource "azurerm_lb" "loadbalancer" {
  name                = var.loadbalancer
  location            = var.lokasjon
  resource_group_name = var.ressurs_gruppe
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = var.pubip2
    public_ip_address_id = var.pubipid
  }
}

resource "azurerm_lb_backend_address_pool" "lb_backend" {
  loadbalancer_id = azurerm_lb.loadbalancer.id
  name            = "backend_01"
}

resource "azurerm_network_interface_backend_address_pool_association" "lb_backend_asso1" {
  ip_configuration_name   = "remdro_nic_01_conf"
  network_interface_id    = var.nic01
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb_backend.id
}

resource "azurerm_network_interface_backend_address_pool_association" "lb_backend_asso2" {
  ip_configuration_name   = "remdro_nic_02_conf"
  network_interface_id    = var.nic02
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb_backend.id
}

/*
resource "azurerm_network_interface_backend_address_pool_association" "lb_backend_asso" {
  count                   = 2
  ip_configuration_name   = "remdro_nic_0${count.index + 1}_conf"
  network_interface_id    = "var.nic0${count.index + 1}"
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb_backend.id
}
*/

resource "azurerm_lb_probe" "lb_probe" {
  loadbalancer_id = azurerm_lb.loadbalancer.id
  name            = "healthprobe_01"
  port            = 80
}

resource "azurerm_lb_rule" "lb_rule" {
  loadbalancer_id                = azurerm_lb.loadbalancer.id
  name                           = "webrule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  disable_outbound_snat          = true
  frontend_ip_configuration_name = var.pubip2
  probe_id                       = azurerm_lb_probe.lb_probe.id
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.lb_backend.id]
}

resource "azurerm_lb_outbound_rule" "lb_outbound" {
  name                    = "outbound_01"
  loadbalancer_id         = azurerm_lb.loadbalancer.id
  protocol                = "Tcp"
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb_backend.id

  frontend_ip_configuration {
    name = var.pubip2
  }
}