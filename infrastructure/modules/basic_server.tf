# Define a random_pet provider that will generate names for other than server resources
resource "random_pet" "srv_resource" {
  length = 1
  prefix = "srv"
}

resource "google_compute_instance" "server" {
  name         = "${random_pet.srv_resource.id}-${count.index}"
  machine_type = "n1-standard-1"
  zone         = "${var.google_zone}"
  tags         = ["first-machine", "testing"]

  provisioner "file" {
    source      = "./scripts/datadog_install.sh"
    destination = "/tmp/datadog_install.sh"

    connection {
      type        = "ssh"
      user        = "root"
      private_key = "${file("/root/.ssh/gcp_key")}"
    }
  }

  provisioner "remote-exec" {
    inline = ["bash /tmp/datadog_install.sh"]
  }

  connection {
    type        = "ssh"
    user        = "root"
    private_key = "${file("/root/.ssh/gcp_key")}"
  }

  boot_disk = {
    initialize_params {
      image = "ubuntu-1810-cosmic-v20190514"
    }
  }

  network_interface {
    network = "${var.network_name}"

    access_config {
      #Ephemeral IP
    }
  }

  count = "${var.instance_count}"
}
