output "output" {
  value = <<README

frontend: ssh -i ~/.ssh/awskey-modular.pem centos@${module.frontend.public_ip}
public-api: ssh -i ~/.ssh/awskey-modular.pem centos@${module.public_api.public_ip}
product-api: ssh -i ~/.ssh/awskey-modular.pem centos@${module.product_api.public_ip}
postgres: ssh -i ~/.ssh/awskey-modular.pem centos@${module.postgres.public_ip}

Takes a while for docker:
http://${module.frontend.public_ip}

ssh-key (save as ~/.ssh/awskey-modular.pem)
${aws_key_pair.awskey.key_name}

README
}

output "environment" {
    value = var.environment
}
