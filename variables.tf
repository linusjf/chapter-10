# Sets global variables for this Terraform project.
variable environment {
  type = string
  description = "Environment short name (dev, stage, prod)"
}

locals {
  app_name = "flixtube-${var.environment}"
}

variable location {
  type = string
  default = "eastus"
}

variable kubernetes_version {
  type = string
  default = "1.31.1"
}

variable container_registry_name {
  type = string
  default = "linusjfflixtube"
}

variable client_id {
  type = string
}

variable client_secret {
  type = string
}

variable app_version {
}

variable storage_account_name {
  type = string
}

variable storage_access_key {
}

variable vm_size {
  type = string
  default = "Standard_A2_v2"
}

variable node_count {
  type = number
  default = 1

  validation {
    condition     = var.node_count > 0
    error_message = "node_count must be 1 or more."
  }
}

variable "deploy_efk" {
  type        = bool
  default     = false
  description = "Deploy EFK logging stack"
}
