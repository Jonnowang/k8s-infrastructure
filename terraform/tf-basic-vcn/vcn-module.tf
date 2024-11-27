module "vcn" {
  source  = "oracle-terraform-modules/vcn/oci"
  version = "3.1.0"

  # Required Inputs
  compartment_id = "ocid1.compartment.oc1..aaaaaaaazfp7fk7b4j2tdcwzzmmeb4asnwsm52zqn77e4ldnt3lb6mfxjkpa"
  region = "uk-london-1"

  internet_gateway_route_rules = null
  local_peering_gateways = null
  nat_gateway_route_rules = null

  # Optional Inputs
  vcn_name = "vcn-constellation"
  vcn_dns_label = "jonathan"
  vcn_cidrs = ["10.0.0.0/16"]
  
  create_internet_gateway = true
  create_nat_gateway = true
  create_service_gateway = true  
}
