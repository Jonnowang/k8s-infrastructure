resource "oci_identity_compartment" "tf-compartment" {
    # Required
    compartment_id = "ocid1.tenancy.oc1..aaaaaaaa6pn45lyesehihf3dafl6c2p46ggpdutmmvnm6nvwmnhwwqdp2vgq"
    description = "Basic compartment for kubernetes cluster's Terraform resources."
    name = "personal-cluster"
}
