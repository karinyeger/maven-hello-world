FROM openjdk:17-jre-slim

WORKDIR /myapp

COPY target/myapp-${version}.jar /myapp/myapp.jar

CMD ["java", "-jar", "myapp.jar"]