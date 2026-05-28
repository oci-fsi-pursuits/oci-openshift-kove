data "oci_identity_regions" "regions" {
}

data "oci_identity_tenancy" "tenancy" {
  tenancy_id = var.tenancy_ocid
}

locals {
  region_map = {
    for r in data.oci_identity_regions.regions.regions :
    r.key => r.name
  }

  current_region_key = [
    for r in data.oci_identity_regions.regions.regions :
    r.key if r.name == var.region
  ][0]

  home_region = local.region_map[data.oci_identity_tenancy.tenancy.home_region_key]

  is_control_plane_iscsi_type = can(regex("^BM\\..*$", var.control_plane_shape))
  is_compute_iscsi_type       = can(regex("^BM\\..*$", var.compute_shape))
  compute_node_ads            = distinct([for node in values(module.meta.compute_node_map) : node.ad_name])
  rdma_compute_cluster_ad     = length(local.compute_node_ads) > 0 ? local.compute_node_ads[0] : module.meta.ad_name
  effective_rdma_compute_cluster_id = var.enable_rdma_compute_cluster ? (
    trimspace(var.rdma_compute_cluster_id) != "" ? trimspace(var.rdma_compute_cluster_id) : oci_core_compute_cluster.openshift_compute_workers[0].id
  ) : ""

  apps_subnet_id        = var.enable_public_apps_lb ? module.network.op_subnet_public : module.network.op_subnet_private_ocp
  apps_security_list_id = var.enable_public_apps_lb ? module.network.op_security_list_public : module.network.op_security_list_private

  existing_networking_compartment_ocid = var.use_existing_network ? var.networking_compartment_ocid : null

  openshift_installer_version = var.set_openshift_installer_version ? var.openshift_installer_version : "latest"

  # how long resource creation will be paused to allow for newly created tagging resources to reach consistency
  wait_for_new_tag_consistency_wait_time = "30s"
}
