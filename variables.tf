variable "image" {
	type = string
	description = "name of the image to boot the hosts from"
}

variable "flavor" {
	type = string
	description = "instance flavor for the server"
	default = "m1.small"
}

variable "sshkey" {
	type = string
	description = "ssh key for the server"
	default = "cyberrange-key"
}

variable "network" {
	type = string
	description = "Name of the local network"
}

variable "host_capacity" {
	type = number
	description = "Capacity of host-instances"
	default = 1
}

variable "host_start_index" {
	type = number
	description = "Start index for labeling instances"
	default = 0
}

variable "userdatafile" {
	type = string
	description = "path to userdata file"
}

variable "userdata_vars" {
	type = map(string)
	description = "variables for the userdata template"
	default = {}
}

variable "hostname" {
	type = string
	description = "hostname"
}

variable "volume_size" {
	type = string
	description = "volume_size"
	default = 5
}

variable "tag" {
	type = string
	description = "group tag"
	default = null
}


