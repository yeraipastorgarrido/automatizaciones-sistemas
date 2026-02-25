terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
    vsphere = {
      source  = "vmware/vsphere"
      version = "~> 2.4.3"
    }
  }
}

provider "docker" {}

provider "vsphere" {
  user                 = var.vsphere_user
  password             = var.vsphere_password
  vsphere_server       = "192.168.68.81"
  allow_unverified_ssl = true
}