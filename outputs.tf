output "environment" {
    value = var.environment
}
output "sshkey" {
  sensitive = true
  value = tls_private_key.awskey.private_key_pem
}
output "hashicups-ui" {
  value = "http://${module.frontend.public_ip}"
}
output "frontend-ip" {
  value =   module.frontend.public_ip
}
output "public-api" {
  value =   module.public_api.public_ip
}
output "product-api" {
  value =   module.product_api.public_ip
}
output "postgres-api" {
  value =   module.postgres.public_ip
}
