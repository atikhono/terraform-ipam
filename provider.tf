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

resource "phpipam_child_subnet" "child" {
  subnet_id = "${phpipam_subnet.subnet.subnet_id}"
  child_subnet_mask = "29"
  child_subnet_description = "Test child subnet"
}

output "subnet_id" {
  value = "${phpipam_subnet.subnet.subnet_id}"
}

output "child_subnet_id" {
  value = "${phpipam_child_subnet.child.subnet_id}"
}
