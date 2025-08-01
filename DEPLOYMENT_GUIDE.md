# 🚀 CloudCode Server - Complete Deployment Guide

This guide covers all deployment scenarios for your professional cloud-based coding server.

## 📋 Pre-Deployment Checklist

- [ ] Docker installed locally (for testing)
- [ ] GitHub account set up
- [ ] Cloud provider account ready (Render, Railway, etc.)
- [ ] Domain name (optional, for custom URLs)
- [ ] Strong password chosen (min 12 characters)

## 🎯 Platform-Specific Deployment

### 1. Render.com (Recommended)

**Why Render?**
- Free tier available
- Automatic HTTPS
- Easy persistent storage
- GitHub integration

**Step-by-step:**

1. **Prepare Repository**
   ```bash
   git add .
   git commit -m "Initial CloudCode Server setup"
   git push origin main
   ```

2. **Deploy on Render**
   - Go to [render.com](https://render.com)
   - Click "New +" → "Web Service"
   - Connect your GitHub repository
   - Use these settings:
     - **Name**: `cloudcode-server`
     - **Environment**: Docker
     - **Build Command**: `docker build -t cloudcode-server .`
     - **Start Command**: `/usr/local/bin/start.sh`
     - **Port**: `8080`

3. **Environment Variables**
   ```
   PASSWORD=your-super-secure-password
   USER=coder
   WORKSPACE=/workspace
   GIT_REPO=your-username/your-repo (optional)
   GIT_TOKEN=ghp_your_token_here (optional)
   ```

4. **Add Persistent Disk**
   - Name: `workspace-data`
   - Mount Path: `/workspace`
   - Size: 20GB (adjust as needed)

5. **Deploy**
   - Click "Create Web Service"
   - Wait 5-10 minutes for deployment
   - Access at: `https://your-app-name.onrender.com`

### 2. Railway.app

**Why Railway?**
- Great performance
- Simple deployment
- Built-in metrics

**Step-by-step:**

1. **Install Railway CLI**
   ```bash
   npm install -g @railway/cli
   railway login
   ```

2. **Deploy**
   ```bash
   railway up
   ```

3. **Configure Environment**
   - Go to Railway dashboard
   - Add environment variables:
     ```
     PASSWORD=your-secure-password
     USER=coder
     WORKSPACE=/workspace
     ```

4. **Add Volume**
   - Size: 20GB
   - Mount Path: `/workspace`

### 3. DigitalOcean App Platform

1. **Create App**
   - Connect GitHub repository
   - Choose "Docker" as source

2. **Configure**
   ```yaml
   name: cloudcode-server
   services:
   - name: web
     source_dir: /
     github:
       repo: your-username/cloudcode-server
       branch: main
     run_command: /usr/local/bin/start.sh
     environment_slug: docker
     instance_count: 1
     instance_size_slug: basic-xxs
     envs:
     - key: PASSWORD
       value: your-secure-password
     - key: USER
       value: coder
   ```

### 4. Google Cloud Run

1. **Build and Push Image**
   ```bash
   # Build image
   docker build -t gcr.io/YOUR_PROJECT_ID/cloudcode-server .
   
   # Push to Container Registry
   docker push gcr.io/YOUR_PROJECT_ID/cloudcode-server
   ```

2. **Deploy to Cloud Run**
   ```bash
   gcloud run deploy cloudcode-server \
     --image gcr.io/YOUR_PROJECT_ID/cloudcode-server \
     --platform managed \
     --port 8080 \
     --set-env-vars PASSWORD=your-secure-password \
     --memory 2Gi \
     --cpu 1 \
     --allow-unauthenticated
   ```

### 5. AWS ECS/Fargate

1. **Create Task Definition**
   ```json
   {
     "family": "cloudcode-server",
     "networkMode": "awsvpc",
     "requiresCompatibilities": ["FARGATE"],
     "cpu": "1024",
     "memory": "2048",
     "executionRoleArn": "arn:aws:iam::ACCOUNT:role/ecsTaskExecutionRole",
     "containerDefinitions": [
       {
         "name": "cloudcode-server",
         "image": "your-ecr-repo/cloudcode-server:latest",
         "portMappings": [
           {
             "containerPort": 8080,
             "protocol": "tcp"
           }
         ],
         "environment": [
           {
             "name": "PASSWORD",
             "value": "your-secure-password"
           }
         ]
       }
     ]
   }
   ```

## 🔐 Security Configuration

### Basic Security
```bash
# Use strong password
export PASSWORD=$(openssl rand -base64 32)

# Enable HTTPS (production)
# Use reverse proxy (nginx/cloudflare)
```

### Advanced Security
```bash
# Firewall rules (only allow 80/443)
ufw allow 80/tcp
ufw allow 443/tcp
ufw deny 8080/tcp  # Block direct access

# SSL Certificate (Let's Encrypt)
certbot --nginx -d code.yourdomain.com
```

## 🌐 Custom Domain Setup

### Cloudflare (Recommended)
1. Add your domain to Cloudflare
2. Set DNS A record: `code` → `your-server-ip`
3. Enable proxy (orange cloud)
4. SSL/TLS → Full (strict)

### Direct DNS
```
Type: A
Name: code
Value: your-server-ip
TTL: 300
```

## 📊 Monitoring & Maintenance

### Health Checks
```bash
# Check if server is running
curl -f https://code.yourdomain.com/healthz

# Monitor container
docker stats cloudcode-server
```

### Backup Schedule
```bash
# Daily backup (add to crontab)
0 2 * * * /path/to/cloudcode-server/scripts/backup.sh
```

### Updates
```bash
# Weekly updates (add to crontab)
0 3 * * 0 /path/to/cloudcode-server/scripts/update.sh
```

## 🔧 Performance Optimization

### Resource Allocation
```yaml
# Docker Compose (production)
services:
  cloudcode-server:
    deploy:
      resources:
        limits:
          cpus: '2.0'
          memory: 4G
        reservations:
          cpus: '1.0'
          memory: 2G
```

### Storage Optimization
```bash
# Use SSD volumes for better performance
# Regular cleanup of temporary files
docker exec cloudcode-server bash -c "
  find /tmp -type f -atime +7 -delete
  find /workspace/temp -type f -atime +3 -delete
"
```

## 🚨 Troubleshooting Common Issues

### Port Already in Use
```bash
# Find what's using port 8080
lsof -i :8080
sudo kill -9 <PID>
```

### Container Won't Start
```bash
# Check logs
docker-compose logs cloudcode-server

# Common issues:
# - Invalid environment variables
# - Port conflicts
# - Insufficient permissions
```

### Can't Access from Internet
```bash
# Check firewall
ufw status

# Check if service is listening
netstat -tlnp | grep 8080

# Test local connection
curl http://localhost:8080
```

### Workspace Data Lost
```bash
# Check volume
docker volume inspect cloudcode-server_workspace-data

# Restore from backup
docker run --rm -v cloudcode-server_workspace-data:/workspace \
  -v $(pwd)/backups/latest:/backup alpine \
  tar -xzf /backup/workspace.tar.gz -C /workspace
```

## 📈 Scaling Considerations

### Horizontal Scaling
- Use load balancer (nginx/haproxy)
- Shared storage (NFS/EFS)
- Session stickiness required

### Vertical Scaling
- Increase CPU/memory allocation
- Use faster storage (SSD/NVMe)
- Optimize VS Code settings

## 🔄 CI/CD Integration

### GitHub Actions
```yaml
# .github/workflows/deploy.yml
name: Deploy CloudCode Server
on:
  push:
    branches: [main]
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - name: Deploy to Render
      run: |
        curl -X POST ${{ secrets.RENDER_DEPLOY_HOOK }}
```

### Auto-Update Strategy
```bash
# Webhook endpoint for auto-updates
# Set up in your cloud provider to trigger on git push
```

## 📞 Support & Community

### Getting Help
- 📚 Check documentation in README.md
- 🐛 Report issues on GitHub
- 💬 Community discussions
- 📧 Email support

### Contributing
```bash
# Fork repository
# Make changes
# Submit pull request
# Help improve the project!
```

---

**🎉 Happy Coding in the Cloud!**

Your professional development environment is ready. Access it from anywhere, anytime.