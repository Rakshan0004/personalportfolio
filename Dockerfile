# Use OpenJDK 17 as base image
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /app

# Copy Maven wrapper and pom.xml
COPY mvnw .
COPY mvnw.cmd .
COPY .mvn .mvn
COPY pom.xml .

# Make Maven wrapper executable
RUN chmod +x ./mvnw

# Copy source code
COPY src ./src

# Build the application
RUN ./mvnw clean package -DskipTests

# Create a startup script
RUN echo '#!/bin/bash\necho "Starting Spring Boot application..."\necho "Java version:"\njava -version\necho "JAR file exists:"\nls -la target/personalportfolio-0.0.1-SNAPSHOT.jar\necho "Starting application on port $PORT"\nexec java -jar target/personalportfolio-0.0.1-SNAPSHOT.jar' > start.sh
RUN chmod +x start.sh

# Expose port
EXPOSE 10000

# Run the startup script
CMD ["./start.sh"]