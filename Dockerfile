# Development Dockerfile for Medusa
FROM node:20-alpine

# Set working directory
WORKDIR /server

# Copy package files and yarn config
COPY package.json yarn.lock .yarnrc.yml ./

# Copy source code
COPY . .

RUN npx medusa build && cd ./medusa/server && yarn install --network-timeout 1000000

# Expose the port Medusa runs on
EXPOSE 9000

# Start with migrations and then the development server
CMD ["sh", "-c", "cd ./medusa/server && yarn run start"]