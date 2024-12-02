# Source from https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_subnet
resource "oci_core_subnet" "vcn-public-lb-subnet"{

  # Required
  compartment_id = oci_identity_compartment.tf-compartment.id
  vcn_id = module.vcn.vcn_id
  cidr_block = var.public_lb_cidr_range
 
  # Optional
  route_table_id = module.vcn.ig_route_id
  security_list_ids = [oci_core_security_list.public-lb-security-list.id]
  display_name = "constellation-public-lb-subnet"
}


# Source from https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_security_list
resource "oci_core_security_list" "public-lb-security-list"{

	# Required
  compartment_id = oci_identity_compartment.tf-compartment.id
  vcn_id = module.vcn.vcn_id

	# Optional
  display_name = "public-lb-subnet-security-list"

  ## EGRESS
  # Allow lb to reach kube-proxy
	egress_security_rules {
    stateless = false
    destination = var.worker_node_cidr_range
    destination_type = "CIDR_BLOCK"
    protocol = "6"
    tcp_options { 
      min = 10256
      max = 10256
    } 
	}

  # Allow lb to access worker nodes
	egress_security_rules {
    stateless = false
    destination = var.worker_node_cidr_range
    destination_type = "CIDR_BLOCK"
    protocol = "6" 
    tcp_options { 
      min = 30000
      max = 32767
    } 
	}

  ## INGRESS
	# Allow all http traffic to reach public_lb
	ingress_security_rules { 
    stateless = false
    source = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    protocol = "6"
    tcp_options { 
      min = 80
      max = 80
    } 
  }

	# Allow all https traffic to reach public_lb
	ingress_security_rules { 
    stateless = false
    source = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    protocol = "6"
    tcp_options { 
      min = 443
      max = 443
    } 
  }
}
