resource "aws_security_group_rule" "nodeports" {
  cidr_blocks = ["0.0.0.0/0"]
  from_port   = 30000
  to_port     = 32768
  protocol    = "tcp"
  type        = "ingress"
  description = "NodePorts"

  security_group_id = aws_eks_cluster.main.vpc_config[0].cluster_security_group_id

}

resource "aws_security_group_rule" "coredns_udp" {
  cidr_blocks = ["100.64.0.0/16"]
  from_port   = 53
  to_port     = 53
  protocol    = "udp"
  type        = "ingress"
  description = "CoreDNS_UDP"

  security_group_id = aws_eks_cluster.main.vpc_config[0].cluster_security_group_id

}

resource "aws_security_group_rule" "coredns_tcp" {
  cidr_blocks = ["100.64.0.0/16"]
  from_port   = 53
  to_port     = 53
  protocol    = "tcp"
  type        = "ingress"
  description = "CoreDNS_TCP"

  security_group_id = aws_eks_cluster.main.vpc_config[0].cluster_security_group_id

}

resource "aws_security_group_rule" "ingress_karpenter_api" {
  description       = "Permite que os pods do Karpenter falem com a API do EKS"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["100.64.0.0/16"] # Range de PODS
  security_group_id = aws_eks_cluster.main.vpc_config[0].cluster_security_group_id
}

resource "aws_security_group_rule" "cluster" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  description       = "all"
  type              = "ingress"
  security_group_id = aws_eks_cluster.main.vpc_config[0].cluster_security_group_id
}