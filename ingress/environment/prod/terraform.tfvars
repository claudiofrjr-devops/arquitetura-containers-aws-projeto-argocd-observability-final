project_name = "linuxtips-ingress"

region = "us-east-2"

ssm_vpc = "/eks-cluster-core-base/vpc/id"

ssm_subnets = [
  "/eks-cluster-core-base/subnets/public/us-east-2a/bms-public-subnet-2a",
  "/eks-cluster-core-base/subnets/public/us-east-2b/bms-public-subnet-2b",
  "/eks-cluster-core-base/subnets/public/us-east-2c/bms-public-subnet-2c"
]

routing_weight = {
  cluster_01 = 50
  cluster_02 = 50
}

dns_name            = "*.allcloudi.shop"
route53_hosted_zone = "Z035534023DDKRCAEK0AO"