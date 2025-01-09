FROM maven:3.8-openjdk-17-slim AS build

WORKDIR /myapp

COPY pom.xml .
COPY src ./src

RUN mvn clean package -DskipTests

FROM openjdk:17-jre-slim

WORKDIR /myapp
 
ARG VERSION
RUN VERSION=$(mvn help:evaluate -Dexpression=project.version -q -DforceStdout)

COPY --from=build /myapp/target/myapp-${VERSION}.jar /myapp/myapp.jar

CMD ["java", "-jar", "myapp.jar"]