provider "openstack" {
}

terraform {
  backend "consul" {}
}

data "openstack_networking_network_v2" "lannet" {
  name = var.lannet
}

data "openstack_images_image_v2" "image" {
  name        = var.image
  most_recent = true
}

data "template_file" "user_data" {
  template = file(var.userdatafile)
}

data "template_cloudinit_config" "cloudinit" {
  gzip          = false
  base64_encode = false

  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = data.template_file.user_data.rendered
  }
}

resource "openstack_compute_instance_v2" "host" {
  name               = "${var.hostname}_${var.host_start_index+count.index}"
  flavor_name        = var.flavor
  key_pair           = var.sshkey
  count              = var.host_capacity

  user_data = data.template_cloudinit_config.cloudinit.rendered

  metadata = {
    groups =  var.tag != null ? var.tag : "${var.hostname}_${var.host_start_index+count.index}"
  }

  block_device {
    uuid                  = data.openstack_images_image_v2.image.id
    source_type           = "image"
    volume_size           = var.volume_size
    boot_index            = 0
    destination_type      = "volume"
    delete_on_termination = true
  }

  network {
     port = element(openstack_networking_port_v2.srvport.*.id, var.host_start_index+count.index)
  }
}

resource "openstack_networking_port_v2" "srvport" {
  name           = "${var.hostname}_${var.host_start_index+count.index}-port"
  count              = var.host_capacity
  admin_state_up = "true"
  no_security_groups = true
  port_security_enabled = false

  network_id = data.openstack_networking_network_v2.lannet.id
}


