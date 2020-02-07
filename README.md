# Terraform: openstack-srv_noportsec-count

This terraform-modules does basically the same as openstack-srv_noportsec. It creates a virtual-machine with port-security disabled. This module can be used when a counter is needed

# Configure

```
module "client_employees" {
	source = "git@git-service.ait.ac.at:sct-cyberrange/terraform-modules/openstack-srv_noportsec-count.git"
	hostname = "client_employee"
	host_capacity = 7
        image_id = "${var.client_image_id}"
        flavor = "${var.flavor}"
        sshkey = "${var.sshkey}"
        lannet_id = "${var.lannet_id}"
	userdatafile = "${path.module}/scripts/default.yml"
        volume_size = 20
}
```
