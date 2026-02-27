# --- DATA SOURCES (LECTURA) ---
data "vsphere_datacenter" "dc" {
  name = "Inmatic"
}

data "vsphere_compute_cluster" "cluster" {
  name          = "Clúster ESXI's Inmatic"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "datastore" {
  name          = "datastore2 (1)"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = "VM Network"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = "PlantillaGitRunner"
  datacenter_id = data.vsphere_datacenter.dc.id
}

# --- RECURSO DE MÁQUINA VIRTUAL (WORKERS) ---
resource "vsphere_virtual_machine" "vm_automatizada" {
  count            = 3
  name             = "VM-Terraform-Yerai-Worker-${count.index + 1}"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = 2
  memory   = 4096
  guest_id = data.vsphere_virtual_machine.template.guest_id
  firmware = "efi"

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }

  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.template.disks.0.size
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    linked_clone  = true

    customize {
      linux_options {
        host_name = "worker-${count.index + 1}"
        domain    = "lab.local"
      }
      network_interface {
        # Asigna IPs secuenciales: 192.168.68.201, .202, .203
        ipv4_address = "192.168.68.${201 + count.index}"
        ipv4_netmask = 24
      }
      ipv4_gateway    = "192.168.68.1"
      dns_server_list = ["8.8.8.8"]
    }
  }

  wait_for_guest_ip_timeout = 5

  provisioner "local-exec" {
    command = <<-EOT
      sleep 30 && \
      export ANSIBLE_HOST_KEY_CHECKING=False && \
      ansible-playbook -i '${self.default_ip_address},' -u inmatic \
      -e 'ansible_password="Inmatic2025!" ansible_become_password="Inmatic2025!"' \
      ../ansible_lab/get_vmware_ready.yml
    EOT
  }
}

# --- VM BALANCEADORA (Nginx + Grafana + Prometheus) ---
resource "vsphere_virtual_machine" "load_balancer" {
  depends_on = [vsphere_virtual_machine.vm_automatizada]

  name             = "VM-LB-Nginx"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = 2
  memory   = 4096
  guest_id = data.vsphere_virtual_machine.template.guest_id
  firmware = "efi"

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }

  disk {
    label            = "disk0"
    size             = 200
    thin_provisioned = true
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    linked_clone  = true

    # Hemos añadido customize aquí para fijar la IP del balanceador
    customize {
      linux_options {
        host_name = "loadbalancer"
        domain    = "lab.local"
      }
      network_interface {
        ipv4_address = "192.168.68.200"
        ipv4_netmask = 24
      }
      ipv4_gateway    = "192.168.68.1"
      dns_server_list = ["8.8.8.8"]
    }
  }

  wait_for_guest_ip_timeout = 5

  provisioner "local-exec" {
    command = <<-EOT
      sleep 40 && \
      export ANSIBLE_HOST_KEY_CHECKING=False && \
      ansible-playbook -i '${self.default_ip_address},' -u inmatic \
      -e 'ansible_password="Inmatic2025!" ansible_become_password="Inmatic2025!"' \
      -e 'worker_ips=${join(",", vsphere_virtual_machine.vm_automatizada[*].default_ip_address)}' \
      ../ansible_lab/get_vmware_ready.yml
    EOT
  }
}