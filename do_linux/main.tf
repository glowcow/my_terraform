resource "digitalocean_vpc" "vpc" {
  name   = "${var.drplt_name}-vpc"
  region = var.do_region
  ip_range = var.vpc_cidr
}

resource "digitalocean_droplet" "linux-do" {
  count = var.drplt_count
  image = var.drplt_image
  name = "${var.drplt_name}-${var.do_region}-n${count.index}"
  region = var.do_region
  size = var.drplt_size
  vpc_uuid = digitalocean_vpc.vpc.id
  ssh_keys = [data.digitalocean_ssh_key.terraform.id]

#  connection {
#    host = self.ipv4_address
#    user = "root"
#    type = "ssh"
#    private_key = file(var.pvt_key)
#    timeout = "2m"
#  }
#
#  provisioner "remote-exec" {
#    inline = [
#      "export PATH=$PATH:/usr/bin",
#      # install nginx
#      "sudo apt update",
#      "sudo apt install -y nginx"
#    ]
#  }
}

resource "digitalocean_firewall" "linux-do-fw" {
  name = "${var.do_region}-fw"
  droplet_ids = [for i in digitalocean_droplet.linux-do : i.id]
  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0"]
  }
  inbound_rule {
    protocol         = "icmp"
    source_addresses = ["0.0.0.0/0"]
  }
  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0"]
  }
  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0"]
  }
}
