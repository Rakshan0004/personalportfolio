# Docker Deployment for Personal Portfolio

This document provides instructions for deploying the Personal Portfolio Spring Boot application using Docker on Render.

## Files Created

- `Dockerfile` - Multi-stage Docker build configuration
- `.dockerignore` - Excludes unnecessary files from Docker build context
- `docker-compose.yml` - Local development and testing setup

## Local Testing

### Prerequisites
- Docker installed on your machine
- Docker Compose (usually comes with Docker Desktop)

### Build and Run Locally

1. **Build the Docker image:**
   ```bash
   docker build -t personalportfolio .
   ```

2. **Run the container:**
   ```bash
   docker run -p 8080:8080 personalportfolio
   ```

3. **Or use Docker Compose:**
   ```bash
   docker-compose up --build
   ```

4. **Access the application:**
   Open your browser and navigate to `http://localhost:8080`

## Render Deployment

### Step 1: Prepare Your Repository

1. Ensure all Docker files are committed to your Git repository
2. Make sure your repository is accessible (GitHub, GitLab, or Bitbucket)

### Step 2: Create a New Web Service on Render

1. Go to [Render Dashboard](https://dashboard.render.com/)
2. Click "New +" and select "Web Service"
3. Connect your Git repository

### Step 3: Configure the Service

**Basic Settings:**
- **Name:** `personal-portfolio` (or your preferred name)
- **Environment:** `Docker`
- **Region:** Choose the closest region to your users
- **Branch:** `main` (or your default branch)

**Advanced Settings:**
- **Dockerfile Path:** `personalportfolio/Dockerfile` (since your Dockerfile is in the personalportfolio subdirectory)
- **Root Directory:** `personalportfolio` (this tells Render to use the personalportfolio folder as the build context)

**Environment Variables:**
- `PORT`: `8080` (Render will automatically set this, but you can specify it)
- `JAVA_OPTS`: `-Xmx512m -Xms256m` (adjust memory settings as needed)

### Step 4: Deploy

1. Click "Create Web Service"
2. Render will automatically:
   - Clone your repository
   - Build the Docker image using your Dockerfile
   - Deploy the container
   - Provide you with a public URL

### Step 5: Custom Domain (Optional)

1. In your service settings, go to "Custom Domains"
2. Add your domain name
3. Follow Render's instructions to configure DNS

## Important Notes

### Memory Configuration
The Dockerfile is configured with:
- Initial heap size: 256MB (`-Xms256m`)
- Maximum heap size: 512MB (`-Xmx512m`)

Adjust these values based on your Render plan:
- **Free tier:** Keep current settings or reduce to `-Xmx256m`
- **Starter plan:** Can increase to `-Xmx1g`
- **Standard plan and above:** Can use `-Xmx2g` or higher

### Port Configuration
- The application is configured to run on port 8080
- Render automatically maps the `PORT` environment variable
- The Dockerfile includes `ENV PORT=8080` for compatibility

### Health Checks
- The Dockerfile includes a health check that pings the root endpoint
- Render will use this to monitor your application's health

## Troubleshooting

### Build Failures
1. Check that your Dockerfile path is correct in Render settings
2. Ensure all required files are committed to your repository
3. Verify that the Maven wrapper files (`mvnw`, `mvnw.cmd`, `.mvn/`) are present

### Runtime Issues
1. Check the Render service logs for error messages
2. Verify that the application starts successfully locally
3. Ensure all static resources (CSS, JS, images) are properly included

### Performance Issues
1. Monitor memory usage in Render dashboard
2. Adjust `JAVA_OPTS` environment variables if needed
3. Consider upgrading your Render plan for better performance

## Security Considerations

- The Docker image runs as a non-root user (`spring`)
- Only necessary files are included in the final image
- The `.dockerignore` file excludes sensitive files and build artifacts

## Cost Optimization

- The multi-stage build reduces the final image size
- Using `openjdk:17-jre-slim` instead of the full JDK reduces image size
- Layer caching optimizes build times and reduces bandwidth usage
