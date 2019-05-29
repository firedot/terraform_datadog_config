#variable "srv_name" {
#  description = "Defines the server name of the GCE VM instance"
#}
#
variable "network_name" {
  description = "Defines the name of the network that the server will use"
}

variable "instance_count" {
  description = "Defines the number of server instances to be created"
  default     = "1"
}

variable "google_zone" {
  description = "Defines the google zone in which the instances will be creat"
}
