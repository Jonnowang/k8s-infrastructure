# Source from https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/identity_availability_domains

# Tenancy is the root or parent to all compartments.
data "oci_identity_availability_domains" "ads" {
  compartment_id = "ocid1.tenancy.oc1..aaaaaaaa6pn45lyesehihf3dafl6c2p46ggpdutmmvnm6nvwmnhwwqdp2vgq"
}
