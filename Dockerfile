# Use OpenJDK 17 as base image
FROM openjdk:17-jdk-slim

# Install bash for our startup script
RUN apt-get update && apt-get install -y bash && rm -rf /var/lib/apt/lists/*

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

# Verify the JAR was built
RUN ls -la target/

# Create a proper startup script
RUN cat > start.sh << 'EOF'
#!/bin/bash
set -e

echo "=== Spring Boot Application Startup ==="
echo "Java version:"
java -version

echo -e "\nJAR file details:"
ls -la target/personalportfolio-0.0.1-SNAPSHOT.jar

echo -e "\nEnvironment variables:"
echo "PORT: ${PORT:-10000}"

echo -e "\nStarting Spring Boot application..."
echo "Command: java -Dserver.port=${PORT:-10000} -jar target/personalportfolio-0.0.1-SNAPSHOT.jar"

exec java -Dserver.port=${PORT:-10000} -jar target/personalportfolio-0.0.1-SNAPSHOT.jar
EOF

RUN chmod +x start.sh

# Expose port
EXPOSE 10000

# Run the startup script
CMD ["bash", "./start.sh"]