# Déploiement du Validation Service
resource "kubernetes_deployment" "validation_app" {
  metadata {
    name = "validation-app"
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
          image = "validation-service:latest" # Assure-toi que c'est le bon nom d'image
          
          # Équivalent de imagePullPolicy: Never
          image_pull_policy = "Never"

          port {
            container_port = 8081
          }
        }
      }
    }
  }
}

# Service pour le Validation Service
resource "kubernetes_service" "validation_service" {
  metadata {
    name = "validation-app" # Le DNS interne que ton code Java utilise
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