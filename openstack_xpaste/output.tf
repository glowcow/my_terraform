output "network_id" {
  value = openstack_networking_floatingip_v2.address.id
}

#output "server_external_ip" {
#  value = openstack_networking_floatingip_v2.floatingip_1.address
#}
