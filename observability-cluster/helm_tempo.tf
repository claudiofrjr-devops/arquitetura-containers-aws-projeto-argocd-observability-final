resource "helm_release" "tempo" {
  name       = "tempo"
  chart      = "tempo-distributed"
  repository = "https://grafana.github.io/helm-charts"
  namespace  = "tempo"

  version = "1.61.3"

  create_namespace = true

  values = [
    local.tempo["values"]
  ]


  depends_on = [
    helm_release.karpenter,
    aws_eks_pod_identity_association.tempo,
    aws_eks_addon.ebs_csi
  ]
}