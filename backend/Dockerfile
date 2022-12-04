# syntax=docker/dockerfile:1

FROM eclipse-temurin:19.0.1_10-jdk
# Working directory
WORKDIR /app
# Copio le dipendenze
COPY .mvn/ .mvn
COPY mvnw pom.xml ./
# Installo le dipendenze nell'immagine
# Ricorda di cambiare Line Separator da Windows a Linux
RUN ./mvnw dependency:resolve
# Copio il codice sorgente
COPY src ./src
# Avvio il server, aggiungendo il profilo MySQL
CMD ["./mvnw", "spring-boot:run"]
