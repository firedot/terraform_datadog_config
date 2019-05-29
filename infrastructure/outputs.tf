#output "google_compute_instance server_1 name " {
#  value = "${module.basic_server.server_1.name}"
#}
#
output "google_compute_instance server_1  External_IP" {
  value = "${module.basic_server.server_ephemeral_IP}"
}
