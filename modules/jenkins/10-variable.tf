# variable

variable "name" {
  description = "Name of the cluster, e.g: demo"
}

variable "vpc_id" {
  default = ""
}

variable "subnet_id" {
  default = ""
}

variable "public_subnet_ids" {
  default = []
}

variable "jenkins_version" {
  default = "12"
}

variable "jenkins_username" {
  default = "admin"
}

variable "jenkins_password" {
  default = "password"
}

variable "jenkins_plugins" {
  type = list(string)
  default = [
    "ant",
    "antisamy-markup-formatter",
    "build-timeout",
    "cloudbees-folder",
    "credentials-binding",
    "email-ext",
    "git",
    "github-branch-source",
    "gradle",
    "ldap",
    "mailer",
    "matrix-auth",
    "pam-auth",
    "pipeline-github-lib",
    "pipeline-stage-view",
    "ssh-slaves",
    "subversion",
    "timestamper",
    "workflow-aggregator",
    "ws-cleanup",
  ]
}

variable "allow_ip_address" {
  type    = list(string)
  default = []
}

variable "ami_id" {
  default = ""
}

variable "instance_type" {
  default = "t2.medium"
}

variable "volume_id" {
  default = ""
}

variable "volume_type" {
  default = "gp2"
}

variable "volume_size" {
  default = "64"
}

variable "key_name" {
  default = ""
}

variable "key_path" {
  default = ""
}

variable "user_data" {
  default = ""
}

variable "domain" {
  default = ""
}

variable "base_domain" {
  default = ""
}
