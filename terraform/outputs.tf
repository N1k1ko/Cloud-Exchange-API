output "postgresql_hosts" {
  value = module.postgres.pg_cluster_hosts
}
output "compute_cloud_external_ip" {
  value = module.compute_cloud.external_ip
}

output "compute_cloud_internal_ip" {
  value = module.compute_cloud.internal_ip
}