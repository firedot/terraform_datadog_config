# Define the provider that is going to be used

provider "google" {
  credentials = "${file("/home/test/creds.json")}"
  project     = "test-proj-241215"
  region      = "${var.google_region}"
}

# Use the basic_server module

module "basic_server" {
  source = "./modules/"

  network_name   = "${google_compute_network.srv_net_1.name}"
  google_zone    = "${var.google_zone}"
  instance_count = "4"
}

# Define a random_pet provider that will generate names for other than server resources
resource "random_pet" "other_resource" {
  length = 2
  prefix = "other"
}

resource "google_compute_network" "srv_net_1" {
  name                    = "${random_pet.other_resource.id}"
  auto_create_subnetworks = true
}

resource "google_compute_firewall" "firewall-1" {
  name    = "${random_pet.other_resource.id}"
  network = "${google_compute_network.srv_net_1.name}"

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "22"]
  }
}
