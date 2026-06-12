project_name = "linuxtips-cluster--02"

region = "us-east-2"

k8s_version = "1.35"

ssm_vpc = "/eks-cluster-core-base/vpc/id"

ssm_subnets = [
  "/eks-cluster-core-base/subnets/private/us-east-2a/bms-pods-subnet-2a",
  "/eks-cluster-core-base/subnets/private/us-east-2b/bms-pods-subnet-2b",
  "/eks-cluster-core-base/subnets/private/us-east-2c/bms-pods-subnet-2c"
]

karpenter_capacity = [
  {
    name               = "general"
    workload           = "general"
    ami_family         = "AL2023"
    ami_ssm            = "/aws/service/eks/optimized-ami/1.35/amazon-linux-2023/x86_64/standard/recommended/image_id"
    instance_family    = ["t3", "c7i-flex", "m7i-flex"]
    instance_sizes     = ["small", "large"]
    capacity_type      = ["on-demand", "spot"]
    availability_zones = ["us-east-2a", "us-east-2b", "us-east-2c"]
  },
]

istio_ssm_target_group = "/linuxtips-ingress/cluster-02/listener"