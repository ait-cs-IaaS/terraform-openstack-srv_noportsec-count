terraform {
  backend "consul" {}
}

data "openstack_networking_subnet_v2" "subnet" {
  name = var.subnet
}

module "server" {
  source = "git@git-service.ait.ac.at:sct-cyberrange/terraform-modules/openstack-srv_noportsec.git?ref=v1.2" 
  count = var.host_capacity
  hostname = "${var.hostname}_${var.host_label_start_index+count.index}"
	tag = var.tag != null ? "${var.hostname},${var.tag}" : var.hostname
	ip_address = var.host_address_start_index != null ? cidrhost(data.openstack_networking_subnet_v2.subnet.cidr, var.host_address_start_index+count.index) : null
	image = var.image
	flavor = var.flavor 
	sshkey = var.sshkey
	network = var.network
	subnet = var.subnet
  additional_networks = var.additional_networks
	userdatafile = var.userdatafile
  userdata_vars = var.userdata_vars
  volume_size = var.volume_size
  
}
