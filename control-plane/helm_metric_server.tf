resource "helm_release" "metrics_server" {
  name = "metrics-server"
  #repository = "https://charts.bitnami.com/bitnami"
  repository = "https://kubernetes-sigs.github.io/metrics-server/"
  chart      = "metrics-server"
  namespace  = "kube-system"

  wait = false

  version = "3.12.1"

  set {
    name  = "apiService.create"
    value = "true"
  }

  set {
    name  = "args"
    value = "{--kubelet-insecure-tls}"
  }

  set {
    name  = "serviceMonitor.enabled"
    value = "true"
  }

  depends_on = [
    aws_eks_cluster.main
  ]
}
