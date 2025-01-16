resource "oci_mysql_mysql_db_system" "mysql_db_system" {
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[1].name
  compartment_id      = oci_identity_compartment.tf-compartment.id
  shape_name          = "MySQL.Free"
  data_storage_size_in_gb = 50
  subnet_id           = oci_core_subnet.vcn-sql-db-subnet.id
  admin_username      = 
  admin_password      = 

  display_name            = "constellation-mysql-db"
  description             = "Constellation MySQL Heatwave Database System"
  port   = 3306
  port_x = 33060
}


resource "oci_mysql_heat_wave_cluster" "mysql_heatwave_engine" {
    db_system_id = oci_mysql_mysql_db_system.mysql_db_system.id
    cluster_size = 1
    shape_name   = "HeatWave.Free"
}
