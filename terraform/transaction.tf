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

          # C'est ici que la magie de l'interconnexion opère !
          env {
            name  = "VALIDATION_SERVICE_URL"
            value = "http://validation-app:8081"
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
      node_port   = 30082 # On fixe le port pour ne plus le chercher !
    }
    type = "NodePort"
  }
}