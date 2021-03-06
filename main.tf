locals {
  # create addtional network dictionary for each host instance and assign the fixed ip if `host_address_start_index` is set for the network
  additional_networks = [
    for count in range(0, var.host_capacity) :
    {
      for name, additional_network in var.additional_networks : name => {
        network            = additional_network.network
        subnet             = additional_network.subnet
        host_address_index = additional_network.host_address_start_index != null ? additional_network.host_address_start_index + count : null
      }
    }
  ]
  networks = [
    for count in range(0, var.host_capacity) :
    {
      for name, net in var.networks : name => {
        network            = net.network
        subnet             = net.subnet
        access             = net.access
        host_address_index = net.host_address_start_index != null ? net.host_address_start_index + count : null
      }
    }
  ]
}

module "server" {
  source              = "git@github.com:ait-cs-IaaS/terraform-openstack-srv_noportsec.git?ref=v1.5.0"
  count               = var.host_capacity
  hostname            = "${var.hostname}_${var.host_label_start_index + count.index}"
  tag                 = var.tag != null ? "${var.hostname},${var.tag}" : var.hostname
  metadata            = var.metadata
  host_address_index  = var.host_address_start_index != null ? var.host_address_start_index + count.index : null
  image               = var.image
  flavor              = var.flavor
  config_drive        = var.config_drive
  sshkey              = var.sshkey
  network             = var.network
  subnet              = var.subnet
  additional_networks = local.additional_networks[count.index]
  networks            = local.networks[count.index]
  userdatafile        = var.userdatafile
  userdata_vars       = var.userdata_vars
  volume_size         = var.volume_size
  use_volume          = var.use_volume
  network_access      = var.network_access
}
