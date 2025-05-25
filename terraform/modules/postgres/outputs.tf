output "pg_cluster_hosts" {
  value = yandex_mdb_postgresql_cluster.app.host[*].fqdn
}
