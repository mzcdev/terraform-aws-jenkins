# jenkins

terraform {
  backend "s3" {
    region         = "ap-northeast-2"
    bucket         = "terraform-mz-demo-seoul"
    key            = "jenkins.tfstate"
    dynamodb_table = "terraform-mz-demo-seoul"
    encrypt        = true
  }
  required_version = ">= 0.12"
}

provider "aws" {
  region = var.region
}

module "jenkins" {
  source = "../../"

  name = var.name

  vpc_id    = data.terraform_remote_state.vpc.outputs.vpc_id
  subnet_id = data.terraform_remote_state.vpc.outputs.private_subnet_ids.0

  public_subnet_ids = data.terraform_remote_state.vpc.outputs.public_subnet_ids

  jenkins_version = var.jenkins_version

  allow_ssh_sg     = var.allow_ssh_sg
  allow_ip_address = var.allow_ip_address

  key_name = var.key_name

  dns_name = var.dns_name
  dns_root = var.dns_root

  slack_token = var.slack_token
}
