# Source from https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/containerengine_cluster

resource "oci_containerengine_cluster" "oke-cluster" {
    # Required
    compartment_id = oci_identity_compartment.tf-compartment.id
    kubernetes_version = "v1.30.1"
    name = "constellation-cluster-1"
    vcn_id = module.vcn.vcn_id

    # Optional
    options {
        add_ons{
            is_kubernetes_dashboard_enabled = false
            is_tiller_enabled = false
        }
        kubernetes_network_config {
            pods_cidr = "10.244.0.0/16"
            services_cidr = "10.96.0.0/16"
        }
        service_lb_subnet_ids = [oci_core_subnet.vcn-public-subnet.id]
    }  
    type = "BASIC_CLUSTER"
}
