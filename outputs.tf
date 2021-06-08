output "output" {
  value = <<README

frontend: ssh -i ~/.ssh/awskey-modular.pem centos@${module.frontend.public_ip}
public-api: ssh -i ~/.ssh/awskey-modular.pem centos@${module.public_api.public_ip}
product-api: ssh -i ~/.ssh/awskey-modular.pem centos@${module.product_api.public_ip}
postgres: ssh -i ~/.ssh/awskey-modular.pem centos@${module.postgres.public_ip}

Takes a while for docker:
http://${module.frontend.public_ip}

README
}

output "environment" {
    value = var.environment
}

output "sshkey" {
  sensitive = false
  value = tls_private_key.awskey.private_key_pem
}