variable "oracle_8_10" {
  description = "OS image for Oracle Linux 8.10"
  default     = "ocid1.image.oc1.uk-london-1.aaaaaaaaekleu5ti4ljq3kuu54c6jbr7pqnhrydepjlpuzpanwyuxxwf66gq"
}

# Source from https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/containerengine_node_pool

resource "oci_containerengine_node_pool" "oke-node-pool" {
    # Required
    cluster_id = oci_containerengine_cluster.oke-cluster.id
    compartment_id = oci_identity_compartment.tf-compartment.id
    kubernetes_version = "v1.30.1"
    name = "constellation-node-pool"
    node_config_details{
        placement_configs{
            availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
            subnet_id = oci_core_subnet.vcn-private-subnet.id
        } 
        placement_configs{
            availability_domain = data.oci_identity_availability_domains.ads.availability_domains[1].name
            subnet_id = oci_core_subnet.vcn-private-subnet.id
        }
        size = 2
    }
    node_shape = "VM.Standard.A1.Flex"
    node_shape_config {
        memory_in_gbs = 12
        ocpus         = 2
    }

    node_source_details {
        image_id = var.oracle_8_10
        source_type = "image"
        boot_volume_size_in_gbs = 50
    }
 
    # Optional
    initial_node_labels {
        key = "name"
        value = "constellation-cluster-1"
    }    
}
