# CIDR Ranges
variable vcn_cidr_range {
  type        = string
  default     = "10.0.0.0/16"
  description = "CIDR block for internal VCN"
}

variable public_subnet_cidr_range {
  type        = string
  default     = "10.0.0.0/24"
  description = "CIDR block for public subnet"
}

variable subnet_dns_label {
  type        = string
  default     = "constellation"
  description = "DNS Label for public subnet"
}

variable private_subnet_cidr_range {
  type        = string
  default     = "10.0.1.0/24"
  description = "CIDR block for private subnet"
}

# CIDR Ranges for pods and services

variable pods_cidr_range {
  type        = string
  default     = "10.1.0.0/16"
  description = "CIDR block for pod instances"
}

variable services_cidr_range {
  type        = string
  default     = "10.2.0.0/16"
  description = "CIDR block for service instances"
}

# Worker node definitions

variable oracle_8_10 {
  type        = string
  default     = "ocid1.image.oc1.uk-london-1.aaaaaaaaekleu5ti4ljq3kuu54c6jbr7pqnhrydepjlpuzpanwyuxxwf66gq"
  description = "OS image for Oracle Linux 8.10"
}

variable worker_node_shape {
  type        = string
  default     = "VM.Standard.A1.Flex"
  description = "Standard ARM based Ampere shape"
}

variable kubernetes_node_version {
  type        = string
  default     = "v1.30.1"
  description = "Current version of Kubernetes to use for OKE cluster"
}
