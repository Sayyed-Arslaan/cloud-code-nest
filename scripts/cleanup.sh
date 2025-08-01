#!/bin/bash

echo "🧹 CloudCode Server - Cleanup Script"
echo "====================================="

echo "This will remove all CloudCode Server containers and volumes."
echo "⚠️  WARNING: This will delete all your workspace data!"
echo ""

read -p "Are you sure you want to continue? (type 'yes' to confirm): " confirm

if [ "$confirm" != "yes" ]; then
    echo "Cleanup cancelled."
    exit 0
fi

echo ""
echo "🛑 Stopping CloudCode Server..."
docker-compose down

echo "🗑️  Removing containers..."
docker rm -f cloudcode-server cloudcode-traefik 2>/dev/null || true

echo "📦 Removing volumes..."
docker volume rm -f cloudcode-server_workspace-data 2>/dev/null || true
docker volume rm -f cloudcode-server_git-config 2>/dev/null || true
docker volume rm -f cloudcode-server_vscode-config 2>/dev/null || true
docker volume rm -f cloudcode-server_ssh-keys 2>/dev/null || true
docker volume rm -f cloudcode-server_letsencrypt 2>/dev/null || true

echo "🖼️  Removing images..."
docker rmi -f cloudcode-server_cloudcode-server 2>/dev/null || true
docker rmi -f cloudcode-server 2>/dev/null || true

echo "🧹 Removing unused Docker resources..."
docker system prune -f

echo ""
echo "✅ Cleanup completed!"
echo "To redeploy CloudCode Server, run: ./scripts/deploy-local.sh"