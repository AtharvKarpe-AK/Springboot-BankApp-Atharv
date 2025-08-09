FROM maven:3.8.4-openjdk-17 AS builder

WORKDIR /app

COPY . /app

RUN mvn clean install -Dmaven.test.skip=true

FROM openjdk:17-alpine

WORKDIR /app

COPY --from=builder /app/target/*.jar bankapp.jar


EXPOSE 8080

CMD ["java","-jar","/app/bankapp.jar"]
