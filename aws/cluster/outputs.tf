
output "consul_dns" {
  value = <<EOT
Consul public DNS are:
Consul-1 = ${module.consul_instances.public_dns[0]}
Consul-2 = ${module.consul_instances.public_dns[1]}
Consul-3 = ${module.consul_instances.public_dns[2]}
EOT
}
