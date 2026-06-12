project_name = "linuxtips-observability"

region      = "us-east-2"
k8s_version = "1.35"

ssm_vpc = "/eks-cluster-core-base/vpc/id"

ssm_subnets = [
  "/eks-cluster-core-base/subnets/private/us-east-2a/bms-pods-subnet-2a",
  "/eks-cluster-core-base/subnets/private/us-east-2b/bms-pods-subnet-2b",
  "/eks-cluster-core-base/subnets/private/us-east-2c/bms-pods-subnet-2c"
]

ssm_lb_subnets = [
  "/eks-cluster-core-base/subnets/private/us-east-2a/bms-private-subnet-2a",
  "/eks-cluster-core-base/subnets/private/us-east-2b/bms-private-subnet-2b",
  "/eks-cluster-core-base/subnets/private/us-east-2c/bms-private-subnet-2c",
]

ssm_grafana_subnets = [
  "/eks-cluster-core-base/subnets/public/us-east-2a/bms-public-subnet-2a",
  "/eks-cluster-core-base/subnets/public/us-east-2b/bms-public-subnet-2b",
  "/eks-cluster-core-base/subnets/public/us-east-2c/bms-public-subnet-2c",
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
  {
    name               = "grafana"
    workload           = "grafana"
    ami_family         = "Bottlerocket"
    ami_ssm            = "/aws/service/bottlerocket/aws-k8s-1.31/x86_64/latest/image_id"
    instance_family    = ["t3", "c7i-flex", "m7i-flex"]
    instance_sizes     = ["small", "large"]
    capacity_type      = ["on-demand", "spot"]
    availability_zones = ["us-east-2a", "us-east-2b", "us-east-2c"]
  },
  {
    name               = "loki"
    workload           = "loki"
    ami_family         = "Bottlerocket"
    ami_ssm            = "/aws/service/bottlerocket/aws-k8s-1.31/x86_64/latest/image_id"
    instance_family    = ["t3", "c7i-flex", "m7i-flex"]
    instance_sizes     = ["small", "large"]
    capacity_type      = ["on-demand", "spot"]
    availability_zones = ["us-east-2a", "us-east-2b", "us-east-2c"]
  },
  {
    name               = "tempo"
    workload           = "tempo"
    ami_family         = "Bottlerocket"
    ami_ssm            = "/aws/service/bottlerocket/aws-k8s-1.31/x86_64/latest/image_id"
    instance_family    = ["t3", "c7i-flex", "m7i-flex"]
    instance_sizes     = ["small", "large"]
    capacity_type      = ["on-demand", "spot"]
    availability_zones = ["us-east-2a", "us-east-2b", "us-east-2c"]
  },
  {
    name               = "mimir"
    workload           = "mimir"
    ami_family         = "Bottlerocket"
    ami_ssm            = "/aws/service/bottlerocket/aws-k8s-1.31/x86_64/latest/image_id"
    instance_family    = ["t3", "c7i-flex", "m7i-flex"]
    instance_sizes     = ["small", "large"]
    capacity_type      = ["on-demand", "spot"]
    availability_zones = ["us-east-2a", "us-east-2b", "us-east-2c"]
  }
]