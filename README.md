Objective:
Build and run a simple "Hello World" Java application using Docker and Maven across different Java environments: Java 8, Java 11, and Java 17. This comprehensive assignment encompasses Docker image creation, Java project management with Maven, and handling different Java environments.

Pre-requisites:
Docker and Docker Compose installed on your machine.
Basic understanding of Java, Docker, Maven, and command-line operations.
Basic familiarity with the YAML file format.
Assignment Tasks:
Task 1: Java Project Setup and Maven Configuration
Create a Maven Project:

Initialize a Maven project with a HelloWorld class that prints a message to the console. You can use mvn archetype:generate to generate a simple project structure.
Configure Maven for Multiple Java Versions:

Edit the pom.xml to set up profiles for Java 8, Java 11, and Java 17, including the Maven Compiler Plugin configurations for each version. Ensure your project builds successfully for each Java version.
pom.xml Sample :

// <?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>com.example.helloworld</groupId>
    <artifactId>maven-archetype-quickstart</artifactId>
    <version>1.0-SNAPSHOT</version>

    <properties>
        <maven.compiler.source>17</maven.compiler.source>
        <maven.compiler.target>17</maven.compiler.target>
    </properties>
    <profiles>
    <profile>
        <id>java8</id>
        <activation>
            <activeByDefault>true</activeByDefault>
        </activation>
        <properties>
            <maven.compiler.source>1.8</maven.compiler.source>
            <maven.compiler.target>1.8</maven.compiler.target>
        </properties>
    </profile>
    <profile>
        <id>java11</id>
        <properties>
            <maven.compiler.source>11</maven.compiler.source>
            <maven.compiler.target>11</maven.compiler.target>
        </properties>
    </profile>
    <profile>
        <id>java17</id>
        <properties>
            <maven.compiler.source>17</maven.compiler.source>
            <maven.compiler.target>17</maven.compiler.target>
        </properties>
    </profile>
</profiles>


</project>
//
pom.xmlDownload pom.xml

Task 2: Dockerfile Creation for Multi-Version Builds
Write a Multi-Stage Dockerfile:
Create a Dockerfile in the root directory with multi-stage builds for each Java version (Java 8, Java 11, Java 17). Each stage should use the corresponding official Java Docker image, copy your project files, and use Maven to build your project.
Dockerfile Sample :
//
# Stage 1: Build with Java 8
FROM maven:3.8.4-openjdk-8 AS build-java8
COPY . /app
WORKDIR /app
RUN mvn package -Pjava8

# Stage 2: Build with Java 11 (not used in final image, just an example)
FROM maven:3.8.4-openjdk-11 AS build-java11
COPY . /app
WORKDIR /app
RUN mvn package -Pjava11

# Stage 3: Build with Java 17 (not used in final image, just an example)
FROM maven:3.8.4-openjdk-17 AS build-java17
COPY . /app
WORKDIR /app
RUN mvn package -Pjava17

# Final stage: Create a minimal runtime image for Java 8 build
FROM openjdk:8-jre-slim AS runtime-java8
COPY --from=build-java8 /app/target/maven-archetype-quickstart-1.0-SNAPSHOT.jar /app/application.jar
WORKDIR /app
CMD ["java", "-jar", "application.jar"]

//


DockerFile.txt Download DockerFile.txt(Sample Rename it accordingly)

Build Docker Images for Each Java Version:

Document commands needed to build Docker images for each Java version, tagging each one appropriately.
Run Containers for Each Java Version:

Provide commands to run Docker containers from each built image, ensuring they correctly execute your Java application.
Task 3: Testing, Verification, and Documentation
Application Testing:

Verify your application by accessing and testing the running Docker containers for each Java version. Note any differences or issues.
Documentation:

Document the setup process, including how to configure Maven, create the Dockerfile, build the Docker images, and run the containers for each Java version.
Include clear step-by-step instructions and explanations for all parts of the assignment.
Task 4: Submission and Cleanup
Submit your Java source code, pom.xml, Dockerfile, and any other supplementary files.
Include a README with comprehensive instructions for:
Building and running the Maven project for different Java versions.
Building Docker images and running containers for each Java version.
Document any challenges faced and how you overcame them, plus any notable observations about the application behavior under different Java versions.
Provide commands for cleaning up after testing: stopping and removing containers, and removing Docker images.



to execute: 

mvn clean package -Pjava8
mvn clean package -Pjava11
mvn clean package -Pjava17




docker build --target build-java8 -t helloworld-java8 .
docker build --target build-java11 -t helloworld-java11 .
docker build --target build-java17 -t helloworld-java17 .



//cleanup 

docker image rm helloworld-java8 helloworld-java11 helloworld-java17

