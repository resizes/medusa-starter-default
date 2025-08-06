# Development Dockerfile for Medusa
FROM node:20-slim

# Set working directory
WORKDIR /server

# Copy package files and npm config
COPY package.json package-lock.json ./

# Install all dependencies using npm
RUN npm ci

# Copy source code
COPY . .

# Expose the port Medusa runs on
EXPOSE 9000

# Start with migrations and then the development server
CMD ["./start.sh"]