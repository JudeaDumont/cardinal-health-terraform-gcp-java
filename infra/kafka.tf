resource "kubernetes_namespace" "kafka_namespace" {
  metadata {
    name = "kafka"
  }
}

resource "kubernetes_manifest" "strimzi_operator" {
  manifest = file("${path.module}/strimzi-config/strimzi-cluster-operator-0.34.0.yaml")
  depends_on = [kubernetes_namespace.kafka_namespace]
}

resource "kubernetes_manifest" "kafka_cluster" {
  manifest = {
    apiVersion = "kafka.strimzi.io/v1beta2"
    kind       = "Kafka"
    metadata = {
      name      = "kafka-cluster"
      namespace = kubernetes_namespace.kafka_namespace.metadata[0].name
    }
    spec = {
      kafka = {
        replicas  = 3
        listeners = [
          {
            name = "plain"
            port = 9092
            type = "internal"
            tls  = false
          }
        ]
        storage = {
          type = "ephemeral"
          size = "10Gi"
          class = "standard"
        }
      }
      zookeeper = {
        replicas = 3
        storage = {
          type = "ephemeral"
          size = "10Gi"
          class = "standard"
        }
      }
      entityOperator = {
        topicOperator = {}
        userOperator  = {}
      }
    }
  }

  depends_on = [kubernetes_manifest.strimzi_operator]
}

resource "kubernetes_manifest" "kafka_load_balancer" {
  manifest = {
    apiVersion = "v1"
    kind       = "Service"
    metadata = {
      name      = "kafka-cluster"
      namespace = kubernetes_namespace.kafka_namespace.metadata[0].name
    }
    spec = {
      type = "LoadBalancer"
      ports = [
        {
          port       = 9094
          targetPort = 9092
          protocol   = "TCP"
        }
      ]
      selector = {
        "strimzi.io/cluster" = "kafka-cluster"
        "strimzi.io/name"    = "kafka-cluster-strimzi"
      }
    }
  }
  depends_on = [kubernetes_manifest.kafka_cluster]
}