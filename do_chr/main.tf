resource "digitalocean_custom_image" "chr_img" {
  name   = "tf-chr-${var.chr_ver}.vdi"
  url = "https://download.mikrotik.com/routeros/${var.chr_ver}/chr-${var.chr_ver}.vdi"
  regions = [var.do_region]
}

resource "digitalocean_vpc" "vpc" {
  name   = "${var.drplt_name}-vpc"
  region = var.do_region
  ip_range = var.vpc_cidr
}

resource "digitalocean_droplet" "chr-do" {
  image = digitalocean_custom_image.chr_img.id
  name = "${var.drplt_name}-${var.do_region}"
  region = var.do_region
  size = var.drplt_size
  vpc_uuid = digitalocean_vpc.vpc.id
  ssh_keys = [data.digitalocean_ssh_key.terraform.id]
}

resource "digitalocean_firewall" "chr-do-fw" {
  name = "${var.do_region}-fw"
  droplet_ids = [digitalocean_droplet.chr-do.id]
  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0"]
  }
  inbound_rule {
    protocol         = "tcp"
    port_range       = "8291"
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
