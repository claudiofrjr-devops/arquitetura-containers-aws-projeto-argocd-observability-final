locals {
  grafana = {
    values : <<-VALUES
adminUser: admin
adminPassword: Aline#0608312612@
        
persistence:
    enabled: true
    size: 10Gi
    storageClassName: efs-grafana
service:
    type: ClusterIP
initChownData:
    enabled: false

nodeSelector:
    karpenter.sh/nodepool: grafana


datasources:
  datasources.yaml:
    apiVersion: 1
    datasources:
      - name: Loki
        type: loki
        access: proxy
        url: http://loki-gateway.loki.svc.cluster.local
        isDefault: false
        jsonData:
          maxLines: 500

      - name: Tempo
        type: tempo
        access: proxy
        url: http://tempo-gateway.tempo.svc.cluster.local
        basicAuth: false

  VALUES
  }

  loki = {
    values : <<-VALUES
  loki:
      auth_enabled: false

      commonConfig:
        replication_factor: 1

      schemaConfig:
          configs:
          - from: "2024-04-01"
            store: tsdb
            object_store: s3
            schema: v13
            index:
              prefix: loki_index_
              period: 24h
      storage_config:
          aws:
              region: ${var.region}
              bucketnames: ${aws_s3_bucket.loki-chunks.id}
              s3forcepathstyle: false
      storage:
          type: s3
          bucketNames:
              chunks: ${aws_s3_bucket.loki-chunks.id}
              ruler: ${aws_s3_bucket.loki-ruler.id}
              admin: ${aws_s3_bucket.loki-admin.id}
      ingester:
          chunk_encoding: snappy
      querier:
          # Default is 4, if you have enough memory and CPU you can increase, reduce if OOMing
          max_concurrent: 4
      pattern_ingester:
          enabled: true
      limits_config:
          allow_structured_metadata: true
          volume_enabled: true
          retention_period: 672h

  deploymentMode: SimpleScalable

  chunksCache:
      allocatedMemory: 256
      resources:
          requests:
              cpu: 100m
              memory: 256Mi

  resultsCache:
      allocatedMemory: 256
      resources:
          requests:
              cpu: 100m
              memory: 256Mi

  backend:
      replicas: 1
      persistence:
          storageClass: gp3

      nodeSelector:
          karpenter.sh/nodepool: loki

      resources:
          requests:
              cpu: 200m
              memory: 256Mi

  read:
      replicas: 1

      nodeSelector:
          karpenter.sh/nodepool: loki

      resources:
          requests:
              cpu: 200m
              memory: 256Mi

  write:
      replicas: 1 # To ensure data durability with replication
      persistence:
          storageClass: gp3

      nodeSelector:
          karpenter.sh/nodepool: loki    

      resources:
          requests:
              cpu: 200m
              memory: 256Mi    

  gateway:
      replicas: 1
      service:
          type: NodePort

      nodeSelector:
          karpenter.sh/nodepool: loki

      resources:
          requests:
              cpu: 100m
              memory: 256Mi

  minio:
      enabled: false

      VALUES
  }

  tempo = {
    values : <<-VALUES
    replication_factor: 1
    storage:
        trace:
            backend: s3
            s3:
                bucket: ${aws_s3_bucket.tempo.id}
                region: ${var.region}
                endpoint: s3.amazonaws.com
                forcepathstyle: false
    gateway:
        enabled: true
        replicas: 1
        service:
            type: NodePort
        nodeSelector:
            karpenter.sh/nodepool: tempo

    queryFrontend:
        replicas: 1
        query:
            enabled: false
        nodeSelector:
            karpenter.sh/nodepool: tempo

    querier:
        replicas: 1
        nodeSelector:
            karpenter.sh/nodepool: tempo
               
    distributor:
        enabled: true
        replicas: 1
        nodeSelector:
            karpenter.sh/nodepool: tempo

    ingester:
        replicas: 1

        config:
            replication_factor: 1

        nodeSelector:
            karpenter.sh/nodepool: tempo

    compactor:
        replicas: 1
        nodeSelector:
            karpenter.sh/nodepool: tempo
    traces:
        otlp:
            http:
                enabled: true
        grpc:
            enabled: true
        VALUES
  }
}