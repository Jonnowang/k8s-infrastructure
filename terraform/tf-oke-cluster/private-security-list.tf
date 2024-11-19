# Source from https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_security_list

resource "oci_core_security_list" "private-security-list"{

	# Required
  compartment_id = oci_identity_compartment.tf-compartment.id
  vcn_id = module.vcn.vcn_id

	# Optional
  display_name = "private-subnet-security-list"

	egress_security_rules {
			stateless = false
			destination = "0.0.0.0/0"
			destination_type = "CIDR_BLOCK"
			protocol = "all" 
	}

	# Give all services in VCN ingress to the private subnet
	ingress_security_rules { 
      stateless = false
      source = "10.0.0.0/16"
      source_type = "CIDR_BLOCK"
      protocol = "all"
    }
}
  