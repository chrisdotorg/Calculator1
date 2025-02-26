FROM maven:3.6.3-openjdk-17 AS BUILD
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src/ src/
RUN mvn clean package
FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
RUN ls -l /app
CMD [ "java","-jar","app.jar" ]