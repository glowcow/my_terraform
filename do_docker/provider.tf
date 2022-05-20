terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
  backend "s3" {
    bucket         = "asediuk-tfstate-bucket"
    dynamodb_table = "asediuk-tfstate-lock"
    key            = "do_tf_state/docker.tfstate"
    region         = "eu-west-2"
    encrypt        = "true"
  }
}

provider "digitalocean" {
  token = var.do_token
}

data "digitalocean_ssh_key" "terraform" {
  name = "tf_ssh_key"
}
