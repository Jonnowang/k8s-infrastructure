# Source from https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_subnet
resource "oci_core_subnet" "vcn-sql-db-subnet"{

  # Required
  compartment_id = oci_identity_compartment.tf-compartment.id
  vcn_id = module.vcn.vcn_id
  cidr_block = var.mysql_db_cidr_range
  prohibit_public_ip_on_vnic = true
 
  # Optional
  route_table_id = module.vcn.nat_route_id
  security_list_ids = [oci_core_security_list.sql-db-security-list.id]
  display_name = "constellation-sql-db-subnet"
}


# Source from https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_security_list
resource "oci_core_security_list" "sql-db-security-list"{

	# Required
  compartment_id = oci_identity_compartment.tf-compartment.id
  vcn_id = module.vcn.vcn_id

	# Optional
  display_name = "sql-db-subnet-security-list"

  ## INGRESS
	# Allow all http traffic to reach public_lb
	ingress_security_rules { 
    stateless = false
    source = var.pods_cidr_range
    source_type = "CIDR_BLOCK"
    protocol = "6"
    tcp_options { 
      min = 3306
      max = 3306
    } 
  }

	# Allow all https traffic to reach public_lb
	ingress_security_rules { 
    stateless = false
    source = var.pods_cidr_range
    source_type = "CIDR_BLOCK"
    protocol = "6"
    tcp_options { 
      min = 33060
      max = 33060
    } 
  }
}
