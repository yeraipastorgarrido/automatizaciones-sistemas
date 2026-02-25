# --- DATA SOURCES (LECTURA) ---
data "vsphere_datacenter" "dc" {
  name = "Inmatic" #
}

data "vsphere_compute_cluster" "cluster" {
  name          = "Clúster ESXI's Inmatic" #
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "datastore" {
  name          = "datastore2 (1)" #
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = "VM Network" 
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = "PlantillaDev"
  datacenter_id = data.vsphere_datacenter.dc.id
}

# --- RESOURCES (CREACIÓN) ---
resource "vsphere_virtual_machine" "vm_automatizada" {
  name             = "VM-Terraform-Yerai"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = data.vsphere_virtual_machine.template.num_cpus
  memory   = data.vsphere_virtual_machine.template.memory 
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
  }

  # --- EL BLOQUE VA AQUÍ (DENTRO DEL RESOURCE) ---

  # Espera a que la VM arranque y reporte su IP al vCenter
  wait_for_guest_ip_timeout = 2 

  provisioner "local-exec" {
    # Usamos tus variables de secretos y el nombre correcto del playbook
    command = "export ANSIBLE_HOST_KEY_CHECKING=False && ansible-playbook -i '${self.default_ip_address},' -u ${var.vm_user} -e 'ansible_password=${var.vm_password} ansible_become_password=${var.vm_password}' ../ansible_lab/get_vmware_ready.yml"
  }
} # <-- Esta es la llave que cierra el resource