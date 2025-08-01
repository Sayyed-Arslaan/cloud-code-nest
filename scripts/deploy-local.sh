#!/bin/bash

echo "🚀 CloudCode Server - Local Deployment Script"
echo "============================================="

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed. Please install Docker first."
    echo "Visit: https://docs.docker.com/get-docker/"
    exit 1
fi

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null && ! docker compose version &> /dev/null; then
    echo "❌ Docker Compose is not installed. Please install Docker Compose first."
    exit 1
fi

# Create .env file if it doesn't exist
if [ ! -f .env ]; then
    echo "📝 Creating .env file from template..."
    cp .env.example .env
    echo "✅ Please edit .env file with your settings before continuing."
    echo "   Minimum required: Set a secure PASSWORD"
    read -p "Press Enter to continue after editing .env..."
fi

# Load environment variables
source .env

# Validate required variables
if [ -z "$PASSWORD" ] || [ "$PASSWORD" = "cloudcode123" ]; then
    echo "⚠️  Warning: Using default password. Please set a secure PASSWORD in .env"
    read -p "Continue anyway? (y/n): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

echo "🔨 Building CloudCode Server..."
docker-compose build

echo "🚀 Starting CloudCode Server..."
docker-compose up -d

# Wait for service to be ready
echo "⏳ Waiting for server to start..."
sleep 10

# Check if service is running
if docker-compose ps | grep -q "Up"; then
    echo "✅ CloudCode Server is running!"
    echo ""
    echo "🌐 Access your IDE at: http://localhost:8080"
    echo "🔑 Password: $PASSWORD"
    echo ""
    echo "📋 Useful commands:"
    echo "   View logs:    docker-compose logs -f"
    echo "   Stop server:  docker-compose down"
    echo "   Restart:      docker-compose restart"
    echo "   Update:       git pull && docker-compose build && docker-compose up -d"
    echo ""
    echo "📁 Your workspace is persistent and located in Docker volume."
    echo "   Access terminal in browser or run: docker-compose exec cloudcode-server bash"
else
    echo "❌ Failed to start CloudCode Server"
    echo "📋 Check logs: docker-compose logs"
    exit 1
fi