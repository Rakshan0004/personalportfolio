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
RUN printf '#!/bin/bash\nset -e\n\necho "=== Spring Boot Application Startup ==="\necho "Java version:"\njava -version\n\necho -e "\\nJAR file details:"\nls -la target/personalportfolio-0.0.1-SNAPSHOT.jar\n\necho -e "\\nEnvironment variables:"\necho "PORT: ${PORT:-10000}"\n\necho -e "\\nStarting Spring Boot application..."\necho "Command: java -Dserver.port=${PORT:-10000} -Dserver.address=0.0.0.0 -jar target/personalportfolio-0.0.1-SNAPSHOT.jar"\n\nexec java -Dserver.port=${PORT:-10000} -Dserver.address=0.0.0.0 -jar target/personalportfolio-0.0.1-SNAPSHOT.jar' > start.sh

RUN chmod +x start.sh

# Expose port
EXPOSE 10000

# Run the startup script
CMD ["bash", "./start.sh"]