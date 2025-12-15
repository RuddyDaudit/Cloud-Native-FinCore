# Cloud-Native-FinCore
Ingénierie Cloud Native : Application Java/Spring Boot déployée et gérée de bout en bout sur un cluster Kubernetes, avec Infrastructure as Code (IaC) via Terraform.

# 🏦 Cloud-Native-FinCore: Distributed Banking Infrastructure

> **Architecture Microservices Bancaire déployée sur Kubernetes via Terraform (Infrastructure as Code).**

## 📋 Présentation du Projet

**Cloud-Native-FinCore** est une refonte architecturale d'un système de simulation bancaire. L'objectif de ce projet n'est pas seulement de simuler des transactions financières, mais de démontrer la mise en œuvre d'une chaîne de déploiement **Cloud Native** complète, robuste et automatisée.

Ce projet illustre la transition d'une application Java monolithique vers une architecture distribuée, conteneurisée et orchestrée, répondant aux standards industriels exigeants (Banque, Défense, Systèmes Critiques).

### 🏗️ Architecture Technique

Le système est composé de microservices autonomes communiquant via REST API :

* **Transaction-Service (Front Office) :** Point d'entrée, gestion des demandes clients.
* **Validation-Service (Middle Office) :** Moteur de règles métier (Compliance, plafonds).
* **Settlement-Service (Back Office) :** Enregistrement et finalisation des opérations.
* **Infrastructure :** Cluster Kubernetes provisionné dynamiquement via Terraform.

## 🛠️ Stack Technologique

* **Back-End :** Java 17, Spring Boot 3 (Web, Actuator)
* **Conteneurisation :** Docker, Docker Hub
* **Orchestration :** Kubernetes (K8s), Minikube
* **Infrastructure as Code (IaC) :** Terraform (HCL)
* **CI/CD & Tools :** Maven, Git

---

## 📅 Roadmap de Réalisation (Suivi de Projet)

Ce projet suit une méthodologie rigoureuse de transformation en 4 phases.

### 🔹 Phase 1 : Développement & Conteneurisation (Java/Docker)
- [ ] Initialisation des 3 microservices Spring Boot (Transaction, Validation, Settlement)
- [ ] Implémentation de la logique métier (Front/Middle/Back)
- [ ] Mise en place de la communication inter-services (RestTemplate/WebClient)
- [ ] Création des Dockerfiles optimisés (Multi-stage build)
- [ ] Création du réseau Docker et tests de communication inter-conteneurs

### 🔹 Phase 2 : Orchestration Kubernetes (K8s)
- [ ] Configuration de l'environnement local (Minikube)
- [ ] Rédaction des manifestes `Deployment.yaml` pour la haute disponibilité (Replicas)
- [ ] Configuration des `Service.yaml` (ClusterIP) pour la découverte de services
- [ ] Externalisation de la configuration (ConfigMaps & Secrets)
- [ ] Injection des variables d'environnement dans les Pods
- [ ] Vérification de la résilience (Self-healing, Logs)

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

### 1. Construction des Artefacts
```bash
# Dans chaque dossier de service (transaction, validation, settlement)
mvn clean package
docker build -t votre-user/nom-service:v1 .
