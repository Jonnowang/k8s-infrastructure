# Output the "list" of all availability domains.
output "all-availability-domains-in-your-tenancy" {
  value = data.oci_identity_availability_domains.ads.availability_domains
}

# The "name" of the availability domain to be used for the compute instance.
output "name-of-first-availability-domain" {
  value = data.oci_identity_availability_domains.ads.availability_domains[0].name
}

# Outputs for compartment
output "compartment-name" {
  value = oci_identity_compartment.tf-compartment.name
}

output "compartment-OCID" {
  value = oci_identity_compartment.tf-compartment.id
}

# Outputs for the vcn module
output "vcn_id" {
  description = "OCID of the VCN that is created"
  value = module.vcn.vcn_id
}
output "id-for-route-table-that-includes-the-internet-gateway" {
  description = "OCID of the internet-route table. This route table has an internet gateway to be used for public subnets"
  value = module.vcn.ig_route_id
}
output "nat-gateway-id" {
  description = "OCID for NAT gateway"
  value = module.vcn.nat_gateway_id
}
output "id-for-for-route-table-that-includes-the-nat-gateway" {
  description = "OCID of the nat-route table - This route table has a nat gateway to be used for private subnets. This route table also has a service gateway."
  value = module.vcn.nat_route_id
}


# Outputs for security lists
output "kubernetes-api-security-list-name" {
  value = oci_core_security_list.kubernetes-api-security-list.display_name
}
output "kubernetes-api-security-list-OCID" {
  value = oci_core_security_list.kubernetes-api-security-list.id
}
output "worker-node-security-list-name" {
  value = oci_core_security_list.worker-node-security-list.display_name
}
output "worker-node-security-list-OCID" {
  value = oci_core_security_list.worker-node-security-list.id
}
output "pods-security-list-name" {
  value = oci_core_security_list.pods-security-list.display_name
}
output "pods-security-list-OCID" {
  value = oci_core_security_list.pods-security-list.id
}
output "public-lb-security-list-name" {
  value = oci_core_security_list.public-lb-security-list.display_name
}
output "public-lb-security-list-OCID" {
  value = oci_core_security_list.public-lb-security-list.id
}


# Outputs for subnets
output "kubernetes-api-subnet-name" {
  value = oci_core_subnet.vcn-kubernetes-api-subnet.display_name
}
output "kubernetes-api-subnet-OCID" {
  value = oci_core_subnet.vcn-kubernetes-api-subnet.id
}
output "worker-node-subnet-name" {
  value = oci_core_subnet.vcn-worker-node-subnet.display_name
}
output "worker-node-subnet-OCID" {
  value = oci_core_subnet.vcn-worker-node-subnet.id
}
output "pods-subnet-name" {
  value = oci_core_subnet.vcn-pods-subnet.display_name
}
output "pods-subnet-OCID" {
  value = oci_core_subnet.vcn-pods-subnet.id
}
output "public-lb-subnet-name" {
  value = oci_core_subnet.vcn-public-lb-subnet.display_name
}
output "public-lb-subnet-OCID" {
  value = oci_core_subnet.vcn-public-lb-subnet.id
}


# Outputs for k8s cluster

output "cluster-name" {
  value = oci_containerengine_cluster.oke-cluster.name
}
output "cluster-OCID" {
  value = oci_containerengine_cluster.oke-cluster.id
}
output "cluster-kubernetes-version" {
  value = oci_containerengine_cluster.oke-cluster.kubernetes_version
}
output "cluster-state" {
  value = oci_containerengine_cluster.oke-cluster.state
}

# Outputs for k8s node pools

output "arm-node-pool-name" {
  value = oci_containerengine_node_pool.oke-arm-node-pool.name
}
output "arm-node-pool-OCID" {
  value = oci_containerengine_node_pool.oke-arm-node-pool.id
}
output "arm-node-pool-kubernetes-version" {
  value = oci_containerengine_node_pool.oke-arm-node-pool.kubernetes_version
}
output "arm-node-size" {
  value = oci_containerengine_node_pool.oke-arm-node-pool.node_config_details[0].size
}
output "arm-node-shape" {
  value = oci_containerengine_node_pool.oke-arm-node-pool.node_shape
}

# output "amd-node-pool-name" {
#   value = oci_containerengine_node_pool.oke-amd-node-pool.name
# }
# output "amd-node-pool-OCID" {
#   value = oci_containerengine_node_pool.oke-amd-node-pool.id
# }
# output "amd-node-pool-kubernetes-version" {
#   value = oci_containerengine_node_pool.oke-amd-node-pool.kubernetes_version
# }
# output "amd-node-size" {
#   value = oci_containerengine_node_pool.oke-amd-node-pool.node_config_details[0].size
# }
# output "amd-node-shape" {
#   value = oci_containerengine_node_pool.oke-amd-node-pool.node_shape
# }

# MySql DB
output "mysql_database" {
  value = {
    db_id         = oci_mysql_mysql_db_system.mysql_db_system.id
    db_ip         = oci_mysql_mysql_db_system.mysql_db_system.ip_address
  }
}
