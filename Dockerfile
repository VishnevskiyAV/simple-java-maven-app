FROM openjdk:12-alpine

ADD target/*.jar /app.jar

CMD ["java" , "-jar", "/app.jar"]