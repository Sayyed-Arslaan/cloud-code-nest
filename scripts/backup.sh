#!/bin/bash

echo "💾 CloudCode Server - Backup Script"
echo "==================================="

# Create backup directory with timestamp
BACKUP_DIR="backups/$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

echo "📦 Creating backup in: $BACKUP_DIR"

# Check if container is running
if ! docker-compose ps | grep -q "Up"; then
    echo "⚠️  CloudCode Server is not running. Starting it for backup..."
    docker-compose up -d
    sleep 10
fi

echo "🗂️  Backing up workspace..."
docker-compose exec -T cloudcode-server tar -czf - -C /workspace . > "$BACKUP_DIR/workspace.tar.gz"

echo "⚙️  Backing up VS Code settings..."
docker-compose exec -T cloudcode-server tar -czf - -C /home/coder/.local/share/code-server . > "$BACKUP_DIR/vscode-config.tar.gz"

echo "🔑 Backing up Git configuration..."
docker-compose exec -T cloudcode-server tar -czf - -C /home/coder/.config . > "$BACKUP_DIR/git-config.tar.gz" 2>/dev/null || true

echo "🗝️  Backing up SSH keys..."
docker-compose exec -T cloudcode-server tar -czf - -C /home/coder/.ssh . > "$BACKUP_DIR/ssh-keys.tar.gz" 2>/dev/null || true

# Copy environment file
if [ -f .env ]; then
    cp .env "$BACKUP_DIR/env-backup"
    echo "📝 Environment configuration backed up"
fi

# Create backup info file
cat > "$BACKUP_DIR/backup-info.txt" << EOF
CloudCode Server Backup
======================
Date: $(date)
Hostname: $(hostname)
Docker Version: $(docker --version)
Container Status: $(docker-compose ps --services --filter status=running)

Contents:
- workspace.tar.gz: Complete workspace directory
- vscode-config.tar.gz: VS Code settings and extensions
- git-config.tar.gz: Git configuration
- ssh-keys.tar.gz: SSH keys for Git authentication
- env-backup: Environment configuration

Restore Instructions:
1. Extract workspace.tar.gz to new workspace volume
2. Extract vscode-config.tar.gz to restore VS Code settings
3. Copy env-backup to .env and configure as needed
4. Run: docker-compose up -d
EOF

echo ""
echo "✅ Backup completed successfully!"
echo "📁 Backup location: $BACKUP_DIR"
echo "📊 Backup size: $(du -sh "$BACKUP_DIR" | cut -f1)"
echo ""
echo "🔄 To restore this backup:"
echo "   1. Stop current server: docker-compose down"
echo "   2. Extract files from backup directory"
echo "   3. Restore workspace: docker run --rm -v cloudcode-server_workspace-data:/workspace -v \$(pwd)/$BACKUP_DIR:/backup alpine tar -xzf /backup/workspace.tar.gz -C /workspace"
echo "   4. Start server: docker-compose up -d"