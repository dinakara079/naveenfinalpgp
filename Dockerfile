# Use an official Maven runtime as a base image
FROM maven:3.8.4-openjdk-11-slim AS build

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy the Maven project files
COPY pom.xml .
COPY src src

# Build the Maven project
RUN mvn clean install

# Use an official Tomcat runtime as a base image for the deployment stage
FROM tomcat:9-jdk11-openjdk-slim

# Set the working directory in the container
WORKDIR /usr/local/tomcat/webapps

# Copy the built WAR file from the Maven build stage to the Tomcat webapps directory
COPY /usr/src/app/target/XYZtechnologies-1.0.war .

# Expose the default Tomcat port
EXPOSE 8080

# Start Tomcat when the container launches
CMD ["catalina.sh", "run"]
