# Terraform: terraform-openstack-srv_noportsec-count

This terraform-modules does basically the same as openstack-srv_noportsec. It creates a virtual-machine with port-security disabled. This module can be used when a counter is needed

# Configure

## Simple Config
```
module "client_employees" {
	source = "git@github.com:ait-cs-IaaS/terraform-openstack-srv_noportsec-count.git"
	hostname = "client_employee"
	host_capacity = 7
  image_id = var.client_image_id
  flavor = var.flavor
  sshkey = var.sshkey
  network = var.network
  subnet = var.subnet
	userdatafile = "${path.module}/scripts/default.yml"
  volume_size = 20
}
```

## Sequential assign fixed IPs within subnet
```
module "client_employees" {
	source = "git@github.com:ait-cs-IaaS/terraform-openstack-srv_noportsec-count.git"
	hostname = "client_employee"
	host_capacity = 7
  image_id = var.client_image_id
  flavor = var.flavor
  sshkey = var.sshkey
  network = var.network
  subnet = var.subnet
  host_address_start_index = 120 # starts assigning IP addresses from the 120th host address of the subnet
	userdatafile = "${path.module}/scripts/default.yml"
  volume_size = 20
}
```