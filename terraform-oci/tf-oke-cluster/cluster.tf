# Source from https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/containerengine_cluster

resource "oci_containerengine_cluster" "oke-cluster" {
    # Required
    compartment_id = oci_identity_compartment.tf-compartment.id
    kubernetes_version = var.kubernetes_node_version
    name = "constellation-cluster"
    type = "BASIC_CLUSTER"
    vcn_id = module.vcn.vcn_id

    # Place k8s API endpoint in public subnet
    endpoint_config {
        is_public_ip_enabled = true
        subnet_id = oci_core_subnet.vcn-kubernetes-api-subnet.id
    }

    # CNI type
    cluster_pod_network_options {
        cni_type = var.kubernetes_cni_type
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
        service_lb_subnet_ids = [oci_core_subnet.vcn-public-lb-subnet.id]
    }  
}
