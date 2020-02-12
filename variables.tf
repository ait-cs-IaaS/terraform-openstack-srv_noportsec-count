variable "image_id" {
	type = string
	description = "image-id to boot the hosts from"
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

variable "lannet_id" {
	type = string
	description = "Local network"
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


