resource "kubernetes_deployment" "transaction_app" {
  metadata {
    name = "transaction-app"
    labels = {
      app = "transaction"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "transaction"
      }
    }

    template {
      metadata {
        labels = {
          app = "transaction"
        }
      }

      spec {
        container {
          name  = "transaction-service"
          image = "transaction-service:latest"
          image_pull_policy = "Never"

          port {
            container_port = 8082
          }

          env {
            name  = "VALIDATION_SERVICE_URL"
            value = "http://validation-app:8081"
          }

          # --- AJOUT DES HEALTH CHECKS ---
          # On attend que Spring Boot soit prêt avant d'ouvrir le trafic sur le port 30082
        readiness_probe {
            tcp_socket {
              port = 8082 # Mets 8082 pour transaction.tf
            }
            initial_delay_seconds = 5
            period_seconds        = 5
          }

          liveness_probe {
            tcp_socket {
              port = 8082 # Mets 8082 pour transaction.tf
            }
            initial_delay_seconds = 10
            period_seconds        = 10
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "transaction_service" {
  metadata {
    name = "transaction-service"
  }
  spec {
    selector = {
      app = "transaction"
    }
    port {
      port        = 8082
      target_port = 8082
      node_port   = 30082
    }
    type = "NodePort"
  }
}