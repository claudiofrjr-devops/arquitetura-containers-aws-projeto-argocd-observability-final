resource "aws_eks_cluster" "main" {
  name    = var.project_name
  version = var.k8s_version

  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = data.aws_ssm_parameter.subnets[*].value
    # Se quiser acesso privado ao cluster, setar como true
    endpoint_private_access = true
    endpoint_public_access  = true
    # Permite acesso publico ao cluster, se quiser pode colocar o IP da sua maquina ou CIDR
    public_access_cidrs = concat(["177.62.76.219/32"],
      [for nat in data.aws_nat_gateway.nats : "${nat.public_ip}/32"] # Os IPs do ArgoCD (NATs)
    )
  }

  encryption_config {
    provider {
      key_arn = aws_kms_key.main.arn
    }
    resources = ["secrets"]
  }

  access_config {
    authentication_mode                         = "API_AND_CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  }

  enabled_cluster_log_types = [
    #"api", "audit", "authenticator", "controllerManager", "scheduler"
  ]

  zonal_shift_config {
    enabled = true
  }

  tags = {
    "kubernetes.io/cluster/${var.project_name}" = "shared"
  }

}