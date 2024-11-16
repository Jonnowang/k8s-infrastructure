variable "ubuntu_22_04" {
  description = "OS image for Ubuntu 22.04"
  default     = "ocid1.image.oc1.uk-london-1.aaaaaaaa2dt7uax5nt7hslusjgcmapgg3smtdprhd2nhn2tcq3udtl7bbrkq"
}

resource "oci_core_instance" "ubuntu_instance" {
    # Required
    availability_domain = data.oci_identity_availability_domains.ads.availability_domains[1].name
    compartment_id = oci_identity_compartment.tf-compartment.id
    shape = "VM.Standard.A1.Flex"
    source_details {
        source_id = var.ubuntu_22_04
        source_type = "image"
    }

    # Optional
    display_name = "constellation-arm-compute"
    shape_config {
        ocpus = 4
        memory_in_gbs = 24
    }
    create_vnic_details {
        assign_public_ip = true
        subnet_id = oci_core_subnet.vcn-public-subnet.id
    }
    metadata = {
        ssh_authorized_keys = file("/home/jonathan/.oci/oci-arm-vm.pub")
    } 
    preserve_boot_volume = false
}
