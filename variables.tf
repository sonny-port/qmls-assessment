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

variable "gateway_address" {
  description = "IP of gateway to public"
  default = "172.31.6.1"
}

# Path to your public key, which will be used to log in to ece instances
variable "public_key" {
  default = "~/.ssh/id_rsa.pub"
}

# Path to your private key that matches your public from ^^
variable "private_key" {
  default = "~/.ssh/id_rsa"
}

variable "ece-version" {
  default = "2.4.3"
}

variable "sleep-timeout" {
  default="30"
}

variable "remote_user" {
  # default = "centos"
  # For ubuntu, uncomment this
  default = "ubuntu"
}
variable "device_name" {
  default="nvme0n1"
}