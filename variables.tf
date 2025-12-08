# Global Terraform variables for this project

variable "deploy_efk" {
  type        = bool
  default     = false
  description = "Deploy EFK logging stack"
}

variable "environment" {
  type        = string
  description = "Environment short name (dev, stage, prod)"
}

locals {
  app_name = "flixtube-${var.environment}"
}

# Default vm_size can be overridden, but changes based on deploy_efk if user doesn't specify
variable "vm_size" {
  type = string
  default = ""
}

locals {
  computed_vm_size = (
    var.vm_size != "" ?
    var.vm_size :
    (var.deploy_efk ? "Standard_D3_v2" : "Standard_A2_v2")
  )
}

variable "location" {
  type    = string
  default = "eastus"
}

variable "kubernetes_version" {
  type    = string
  default = "1.31.1"
}

variable "container_registry_name" {
  type    = string
  default = "linusjfflixtube"
}

variable "client_id" {
  type = string
}

variable "client_secret" {
  type = string
}

variable "app_version" {
  type = string
  default = "latest"
}

variable "storage_account_name" {
  type = string
}

variable "storage_access_key" {
  type = string
}

variable "node_count" {
  type    = number
  default = 1

  validation {
    condition     = var.node_count > 0
    error_message = "node_count must be 1 or more."
  }
}
