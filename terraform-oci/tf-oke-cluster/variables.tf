# CIDR Ranges
variable vcn_cidr_range {
  type        = string
  default     = "10.0.0.0/16"
  description = "CIDR block for internal VCN"
}

variable kubernetes_api_subnet_cidr_range {
  type        = string
  default     = "10.0.1.0/24"
  description = "CIDR block for kubernetes api subnet"
}

variable worker_node_cidr_range {
  type        = string
  default     = "10.0.2.0/24"
  description = "CIDR block for private subnet"
}

variable pods_cidr_range {
  type        = string
  default     = "10.0.3.0/24"
  description = "CIDR block for pod instances"
}

variable services_cidr_range {
  type        = string
  default     = "10.1.0.0/20"
  description = "CIDR block for service instances"
}

variable public_lb_cidr_range {
  type        = string
  default     = "10.0.5.0/24"
  description = "CIDR block for public load balancers"
}

variable mysql_db_cidr_range {
  type        = string
  default     = "10.0.6.0/24"
  description = "CIDR block for oracle-managed mysql db"
}

variable subnet_dns_label {
  type        = string
  default     = "constellation"
  description = "DNS Label for public subnet"
}

variable services_uk_london_1 {
  type        = string
  default     = "all-lhr-services-in-oracle-services-network"
  description = "CIDR Label for london 1 all services"
}

# Worker node definitions

variable oracle_8_aarch64 {
  type        = string
  default     = "ocid1.image.oc1.uk-london-1.aaaaaaaaavhcvlf3o2ven2l6cia3i4ton4gurepucrfhrcwj2qfekrr3pqha"
  description = "OS image for Oracle 8 2025-09-16 AArch64"
}

variable oracle_9_minimal_amd {
  type        = string
  default     = "ocid1.image.oc1.uk-london-1.aaaaaaaayzqftcsgvgcy42rrmndmtjohkuvb2u4zdtb2u7sslae6fvuo3hfq"
  description = "OS image for Oracle 9 Minimal Amd64"
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

variable default_node_boot_volume_gbs {
  type        = number
  default     = 100
  description = "100Gb default boot volume"
}

variable kubernetes_node_version {
  type        = string
  default     = "v1.34.1"
  description = "Current version of Kubernetes to use for OKE cluster"
}

variable kubernetes_cni_type {
  type        = string
  default     = "OCI_VCN_IP_NATIVE"
  description = "OCI VCN Native CNI"
}

# MySql db variables

variable "mysql_username" {
  description = "Database administrator username"
  type        = string
  sensitive   = true
}

variable "mysql_password" {
  description = "Database administrator password"
  type        = string
  sensitive   = true
}
