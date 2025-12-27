# 1. Le Service (Réseau)
resource "kubernetes_service" "validation_app" {
  metadata {
    name = "validation-app"
  }
  spec {
    selector = {
      app = "validation"
    }
    port {
      port        = 8081
      target_port = 8081
    }
    type = "ClusterIP"
  }
}

# 2. Le Deployment (Les instances de l'application)
resource "kubernetes_deployment" "validation_deployment" {
  metadata {
    name = "validation-deployment"
    labels = {
      app = "validation"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "validation"
      }
    }

    template {
      metadata {
        labels = {
          app = "validation"
        }
      }

      spec {
        container {
          name  = "validation-service"
          image = "validation-service:latest"
          image_pull_policy = "Never"

          port {
            container_port = 8081
          }

          # --- AJOUT DES HEALTH CHECKS ---
          # Kubernetes attend que ce endpoint réponde 200 OK avant d'envoyer du trafic
        readiness_probe {
            tcp_socket {
              port = 8081 # Mets 8082 pour transaction.tf
            }
            initial_delay_seconds = 5
            period_seconds        = 5
          }

          liveness_probe {
            tcp_socket {
              port = 8081 # Mets 8082 pour transaction.tf
            }
            initial_delay_seconds = 10
            period_seconds        = 10
          }
        }
      }
    }
  }
}