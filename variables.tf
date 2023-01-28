variable "openstack_img" {
    default = "https://cloud-images.ubuntu.com/releases/22.04/release/ubuntu-22.04-server-cloudimg-amd64.img"
}

variable "public_key" {
  default = "~/.ssh/id_rsa.pub"
}

variable "private_key" {
  default = "~/.ssh/id_rsa"
}

variable "keypair" {
  default = "root"
}

variable "network" {
  type = string
  default = "default"
}

variable "security_groups" {
  type = list(string)
  default = ["default"]
}

variable "cidr" {
  default = "192.168.100.0/24"
}

variable "trusted_networks" {
    description = "CIDR formatted IP (<IP Address>/32) or network that will be allowed access (you can use 0.0.0.0/0 for unrestricted access)"
}

variable "gateway_address" {
    description = "IP of gateway to public"
}