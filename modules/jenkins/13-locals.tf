# locals

locals {
  default_domain = var.base_domain != "" ? "jenkins.${var.base_domain}" : ""

  domain = var.domain != "" ? var.domain : local.default_domain
}

locals {
  dns_name = var.base_domain != "" ? aws_route53_record.this.*.name : [aws_alb.this.dns_name]
}
