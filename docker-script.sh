#!/bin/bash
set -e
NETWORK="petclinic-net"
DB_VOL="petclinic-db-data"

echo "Removing old instances..."
docker rm -f petclinic-db petclinic-backend petclinic-frontend 2>/dev/null


docker network inspect $NETWORK >/dev/null 2>&1 || docker network create $NETWORK
docker volume inspect $DB_VOL >/dev/null 2>&1 || docker volume create $DB_VOL

echo "Building..."
docker build -t petclinic-db ./db
docker build -t petclinic-backend ./spring-petclinic-rest
docker build -t petclinic-frontend ./spring-petclinic-angular

echo "Database starting.aaaa.."
docker run -d --name petclinic-db --network $NETWORK -v $DB_VOL:/var/lib/postgresql/data petclinic-db
sleep 10 

echo "Backend starting..."
docker run -d --name petclinic-backend --network $NETWORK \
  -e SPRING_PROFILES_ACTIVE=postgresql \
  -e SPRING_DATASOURCE_URL=jdbc:postgresql://petclinic-db:5432/petclinic \
  -p 9966:9966 petclinic-backend

echo "Frontend started..."
docker run -d --name petclinic-frontend --network $NETWORK -p 8080:80 petclinic-frontend

echo "Everything ready!"
