provider "phpipam" {
  app_id   = "test"
  endpoint = "http://localhost/api"
  password = "12345678"
  username = "admin"
}

resource "phpipam_section" "section" {
  name = "test"
  description = "Testing section"
}

resource "phpipam_subnet" "subnet" {
  section_id = "${phpipam_section.section.section_id}"
  subnet_address = "10.10.3.0"
  subnet_mask = "24"
}

data "phpipam_first_free_subnet" "next_subnet" {
  master_subnet_id = "${phpipam_subnet.subnet.subnet_id}"
  subnet_mask = "29"
}

resource "phpipam_subnet" "child" {
  section_id = "${phpipam_section.section.section_id}"
  master_subnet_id = "${phpipam_subnet.subnet.subnet_id}"
  subnet_address = "${data.phpipam_first_free_subnet.next_subnet.subnet_address}"
  subnet_mask = "${data.phpipam_first_free_subnet.next_subnet.subnet_mask}"
  description = "Child subnet for master subnet id=${phpipam_subnet.subnet.subnet_id}"
}

output "subnet_id" {
  value = "${phpipam_subnet.subnet.subnet_id}"
}

output "child_subnet_id" {
  value = "${phpipam_subnet.child.subnet_id}"
}
