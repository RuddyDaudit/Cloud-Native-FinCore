# On utilise une image Java légère
FROM eclipse-temurin:21-jdk-alpine

# On définit le dossier de travail
WORKDIR /app

# On copie le fichier JAR généré précédemment dans l'image
COPY target/*.jar app.jar

# La commande pour lancer le microservice
ENTRYPOINT ["java", "-jar", "app.jar"]