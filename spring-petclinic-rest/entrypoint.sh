#!/bin/sh

java \
  -Dspring.profiles.active=postgres,spring-data-jpa \
  -Dspring.datasource.url=jdbc:postgresql://${DB_HOST}:${DB_PORT}/${DB_NAME} \
  -Dspring.datasource.username=${DB_USER} \
  -Dspring.datasource.password=${DB_PASSWORD} \
  -jar app.jar
