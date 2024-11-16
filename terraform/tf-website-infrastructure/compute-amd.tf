resource "oci_core_instance" "ubuntu_instance" {
    # Required
    availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
    compartment_id = oci_identity_compartment.tf-compartment.id
    shape = "VM.Standard.E2.1.Micro"
    source_details {
        source_id = "ocid1.image.oc1.uk-london-1.aaaaaaaalmz2f3ryfakc4fd5r4uteua3az3dfvcxr6q77b2nvddzevscjk5q"
        source_type = "image"
    }

    # Optional
    display_name = "constellation-amd-compute"
    create_vnic_details {
        assign_public_ip = true
        subnet_id = oci_core_subnet.vcn-public-subnet.id
    }
    metadata = {
        ssh_authorized_keys = file("/home/jonathan/.oci/oci-amd-vm.pub")
    } 
    preserve_boot_volume = false
}
