#!/bin/bash

echo "🔄 CloudCode Server - Update Script"
echo "==================================="

# Check if we're in a git repository
if [ ! -d .git ]; then
    echo "❌ Not in a git repository. Please run from the cloudcode-server directory."
    exit 1
fi

echo "📦 Creating backup before update..."
./scripts/backup.sh

echo ""
echo "📥 Pulling latest changes..."
git pull origin main

if [ $? -ne 0 ]; then
    echo "❌ Failed to pull updates. Please resolve conflicts manually."
    exit 1
fi

echo ""
echo "🛑 Stopping current server..."
docker-compose down

echo "🔨 Building updated image..."
docker-compose build --no-cache

echo "🚀 Starting updated server..."
docker-compose up -d

# Wait for service to be ready
echo "⏳ Waiting for server to start..."
sleep 15

# Check if service is running
if docker-compose ps | grep -q "Up"; then
    echo ""
    echo "✅ CloudCode Server updated successfully!"
    echo "🌐 Access your IDE at: http://localhost:8080"
    echo ""
    echo "📋 What's new:"
    echo "   - Check README.md for latest features"
    echo "   - View logs: docker-compose logs -f"
    echo ""
else
    echo "❌ Update failed. Server is not running."
    echo "📋 Check logs: docker-compose logs"
    echo "🔄 To rollback, restore from backup and restart"
    exit 1
fi