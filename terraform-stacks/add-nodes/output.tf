output "stack_version" {
  value = local.stack_version
}

output "compute_cluster_id" {
  description = "OCI Compute Cluster OCID used by new OpenShift compute workers when RDMA mode is enabled."
  value       = var.enable_rdma_compute_cluster ? trimspace(var.rdma_compute_cluster_id) : ""
}
