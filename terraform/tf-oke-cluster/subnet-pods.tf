# Source from https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_subnet
resource "oci_core_subnet" "vcn-pods-subnet"{

  # Required
  compartment_id = oci_identity_compartment.tf-compartment.id
  vcn_id = module.vcn.vcn_id
  cidr_block = var.pods_cidr_range
  prohibit_public_ip_on_vnic = true
 
  # Optional
  route_table_id = module.vcn.nat_route_id
  security_list_ids = [oci_core_security_list.pods-security-list.id]
  display_name = "constellation-pods-subnet"
}


# Source from https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_security_list
resource "oci_core_security_list" "pods-security-list"{

	# Required
  compartment_id = oci_identity_compartment.tf-compartment.id
  vcn_id = module.vcn.vcn_id

	# Optional
  display_name = "pods-subnet-security-list"

  ## EGRESS
  # All TCP traffic to OKE services
	egress_security_rules {
    stateless = false
    destination = var.services_uk_london_1
    destination_type = "SERVICE_CIDR_BLOCK"
    protocol = "6" 
	}

  # All traffic between podss
	egress_security_rules {
    stateless = false
    destination = var.pods_cidr_range
    destination_type = "CIDR_BLOCK"
    protocol = "all" 
	}

  # Allow pod to access internet for image pull
  egress_security_rules {
    stateless = false
    destination = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    protocol = "6"
    tcp_options { 
      min = 443
      max = 443
    } 
  }

  egress_security_rules {
    stateless = false
    destination = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    protocol = "6"
    tcp_options { 
      min = 80
      max = 80
    } 
  }

  egress_security_rules {
    stateless = false
    destination = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    protocol = "6"
    tcp_options { 
      min = 22
      max = 22
    } 
  }

  # DB 
  egress_security_rules {
    stateless = false
    destination = var.mysql_db_cidr_range
    destination_type = "CIDR_BLOCK"
    protocol = "6"
    tcp_options { 
      min = 3306
      max = 3306
    } 
  }

  # Path discovery
  egress_security_rules { 
    stateless = false
    destination = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    # Get protocol numbers from https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml ICMP is 1  
    protocol = "1"

    # For ICMP type and code see: https://www.iana.org/assignments/icmp-parameters/icmp-parameters.xhtml
    icmp_options {
      type = 3
      code = 4
    } 
  }   

  # Secure traffic to K8s API
	egress_security_rules {
    stateless = false
    destination = var.kubernetes_api_subnet_cidr_range
    destination_type = "CIDR_BLOCK"
    protocol = "6"
    tcp_options { 
      min = 6443
      max = 6443
    } 
	}

	egress_security_rules {
    stateless = false
    destination = var.kubernetes_api_subnet_cidr_range
    destination_type = "CIDR_BLOCK"
    protocol = "6"
    tcp_options { 
      min = 12250
      max = 12250
    } 
	}

  ## INGRESS
	# Allow all traffic from pods
	ingress_security_rules { 
    stateless = false
    source = var.pods_cidr_range
    source_type = "CIDR_BLOCK"
    protocol = "all"
  }

  # Allow all traffic from worker nodes
	ingress_security_rules { 
    stateless = false
    source = var.worker_node_cidr_range
    source_type = "CIDR_BLOCK"
    protocol = "all"
  }

  # Allow all traffic from k8s API
	ingress_security_rules { 
    stateless = false
    source = var.kubernetes_api_subnet_cidr_range
    source_type = "CIDR_BLOCK"
    protocol = "all"
  }
}
