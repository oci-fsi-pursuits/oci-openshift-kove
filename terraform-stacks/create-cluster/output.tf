output "open_shift_api_int_lb_addr" {
  value = module.load_balancer.op_lb_openshift_api_int_lb_ip_addr
}

output "compute_cluster_id" {
  description = "OCI Compute Cluster OCID used by OpenShift compute workers when RDMA mode is enabled. Pass this to the XPD stack compute_cluster_id input."
  value       = local.effective_rdma_compute_cluster_id
}

output "op_vcn_openshift_vcn" {
  description = "OpenShift VCN OCID. Pass this to the XPD stack existing_vcn_id input."
  value       = module.network.op_vcn_openshift_vcn
}

output "op_subnet_public" {
  description = "OpenShift public subnet OCID. Pass this to the XPD stack existing_public_subnet_id input."
  value       = module.network.op_subnet_public
}

output "op_subnet_private_bare_metal" {
  description = "OpenShift private bare metal subnet OCID. Pass this to the XPD stack existing_private_subnet_id input."
  value       = module.network.op_subnet_private_bare_metal
}

output "op_subnet_private_ocp" {
  description = "OpenShift private OCP subnet OCID."
  value       = module.network.op_subnet_private_ocp
}

output "open_shift_api_lb_addr" {
  value = module.load_balancer.op_lb_openshift_api_lb_ip_addr
}

output "open_shift_apps_lb_addr" {
  value = module.load_balancer.op_lb_openshift_apps_lb_ip_addr
}

output "oci_ccm_config" {
  value = module.manifests.oci_ccm_config
}

output "dynamic_custom_manifest" {
  value = module.manifests.dynamic_custom_manifest
}

output "etc_hosts_entry" {
  value = <<EOT
${module.load_balancer.op_lb_openshift_api_lb_ip_addr}  api.${var.cluster_name}.${var.zone_dns}
${module.load_balancer.op_lb_openshift_apps_lb_ip_addr}  console-openshift-console.apps.${var.cluster_name}.${var.zone_dns} oauth-openshift.apps.${var.cluster_name}.${var.zone_dns}
EOT
}

output "agent_config" {
  value       = var.installation_method == "Assisted" ? null : module.manifests.agent_config
  description = "Agent config output; null if use Assisted Installer."
}

output "install_config" {
  value       = var.installation_method == "Assisted" ? null : module.manifests.install_config
  description = "Install config output; null if use Assisted Installer."
}

output "stack_version" {
  value = local.stack_version
}
