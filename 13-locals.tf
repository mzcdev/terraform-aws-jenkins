# locals

locals {
  domain_name = var.dns_name != "" ? var.dns_name : "jenkins.${var.dns_root}"

  dns_name = var.dns_root != "" ? local.domain_name : aws_alb.this.dns_name
}
