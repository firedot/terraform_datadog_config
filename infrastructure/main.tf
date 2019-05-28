# Define the provider that is going to be used

provider "google" {
credentials = "${file(/home/test/creds.json)}"
project = "test-proj-241215"
region = "${var.google_region}"
}

resource "random_pet" "srv_name" {
length = 4
prefix = "srv-"
}

resource "random_pet" "other_resource" {
length = 10
prefix = "other-"
}


