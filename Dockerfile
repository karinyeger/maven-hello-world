FROM maven:3.8-openjdk-17-slim AS build

WORKDIR /myapp

COPY ./myapp/pom.xml .
COPY ./myapp/src ./src/

RUN mvn clean package

FROM openjdk:17.0.1-jdk-slim

WORKDIR /myapp

COPY --from=build /myapp/target/*.jar myapp.jar

RUN useradd appuser

USER appuser

CMD ["java", "-jar", "myapp.jar"]