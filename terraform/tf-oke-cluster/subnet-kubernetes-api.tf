# Source from https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_subnet
resource "oci_core_subnet" "vcn-kubernetes-api-subnet"{

  # Required
  compartment_id = oci_identity_compartment.tf-compartment.id
  vcn_id = module.vcn.vcn_id
  cidr_block = var.kubernetes_api_subnet_cidr_range
  dns_label = var.subnet_dns_label
 
  # Optional
  route_table_id = module.vcn.ig_route_id
  security_list_ids = [oci_core_security_list.kubernetes-api-security-list.id]
  display_name = "constellation-kubernetes-api-subnet"
}


# Source from https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_security_list

resource "oci_core_security_list" "kubernetes-api-security-list"{

	# Required
  compartment_id = oci_identity_compartment.tf-compartment.id
  vcn_id = module.vcn.vcn_id

	# Optional
  display_name = "kubernetes-api-subnet-security-list"

  ## EGRESS
  # OKE API -> OCI services
	egress_security_rules {
    stateless = false
    destination = var.services_uk_london_1
    destination_type = "SERVICE_CIDR_BLOCK"
    protocol = "6" 
    tcp_options { 
      min = 443
      max = 443
    }
	}

  # K8s API -> Worker nodes
	egress_security_rules {
    stateless = false
    destination = var.worker_node_cidr_range
    destination_type = "CIDR_BLOCK"
    protocol = "6" 
    tcp_options { 
      min = 10250
      max = 10250
    }
	}

  # All traffic to pods
	egress_security_rules {
    stateless = false
    destination = var.pods_cidr_range
    destination_type = "CIDR_BLOCK"
    protocol = "all" 
	}

  # Path discovery
  egress_security_rules { 
    stateless = false
    destination = var.worker_node_cidr_range
    destination_type = "CIDR_BLOCK"
    # Get protocol numbers from https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml ICMP is 1  
    protocol = "1"

    # For ICMP type and code see: https://www.iana.org/assignments/icmp-parameters/icmp-parameters.xhtml
    icmp_options {
      type = 3
      code = 4
    } 
  }   

  ## INGRESS
	# Worker node -> K8s API
	ingress_security_rules { 
    stateless = false
    source = var.worker_node_cidr_range
    source_type = "CIDR_BLOCK"
    protocol = "6"
    tcp_options { 
      min = 6443
      max = 6443
    }
  }

	ingress_security_rules { 
    stateless = false
    source = var.worker_node_cidr_range
    source_type = "CIDR_BLOCK"
    protocol = "6"
    tcp_options { 
      min = 12250
      max = 12250
    }
  }

	# Pods -> K8s API
	ingress_security_rules { 
    stateless = false
    source = var.pods_cidr_range
    source_type = "CIDR_BLOCK"
    protocol = "6"
    tcp_options { 
      min = 6443
      max = 6443
    }
  }

	ingress_security_rules { 
    stateless = false
    source = var.pods_cidr_range
    source_type = "CIDR_BLOCK"
    protocol = "6"
    tcp_options { 
      min = 12250
      max = 12250
    }
  }

  # Path discovery
  ingress_security_rules { 
    stateless = false
    source = var.worker_node_cidr_range
    source_type = "CIDR_BLOCK"
    # Get protocol numbers from https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml ICMP is 1  
    protocol = "1"

    # For ICMP type and code see: https://www.iana.org/assignments/icmp-parameters/icmp-parameters.xhtml
    icmp_options {
      type = 3
      code = 4
    } 
  }   

  # Client -> K8s API
	ingress_security_rules { 
    stateless = false
    source = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    protocol = "6"
    tcp_options { 
      min = 6443
      max = 6443
    }
  }
}
  