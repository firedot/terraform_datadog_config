output "google_compute_instance server_1 name " {
  value = "${google_compute_instance.server_1.name}"
}

output "google_compute_instance server_1  External_IP" {
  value = "${google_compute_instance.server_1.network_interface.0.access_config.0.nat_ip}"
}
