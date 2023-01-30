data "openstack_compute_flavor_v2" "flavor" {
    name = var.flavor
}

resource "openstack_compute_instance_v2" "server0" {
  name  = "server0"
  image_id = var.openstack_img
  flavor_name = data.openstack_compute_flavor_v2.flavor.name
  key_pair  = var.keypair
  
  network {
    name = var.network
  }
  
  security_groups = [
    openstack_compute_secgroup_v2.administration.name,
    openstack_compute_secgroup_v2.servers.name,
    openstack_compute_secgroup_v2.internal.name,
  ]
  tags = [
    "managed-by = terraform"
  ]
}

resource "openstack_compute_instance_v2" "server1" {
  name  = "server1"
  image_id = var.openstack_img
  flavor_name = data.openstack_compute_flavor_v2.flavor.name
  key_pair  = var.keypair
  
  network {
    name = var.network
  }
  
  security_groups = [
    openstack_compute_secgroup_v2.administration.name,
    openstack_compute_secgroup_v2.servers.name,
    openstack_compute_secgroup_v2.internal.name,
  ]
  tags = [
    "managed-by = terraform"
  ]
}

resource "openstack_compute_instance_v2" "server2" {
  name  = "server2"
  image_id = var.openstack_img
  flavor_name = data.openstack_compute_flavor_v2.flavor.name
  key_pair  = var.keypair
  
  network {
    name = var.network
  }
  
  security_groups = [
    openstack_compute_secgroup_v2.administration.name,
    openstack_compute_secgroup_v2.servers.name,
    openstack_compute_secgroup_v2.internal.name,
  ]
  tags = [
    "managed-by = terraform"
  ]
}
/*
resource "openstack_networking_floatingip_v2" "fip_1" {
  pool = "default"
}
#
resource "openstack_compute_floatingip_associate_v2" "fip_1" {
  floating_ip = "${openstack_networking_floatingip_v2.fip_1.address}"
  instance_id = "${openstack_compute_instance_v2.server.id}"
}
*/

data "template_file" "ansible-install" {
  template = file("ansible-install.sh")
  depends_on = [openstack_compute_instance_v2.server0,openstack_compute_instance_v2.server1,openstack_compute_instance_v2.server2]
  vars = {
    ece-server0 = "${openstack_compute_instance_v2.server0.name}"
    ece-server0-zone = "nova"
    ece-server1 = "${openstack_compute_instance_v2.server1.name}"
    ece-server1-zone = "nova"
    ece-server2 = "${openstack_compute_instance_v2.server2.name}"
    ece-server2-zone = "nova"

    # Keys to server
    key = var.private_key

    # Server Device Name
    device = var.device_name

    # User to login
    user = var.remote_user

    # Ece version to install
    ece-version = var.ece-version

    # Sleep timeout waiting for cloud provider instances
    sleep-timeout = var.sleep-timeout
  }
}