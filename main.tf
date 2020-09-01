terraform {
  backend "consul" {}
}

data "openstack_networking_subnet_v2" "subnet" {
  name = var.subnet
}
# fetch the subnet info for all additional networks for which a fixed ip address block should be used
data "openstack_networking_subnet_v2" "additional_subnets" {
  for_each = {for name, additional_network in var.additional_networks:  name => additional_network if additional_network.host_address_start_index != null}
  name = each.value.subnet
}

locals {
  # create addtional network dictionary for each host instance and assign the fixed ip if `host_address_start_index` is set for the network
  additional_networks = [
        for count in range(0, var.host_capacity) :
        {
          for name, additional_network in var.additional_networks : name => {
              network = additional_network.network
              subnet = additional_network.subnet
              ip_address = additional_network.host_address_start_index != null ? cidrhost(data.openstack_networking_subnet_v2.additional_subnets[name].cidr, additional_network.host_address_start_index+count) : null
            }
        }
      ]
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
  additional_networks = local.additional_networks[count.index]
	userdatafile = var.userdatafile
  userdata_vars = var.userdata_vars
  volume_size = var.volume_size
  
}
