/*
resource "openstack_networking_network_v2" "default" {
  name           = "default"
  admin_state_up = "true"
}
 
resource "openstack_networking_router_v2" "ig" {
  name           = "ig"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "subnetA" {
  name       = "subnetA"
  network_id = "${openstack_networking_network_v2.default.id}"
  cidr       = var.cidr
  ip_version = 4
}

resource "openstack_networking_router_interface_v2" "internet" {
  router_id = "${openstack_networking_router_v2.ig.id}"
  subnet_id = "${openstack_networking_subnet_v2.subnetA.id}"
}

resource "openstack_networking_router_route_v2" "default" {
  depends_on       = ["openstack_networking_router_interface_v2.internet"]
  router_id        = "${openstack_networking_router_v2.ig.id}"
  destination_cidr = "0.0.0.0/0"
  next_hop         = var.gateway_address
}
*/

resource "openstack_compute_secgroup_v2" "administration" {
  name        = "administration"
  description = "administration SG"

  rule {
    from_port   = 22
    to_port     = 22
    ip_protocol    = "tcp"
    cidr = "172.31.6.0/23"
  }

  rule {
    from_port   = 12443
    to_port     = 12443
    ip_protocol    = "tcp"
    cidr = "172.31.6.0/23"
  }

  rule {
    from_port   = 12343
    to_port     = 12343
    ip_protocol    = "tcp"
    cidr = "172.31.6.0/23"
  }
}

resource "openstack_compute_secgroup_v2" "servers" {
  name        = "servers"
  description = "server SG"

  rule {
    from_port   = 9243
    to_port     = 9243
    ip_protocol    = "tcp"
    cidr = "0.0.0.0/0"
  }

  rule {
    from_port   = 9343
    to_port     = 9343
    ip_protocol    = "tcp"
    cidr = "0.0.0.0/0"
  }

  rule {
    ip_protocol = -1
    from_port   = 0
    to_port     = 0
    cidr = "0.0.0.0/0"
  }

}

resource "openstack_compute_secgroup_v2" "internal" {
  name        = "internal"
  description = "internal network SG"

    rule {
    ip_protocol  = -1
    from_port = 0
    to_port   = 0
    self      = true
  }
}