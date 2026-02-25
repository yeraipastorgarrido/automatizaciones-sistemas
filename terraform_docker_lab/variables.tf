variable "vsphere_user" {
    description = "Usuario de vSphere"
    type        = string
    }

variable "vsphere_password" {
    description = "Contraseña de vSphere"
    type        = string
    sensitive   = true
}

variable "puerto_externo" {
    description = "Puerto para el contenedor de Nginx"
    type        = number
    default     = 8081
}

variable "vm_user" {
    description = "Usuario de inicio de sesión de la VM"
    type        = string
}

variable "vm_password" {
    description = "Contraseña de inicio de sesión de la VM"
    type        = string
    sensitive   = true
}