output "network_id" {
  value = yandex_vpc_network.app.id
}

output "subnet_id" {
  value = yandex_vpc_subnet.app.id
}
