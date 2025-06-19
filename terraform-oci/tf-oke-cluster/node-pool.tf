# Source from https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/containerengine_node_pool

# Managed node pool with 2 ARM nodes
resource "oci_containerengine_node_pool" "oke-arm-node-pool" {
    # Required
    cluster_id = oci_containerengine_cluster.oke-cluster.id
    compartment_id = oci_identity_compartment.tf-compartment.id
    kubernetes_version = var.kubernetes_node_version
    name = "constellation-arm-node-pool"
    node_config_details{
        placement_configs{
            availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
            subnet_id = oci_core_subnet.vcn-worker-node-subnet.id
        } 
        placement_configs{
            availability_domain = data.oci_identity_availability_domains.ads.availability_domains[1].name
            subnet_id = oci_core_subnet.vcn-worker-node-subnet.id
        }
        node_pool_pod_network_option_details {
            cni_type = var.kubernetes_cni_type
            pod_subnet_ids = [oci_core_subnet.vcn-pods-subnet.id]
        }
        size = 2
    }
    node_shape = var.worker_node_shape_arm
    node_shape_config {
        memory_in_gbs = 12
        ocpus         = 2
    }

    node_source_details {
        image_id = var.oracle_8_aarch64
        source_type = "IMAGE"
        boot_volume_size_in_gbs = var.default_node_boot_volume_gbs
    }

    lifecycle {
        create_before_destroy = false
    }
 
    # Optional
    initial_node_labels {
        key = "name"
        value = "constellation-cluster-arm"
    }    
}


# # Managed node pool with 2 AMD nodes
# resource "oci_containerengine_node_pool" "oke-amd-node-pool" {
#     # Required
#     cluster_id = oci_containerengine_cluster.oke-cluster.id
#     compartment_id = oci_identity_compartment.tf-compartment.id
#     kubernetes_version = var.kubernetes_node_version
#     name = "constellation-amd-node-pool"
#     node_config_details{
#         placement_configs{
#             availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
#             subnet_id = oci_core_subnet.vcn-worker-node-subnet.id
#         } 
#         placement_configs{
#             availability_domain = data.oci_identity_availability_domains.ads.availability_domains[1].name
#             subnet_id = oci_core_subnet.vcn-worker-node-subnet.id
#         }
#         node_pool_pod_network_option_details {
#             cni_type = var.kubernetes_cni_type
#             pod_subnet_ids = [oci_core_subnet.vcn-pods-subnet.id]
#         }
#         size = 2
#     }
#     node_shape = var.worker_node_shape_amd
#     node_shape_config {
#         memory_in_gbs = 1
#         ocpus         = 1
#     }

#     node_source_details {
#         image_id = var.oracle_9_minimal_amd
#         source_type = "image"
#         boot_volume_size_in_gbs = var.default_node_boot_volume_gbs
#     }
 
#     # Optional
#     initial_node_labels {
#         key = "name"
#         value = "constellation-cluster-amd"
#     }    
# }
