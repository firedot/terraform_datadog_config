# Define the provider that is going to be used

provider "google" {
  credentials = "${file("/home/test/creds.json")}"
  project     = "test-proj-241215"
  region      = "${var.google_region}"
}

# Define a random_pet provider that will generate names for server resources
resource "random_pet" "srv_name" {
  length = 1
  prefix = "srv"
}

# Define a random_pet provider that will generate names for other than server resources
resource "random_pet" "other_resource" {
  length = 2
  prefix = "other"
}

# Create the first Google Compute Instance

resource "google_compute_instance" "server_1" {
  name         = "${random_pet.srv_name.id}"
  machine_type = "n1-standard-1"
  zone         = "${var.google_zone}"
  tags         = ["first-macihne", "testing"]

  boot_disk = {
    initialize_params {
      image = "ubuntu-1810-cosmic-v20190514"
    }
  }

  network_interface {
    network = "${google_compute_network.srv_net_1.name}"

    access_config {
      #Ephemeral IP
    }
  }

  depends_on = ["google_compute_network.srv_net_1"]
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
