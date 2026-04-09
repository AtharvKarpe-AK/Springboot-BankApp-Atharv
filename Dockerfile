FROM maven:3.8.4-eclipse-temurin-17-alpine AS builder

WORKDIR /app

COPY . /app

RUN mvn clean install -Dmaven.test.skip=true

FROM eclipse-temurin:21-jdk-alpine

WORKDIR /app

COPY --from=builder /app/target/*.jar bankapp.jar


EXPOSE 9090

CMD ["java","-jar","/app/bankapp.jar"]
