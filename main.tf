provider "openstack" {
}

terraform {
  backend "consul" {}
}

data "template_file" "user_data" {
  template = "${file("${var.userdatafile}")}"
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
  name               = "${var.hostname}_${count.index}"
  flavor_name        = "${var.flavor}"
  key_pair           = "${var.sshkey}"
  count              = "${var.host_capacity}"

  user_data = data.template_cloudinit_config.cloudinit.rendered

  metadata = {
    groups = "${var.hostname}_${count.index}"
  }

  block_device {
    uuid                  = "${var.image_id}"
    source_type           = "image"
    volume_size           = "${var.volume_size}"
    boot_index            = 0
    destination_type      = "volume"
    delete_on_termination = true
  }

  network {
     port = "${element(openstack_networking_port_v2.srvport.*.id, count.index)}"
  }
}

resource "openstack_networking_port_v2" "srvport" {
  name           = "${var.hostname}_${count.index}-port"
  count              = "${var.host_capacity}"
  admin_state_up = "true"
  no_security_groups = true
  port_security_enabled = false

  network_id = "${var.lannet_id}"
}


