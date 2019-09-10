variable "region" {
  default = "ap-northeast-2"
}

variable "city" {
  default = "seoul"
}

variable "stage" {
  default = "dev"
}

variable "name" {
  default = "demo"
}

variable "suffix" {
  default = "jenkins"
}

variable "vpc_id" {
  default = "vpc-025ad1e9d1cb3c27d"
}

variable "subnet_id" {
  default = "subnet-09a6bcc0e50e97446"
}

variable "public_subnet_ids" {
  default = [
    "subnet-007a2bd91c7939e85",
    "subnet-0477597c240b95aa8",
    "subnet-0c91c5cd95b319b76",
  ]
}

variable "jenkins_version" {
  default = "2"
}

variable "allow_ip_address" {
  type = list(string)
  default = [
    "0.0.0.0/0", # all
    # "221.148.35.250/32", # echo "$(curl -sL icanhazip.com)/32"
  ]
}

variable "key_name" {
  default = "nalbam-seoul"
}

variable "domain" {
  default = ""
}

variable "base_domain" {
  default = "mzdev.be"
}

locals {
  full_name = "${var.city}-${var.stage}-${var.name}-${var.suffix}"
}
