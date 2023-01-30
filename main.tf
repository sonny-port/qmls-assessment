terraform {
required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.49.0"
    }
  }
}

provider "openstack" {
}

 
resource "null_resource" "ansible-install" {
    provisioner "local-exec" {
        command = data.template_file.ansible-install.rendered
    }
}

output "ece-instances" {
   description = "The public dns of created server instances."
   value = [openstack_compute_instance_v2.*]
}

output "ece-ui-url" {
   value = format("https://%s:12443",openstack_compute_instance_v2.server0.name)
}

output "ece-api-url" {
   value = format("https://%s:12343",openstack_compute_instance_v2.server0.name)
}