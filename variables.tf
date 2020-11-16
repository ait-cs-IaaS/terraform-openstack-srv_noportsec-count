variable "image" {
  type        = string
  description = "name of the image to boot the hosts from"
}

variable "flavor" {
  type        = string
  description = "instance flavor for the server"
  default     = "m1.small"
}

variable "volume_size" {
  type        = string
  description = "volume_size"
  default     = 5
}

variable "config_drive" {
  type        = bool
  description = "Use a config drive to load initial configuration instead of using the network based metadata service"
  default     = false
}

variable "sshkey" {
  type        = string
  description = "ssh key for the server"
  default     = "cyberrange-key"
}

variable "network" {
  type        = string
  description = "Name of the local network"
}

variable "additional_networks" {
  type = map(
    object({
      network                  = string
      subnet                   = string
      host_address_start_index = number
    })
  )
  description = "Additional networks instances should be connected to"
  default     = {}
}

variable "subnet" {
  type        = string
  description = "Name of the local sub-net"
}

variable "host_address_start_index" {
  type        = number
  description = "The host address index within the subnet to start sequentially assigning ip addresses from"
  default     = null
}

variable "host_capacity" {
  type        = number
  description = "Capacity of host-instances"
  default     = 1
}

variable "host_label_start_index" {
  type        = number
  description = "Start index for labeling instances"
  default     = 0
}

variable "userdatafile" {
  type        = string
  description = "path to userdata file"
  default     = null
}

variable "userdata_vars" {
  type        = map(string)
  description = "variables for the userdata template"
  default     = {}
}

variable "hostname" {
  type        = string
  description = "base hostname also used as group tag"
}

variable "tag" {
  type        = string
  description = "group tag"
  default     = null
}

variable "use_volume" {
  type        = bool
  description = "If the a volume or a local file should be used for storage"
  default     = false
}
