# Source from https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/containerengine_cluster

resource "oci_containerengine_cluster" "oke-cluster" {
    # Required
    compartment_id = oci_identity_compartment.tf-compartment.id
    kubernetes_version = "v1.30.1"
    name = "constellation-cluster-1"
    type = "BASIC_CLUSTER"
    vcn_id = module.vcn.vcn_id

    # Place public endpoints in VCN
    endpoint_config {
        is_public_ip_enabled = true
        subnet_id = oci_core_subnet.vcn-public-subnet.id
    }

    # Optional
    options {
        add_ons{
            is_kubernetes_dashboard_enabled = false
            is_tiller_enabled = false
        }
        kubernetes_network_config {
            pods_cidr = var.pods_cidr_range
            services_cidr = var.services_cidr_range
        }
        service_lb_subnet_ids = [oci_core_subnet.vcn-public-subnet.id]
    }  
}
