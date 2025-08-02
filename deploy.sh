#!/bin/bash

# Deploy Script untuk Aplikasi Doorprize
# Author: Assistant
# Description: Script untuk deploy aplikasi doorprize ke VPS dengan Docker

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
APP_NAME="doorprize-firebase"
PORT="8888"
GIT_REPO="https://github.com/MozesJr/AplikasiUndian.git"
APP_DIR="/opt/doorprize"

echo -e "${BLUE}🚀 Starting deployment of Doorprize App...${NC}"

# Function to print colored output
print_status() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    print_error "Docker is not installed. Please install Docker first."
    exit 1
fi

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null; then
    print_error "Docker Compose is not installed. Please install Docker Compose first."
    exit 1
fi

# Stop existing container if running
if [ "$(docker ps -q -f name=$APP_NAME)" ]; then
    print_warning "Stopping existing container..."
    docker stop $APP_NAME
fi

# Remove existing container if exists
if [ "$(docker ps -aq -f name=$APP_NAME)" ]; then
    print_warning "Removing existing container..."
    docker rm $APP_NAME
fi

# Create app directory
print_status "Creating application directory..."
sudo mkdir -p $APP_DIR
cd $APP_DIR

# Clone or update repository
if [ -d ".git" ]; then
    print_status "Updating repository..."
    git pull origin main
else
    print_status "Cloning repository..."
    git clone $GIT_REPO .
fi

# Create logs directory
mkdir -p logs

# Build and start the application
print_status "Building Docker image..."
docker-compose build --no-cache

print_status "Starting application..."
docker-compose up -d

# Wait for container to be ready
print_status "Waiting for application to start..."
sleep 10

# Check if container is running
if [ "$(docker ps -q -f name=$APP_NAME)" ]; then
    print_status "Container is running successfully!"
    
    # Display container info
    echo -e "\n${BLUE}📊 Container Information:${NC}"
    docker ps -f name=$APP_NAME --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
    
    # Show application URLs
    echo -e "\n${GREEN}🌐 Application URLs:${NC}"
    echo -e "   Local: http://localhost:${PORT}"
    echo -e "   Server: http://$(curl -s ifconfig.me 2>/dev/null || echo 'YOUR_SERVER_IP'):${PORT}"
    
    # Show logs location
    echo -e "\n${BLUE}📝 Logs Location:${NC}"
    echo -e "   Application logs: ${APP_DIR}/logs/"
    echo -e "   Container logs: docker logs ${APP_NAME}"
    
    # Health check
    print_status "Performing health check..."
    if curl -f http://localhost:${PORT}/health &> /dev/null; then
        print_status "Health check passed! Application is ready."
    else
        print_warning "Health check failed. Check logs for details."
    fi
    
else
    print_error "Failed to start container. Check logs:"
    docker logs $APP_NAME
    exit 1
fi

echo -e "\n${GREEN}🎉 Deployment completed successfully!${NC}"
echo -e "${BLUE}💡 Useful commands:${NC}"
echo -e "   View logs: docker logs -f ${APP_NAME}"
echo -e "   Stop app: docker-compose down"
echo -e "   Restart: docker-compose restart"
echo -e "   Update: git pull && docker-compose up -d --build"