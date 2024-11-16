resource "oci_core_instance" "ubuntu_instance" {
    # Required
    availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
    compartment_id = "ocid1.tenancy.oc1..aaaaaaaa6pn45lyesehihf3dafl6c2p46ggpdutmmvnm6nvwmnhwwqdp2vgq"
    shape = "VM.Standard.E2.1.Micro"
    source_details {
        source_id = "ocid1.image.oc1.uk-london-1.aaaaaaaalmz2f3ryfakc4fd5r4uteua3az3dfvcxr6q77b2nvddzevscjk5q"
        source_type = "image"
    }

    # Optional
    display_name = "constellation-amd-compute"
    create_vnic_details {
        assign_public_ip = true
        subnet_id = "ocid1.subnet.oc1.uk-london-1.aaaaaaaa654ohrtom24dijwotxunt5yho4fa4yne2lxm5f3llmzqjblkcwea"
    }
    metadata = {
        ssh_authorized_keys = file("/home/jonathan/.oci/oci-amd-vm.pub")
    } 
    preserve_boot_volume = false
}
