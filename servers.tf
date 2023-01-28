
 resource "openstack_images_image_v2" "ubuntu" {
  name = "Ubuntu2004"
  image_source_url  = var.openstack_img
  container_format  = "bare"
  disk_format   = "qcow2"
 }

data "openstack_images_image_v2" "ubuntu" {
  name        = "Ubuntu2004"
  most_recent = true
}
data "openstack_compute_flavor_v2" "flavor" {
    name = "m1.large"
}

resource "openstack_compute_instance_v2" "server" {
  image_id = data.openstack_images_image_v2.ubuntu.id
  image_name = data.openstack_compute_instance_v2.ubuntu.name
  flavor_id = data.openstack_compute_flavor_v2.flavor.id
  key_pair  = var.keypair
  
  network {
    name = var.network
  }
  
  security_groups = [
    openstack_networking_secgroup_v2.administration.name,
    openstack_networking_secgroup_v2.servers.name,
    openstack_networking_secgroup_v2.internal.name,
  ]
}

resource "openstack_networking_floatingip_v2" "fip_1" {
  pool = "default"
}

resource "openstack_compute_floatingip_associate_v2" "fip_1" {
  floating_ip = "${openstack_networking_floatingip_v2.fip_1.address}"
  instance_id = "${openstack_compute_instance_v2.server.id}"
}

data "template_file" "ansible-install" {
  template = file("ansible-install.sh")
  depends_on = [openstack_compute_instance_v2.server]
  vars = {
    ece-server0 = openstack_compute_instance_v2.server.0.public_dns
    ece-server0-zone = openstack_compute_instance_v2.server.0.availability_zone
    ece-server1 = openstack_compute_instance_v2.server.1.public_dns
    ece-server1-zone = openstack_compute_instance_v2.server.1.availability_zone
    ece-server2 = openstack_compute_instance_v2.server.2.public_dns
    ece-server2-zone = openstack_compute_instance_v2.server.2.availability_zone

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