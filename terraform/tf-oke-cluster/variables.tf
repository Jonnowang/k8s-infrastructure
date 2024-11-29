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

variable ubuntu_2404_minimal_aarch {
  type        = string
  default     = "ocid1.image.oc1.uk-london-1.aaaaaaaa4z7qr5ccidp4dowvqrb65v4qnrmzmx346q7gkvsbw6vfwxh6bkfq"
  description = "OS image for Ubuntu 24.04 Minimal AArch64"
}

variable ubuntu_2404_minimal_amd {
  type        = string
  default     = "ocid1.image.oc1.uk-london-1.aaaaaaaaaghag4jvfj64zh6pnut7pihu3vke3tzihzp3mz2b5lifwoo3jqka"
  description = "OS image for Ubuntu 24.04 Minimal Amd64"
}

variable worker_node_shape_arm {
  type        = string
  default     = "VM.Standard.A1.Flex"
  description = "Standard ARM based Ampere shape"
}

variable worker_node_shape_amd {
  type        = string
  default     = "VM.Standard.E2.1.Micro"
  description = "Micro AMD based shape"
}

variable kubernetes_node_version {
  type        = string
  default     = "v1.31.1"
  description = "Current version of Kubernetes to use for OKE cluster"
}
