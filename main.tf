terraform {
    required_version = ">=1.2"
}

resource "null_resource" "ansible-install" {
    provisioner "local-exec" {
        command = data.template_file.ansible-install.rendered
    }
}

output "ece-instances" {
   description = "The public dns of created server instances."
   value = [openstack_compute_instance_v2.server.*.public_dns]
}

output "ece-ui-url" {
   value = format("https://%s:12443",openstack_compute_instance_v2.server.0.public_dns)
}

output "ece-api-url" {
   value = format("https://%s:12343",openstack_compute_instance_v2.server.0.public_dns)
}