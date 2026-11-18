# Stage 1: Build & Run Environment
FROM node:20-alpine

WORKDIR /app

# Copy dependency definitions
COPY package*.json ./

# Install all dependencies (including devDependencies required for vite build)
RUN npm install

# Copy application source code
COPY . .

# Build the client application
RUN npm run build

# Expose backend port
ENV PORT=5000
ENV NODE_ENV=production
EXPOSE 5000

# Start server
CMD ["npm", "start"]
