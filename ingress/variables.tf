variable "project_name" {
  description = "Nome do projeto"
  type        = string

}

variable "region" {
  description = "AWS region where the resources will be created"
  type        = string
  default     = "us-east-2"

}

variable "ssm_vpc" {

}

variable "ssm_subnets" {
  type = list(string)
}

variable "routing_weight" {
  type = object({
    cluster_01 = number
    cluster_02 = number
  })
}

variable "dns_name" {
  type = string
}

variable "route53_hosted_zone" {
  type = string
}