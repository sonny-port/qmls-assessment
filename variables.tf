variable "openstack_img" {
  default = "0bae0560-acd3-4d3b-91ec-0d53d6c5b9a4"
}

variable "flavor" {
  default = "m1.large"
}

variable "keypair" {
  default = "RoselioViray-keypair"
}

variable "zones" {
  type    = list(string)
  default = ["a", "b", "c"]
}

variable "network" {
  type = string
  default = "1fc8c38e-ed79-4f39-a9c3-f8e928bff876"
}

variable "security_groups" {
  type = list(string)
  default = ["default"]
}

variable "cidr" {
  default = "172.31.6.0/23"
}

variable "trusted_networks" {
  type = list
  description = "CIDR formatted IP (<IP Address>/32) or network that will be allowed access (you can use 0.0.0.0/0 for unrestricted access)"
  default = ["172.31.8.0/23", "172.31.6.0/23", "172.31.0.0/23"]
}

variable "gateway_address" {
  description = "IP of gateway to public"
  default = "172.31.6.1"
}