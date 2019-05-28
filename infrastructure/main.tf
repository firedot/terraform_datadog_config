# Define the provider that is going to be used

provider "google" {
  credentials = "${file("/home/test/creds.json")}"
  project     = "test-proj-241215"
  region      = "${var.google_region}"
}

# Define a random_pet provider that will generate names for server resources
resource "random_pet" "srv_name" {
  length = 4
  prefix = "srv-"
}

# Define a random_pet provider that will generate names for other than server resources
resource "random_pet" "other_resource" {
  length = 10
  prefix = "other-"
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
    network = "default"
  }
}
