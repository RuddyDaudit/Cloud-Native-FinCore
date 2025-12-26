# Cloud-Native-FinCore
Ingénierie Cloud Native : Application Java/Spring Boot déployée et gérée de bout en bout sur un cluster Kubernetes, avec Infrastructure as Code (IaC) via Terraform.

# 🏦 Cloud-Native-FinCore: Distributed Banking Infrastructure

> **Architecture Microservices Bancaire déployée sur Kubernetes via Terraform (Infrastructure as Code).**

## 📋 Présentation du Projet

**Cloud-Native-FinCore** est une refonte architecturale d'un système de simulation bancaire. L'objectif de ce projet n'est pas seulement de simuler des transactions financières, mais de démontrer la mise en œuvre d'une chaîne de déploiement **Cloud Native** complète, robuste et automatisée.

Ce projet illustre la transition d'une application Java monolithique vers une architecture distribuée, conteneurisée et orchestrée, répondant aux standards industriels exigeants (Banque, Défense, Systèmes Critiques).

### 🏗️ Architecture Technique

Le système repose sur une communication inter-services fluide au sein d'un maillage Kubernetes :

Transaction-Service : Point d'entrée (Port 8082), orchestre le flux transactionnel.

Validation-Service : Moteur de conformité (Port 8081), valide l'intégrité des flux.

Service Discovery : Utilisation du DNS interne K8s (validation-app) pour supprimer les dépendances d'IP statiques.

## 🛠️ Stack Technologique

Back-End : Java 17, Spring Boot 3, Spring REST.

Orchestration : Kubernetes (Minikube), Docker Desktop.

Réseau : K8s Services (NodePort & ClusterIP), DNS interne.

IaC : Terraform (Provider Kubernetes).

---

## 📅 Roadmap de Réalisation (Suivi de Projet)

Ce projet suit une méthodologie rigoureuse de transformation en 4 phases.

### 🔹 Phase 1 : Développement & Conteneurisation (Java/Docker)
- [x] Initialisation des 3 microservices Spring Boot (Transaction, Validation, Settlement)
- [x] Implémentation de la logique métier (Front/Middle/Back)
- [x] Mise en place de la communication inter-services (RestTemplate/WebClient)
- [x] Création des Dockerfiles optimisés (Multi-stage build)
- [x] Création du réseau Docker et tests de communication inter-conteneurs

### 🔹 Phase 2 : Orchestration Kubernetes (K8s)
- [x] Configuration de l'environnement local (Minikube)
- [x] Rédaction des manifestes `Deployment.yaml` pour la haute disponibilité (Replicas)
- [x] Configuration des `Service.yaml` (ClusterIP) pour la découverte de services
- [x] Externalisation de la configuration (ConfigMaps & Secrets)
- [x] Injection des variables d'environnement dans les Pods
- [x] Vérification de la résilience (Self-healing, Logs)

### 🔹 Phase 3 : Industrialisation (Infrastructure as Code)
- [ ] Installation et configuration du Provider Terraform Kubernetes
- [ ] Traduction des manifestes YAML en configurations Terraform (HCL)
- [ ] Automatisation du provisionnement de l'infrastructure (`terraform apply`)
- [ ] Validation du déploiement complet "Zéro touche manuelle"

### 🔹 Phase 4 : Observabilité & Documentation
- [ ] Documentation technique et guide de déploiement
- [ ] (Bonus) Mise en place d'un Dashboard de monitoring

---

## 🚀 Guide de Démarrage Rapide

### Prérequis
* Docker & Minikube installés
* Terraform installé
* Java 17 & Maven

1. Préparation des Images
Bash

# Build et chargement dans le cluster
docker build -t validation-service:latest ./validation-service
minikube image load validation-service:latest
2. Déploiement Kubernetes
Bash

kubectl apply -f k8s/validation-deployment.yaml
kubectl apply -f k8s/validation-service.yaml
3. Test du flux de bout en bout
Une fois le tunnel activé via minikube service transaction-service --url, tester le point d'entrée :

Bash

curl -X POST http://<URL_MINIKUBE>/api/transaction \
     -H "Content-Type: application/json" \
     -d '{"id": 1, "amount": 100.0}'
Résultat attendu : VALIDATED (Preuve de la communication réussie entre Transaction et Validation).
