###########################################
# Create APP and DB VPS
###########################################
variable app_image_id {}
variable db_image_id {}

#resource "random_string" "random_name_1" {
#  length  = 16
#  special = false
#}
#
#resource "openstack_compute_flavor_v2" "flavor-node" {
#  name      = "node.${var.project_id}-${random_string.random_name_1.result}"
#  ram       = "1024"
#  vcpus     = "1"
#  disk      = "0"
#  is_public = "false"
#}
#
#resource "openstack_compute_keypair_v2" "terraform_key" {
#  name       = "terraform_key-${random_string.random_name_1.result}"
#  region     = var.region
#  public_key = file("~/.ssh/id_rsa.pub")
#}

module "server_db" {
  source = "./create_server"

  network_id = openstack_networking_network_v2.network_1.id
  subnet_id  = openstack_networking_subnet_v2.subnet_1.id

  image_id    = var.db_image_id
  volume_type = var.volume_type
  az_zone     = var.az_zone
  flavor_id   = openstack_compute_flavor_v2.flavor-node.id
  key_pair_id = openstack_compute_keypair_v2.terraform_key.id
  fixed_ip    = "192.168.0.100"
}

module "server_app" {
  source = "./create_server"

  network_id = openstack_networking_network_v2.network_1.id
  subnet_id  = openstack_networking_subnet_v2.subnet_1.id

  image_id    = var.app_image_id
  volume_type = var.volume_type
  az_zone     = var.az_zone
  flavor_id   = openstack_compute_flavor_v2.flavor-node.id
  key_pair_id = openstack_compute_keypair_v2.terraform_key.id
  fixed_ip    = "192.168.0.101"
}

###################################
# Create floating IP
###################################
resource "openstack_networking_floatingip_v2" "floatingip_1" {
  pool = "external-network"
}

###################################
# Link floating IP to internal IP
###################################
resource "openstack_networking_floatingip_associate_v2" "association_1" {
  port_id     = module.server_app.app_port_id
  floating_ip = openstack_networking_floatingip_v2.floatingip_1.address
}
