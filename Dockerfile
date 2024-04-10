# Use a base image with Maven and OpenJDK
FROM maven:3.8.4-openjdk-11 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the Maven project file
COPY pom.xml .

# Copy the source code
COPY src ./src

# Build the application with Maven
RUN mvn clean package

# Use a lightweight base image with JRE
FROM openjdk:11-jre-slim

# Set the working directory in the container
WORKDIR /app

# Copy the built JAR file from the previous stage
COPY --from=build /app/target/spring-boot-2-hello-world-1.0.2-SNAPSHOT.jar spring-boot-2-hello-world-1.0.2-SNAPSHOT.jar

# Expose the port that the application will run on
EXPOSE 8080

# Define the command to run the application
CMD ["java", "-jar", "spring-boot-2-hello-world-1.0.2-SNAPSHOT.jar"]
