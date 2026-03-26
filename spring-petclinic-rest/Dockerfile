FROM maven:3.9.9-eclipse-temurin-21-alpine AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

FROM eclipse-temurin:25-jre-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 9966
ENTRYPOINT ["java", "-Dspring.profiles.active=postgres,spring-data-jpa", "-Dspring.datasource.url=jdbc:postgresql://petclinic-db/petclinic", "-jar", "app.jar"]
