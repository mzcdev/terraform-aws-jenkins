# output

output "name" {
  value = module.jenkins.name
}

output "private_ip" {
  value = module.gitlab.private_ip
}

output "dns_name" {
  value = module.jenkins.dns_name
}
