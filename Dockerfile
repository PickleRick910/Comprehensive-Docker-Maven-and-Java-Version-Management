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
