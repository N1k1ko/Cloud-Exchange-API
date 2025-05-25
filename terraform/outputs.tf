output "postgresql_hosts" {
  value = module.postgres.pg_cluster_hosts
}

output "app_instance_external_ip" {
  value = module.app.external_ip
}

output "app_instance_internal_ip" {
  value = module.app.internal_ip
}
