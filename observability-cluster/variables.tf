variable "project_name" {

}

variable "region" {
  description = "AWS region where the resources will be created"
  type        = string
  default     = "us-east-2"

}

variable "k8s_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.35"

}

variable "ssm_vpc" {

}

variable "ssm_subnets" {
  type = list(string)
}

variable "ssm_lb_subnets" {
  type = list(string)
}

variable "ssm_grafana_subnets" {
  type = list(string)
}

variable "node_group_temp_desired" {
  type    = number
  default = 2
}

variable "karpenter_capacity" {
  type = list(object({
    name               = string
    workload           = string
    ami_family         = string
    ami_alias          = optional(string, "")
    ami_ssm            = string
    instance_family    = list(string)
    instance_sizes     = list(string)
    capacity_type      = list(string)
    availability_zones = list(string)
  }))
}

variable "clusters_configs" {
  default = [
    {
      cluster_name = "linuxtips-cluster--01"
    },
    {
      cluster_name = "linuxtips-cluster--02"
    }
  ]
}