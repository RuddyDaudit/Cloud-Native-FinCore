resource "kubernetes_deployment" "settlement_app" {
  metadata {
    name = "settlement-app"
    labels = {
      app = "settlement"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "settlement"
      }
    }

    template {
      metadata {
        labels = {
          app = "settlement"
        }
      }

      spec {
        container {
          name  = "settlement-service"
          image = "settlement-service:latest"
          image_pull_policy = "Never"

          port {
            container_port = 8083  # Correction : guillemet supprimé
          }

          # Les probes sont parfaites pour la stabilité
          readiness_probe {
            tcp_socket { port = 8083 }
            initial_delay_seconds = 5
            period_seconds        = 5
          }

          liveness_probe {
            tcp_socket { port = 8083 }
            initial_delay_seconds = 10
            period_seconds        = 10
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "settlement" {
  metadata {
    name = "settlement-app" # IMPORTANT : Doit correspondre à l'URL dans TransactionController.java
  }
  spec {
    selector = {
      app = "settlement"
    }
    port {
      port        = 8083
      target_port = 8083
      node_port   = 30083
    }
    type = "NodePort"
  }
}