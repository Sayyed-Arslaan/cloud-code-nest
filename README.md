# 🚀 CloudCode Server

**Professional Cloud-Based Development Environment**

Access VS Code from anywhere with full Linux terminal, multi-language support, and seamless GitHub integration. Deploy in minutes with Docker.

![CloudCode Server](https://img.shields.io/badge/VS%20Code-Cloud%20IDE-blue?style=for-the-badge&logo=visual-studio-code)
![Docker](https://img.shields.io/badge/Docker-Containerized-blue?style=for-the-badge&logo=docker)
![Security](https://img.shields.io/badge/Security-Password%20Protected-green?style=for-the-badge&logo=shield)

## ✨ Features

- 🖥️ **Full VS Code Experience** - Native VS Code interface with extensions
- 🐧 **Complete Linux Environment** - Bash terminal with all development tools
- 🔒 **Secure Access** - Password protection and HTTPS support
- 🌍 **Multi-Language Support** - Python, Node.js, C++, and more
- 📚 **Git Integration** - Built-in Git with GitHub synchronization
- 🐳 **Docker Ready** - Containerized for easy deployment anywhere
- 💾 **Persistent Storage** - Your files survive container restarts
- 🔧 **Pre-configured** - Ready-to-use development environment

## 🏗️ Architecture

```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   Web Browser   │◄──►│  CloudCode       │◄──►│   Docker        │
│   (Any Device)  │    │  Server          │    │   Container     │
└─────────────────┘    │  (Port 8080)     │    │   (Ubuntu)      │
                       └──────────────────┘    └─────────────────┘
                                │                        │
                                ▼                        ▼
                       ┌──────────────────┐    ┌─────────────────┐
                       │   GitHub         │    │   Persistent    │
                       │   Integration    │    │   Workspace     │
                       └──────────────────┘    └─────────────────┘
```

## 🚀 Quick Start

### Option 1: Local Development

```bash
# Clone repository
git clone <this-repo-url>
cd cloudcode-server

# Configure environment
cp .env.example .env
nano .env  # Set your password

# Deploy locally
chmod +x scripts/deploy-local.sh
./scripts/deploy-local.sh
```

Access at: `http://localhost:8080`

### Option 2: Cloud Deployment

Choose your platform:

#### 🎯 Render.com (Recommended)
```bash
# Run deployment guide
chmod +x scripts/deploy-cloud.sh
./scripts/deploy-cloud.sh
```

#### 🚂 Railway.app
```bash
npm install -g @railway/cli
railway login
railway up
```

#### ☁️ Any Cloud Provider
```bash
docker build -t cloudcode-server .
docker run -d -p 8080:8080 -e PASSWORD=your-password cloudcode-server
```

## 📋 Installation Requirements

### Local Development
- Docker & Docker Compose
- Git
- Text editor for configuration

### Cloud Deployment
- GitHub account (for code hosting)
- Cloud provider account (Render, Railway, etc.)
- Domain name (optional, for custom URL)

## ⚙️ Configuration

### Environment Variables

| Variable | Description | Default | Required |
|----------|-------------|---------|----------|
| `PASSWORD` | Login password | `cloudcode123` | ✅ |
| `USER` | System username | `coder` | ❌ |
| `WORKSPACE` | Workspace directory | `/workspace` | ❌ |
| `GIT_REPO` | Auto-clone repo | - | ❌ |
| `GIT_TOKEN` | GitHub token | - | ❌ |
| `EXTENSIONS` | VS Code extensions | - | ❌ |

### Example .env Configuration

```env
# Basic setup
PASSWORD=my-super-secure-password-123
USER=developer

# Auto-clone your repositories
GIT_REPO=username/my-project
GIT_TOKEN=ghp_your_github_token_here

# Additional extensions
EXTENSIONS=ms-python.python,eamodio.gitlens
```

## 🛠️ Installed Development Tools

### Languages & Runtimes
- **Python 3.10+** with pip, virtualenv, common packages
- **Node.js 20 LTS** with npm, global packages
- **C++** compiler (gcc/g++, clang)
- **Git** with SSH support

### Development Packages

#### Python Packages
```
pylint, black, pytest, jupyter
flask, django, fastapi
numpy, pandas, requests
```

#### Node.js Packages
```
typescript, ts-node, nodemon
express-generator, create-react-app
live-server, http-server
eslint, prettier
```

### VS Code Extensions
- Python development (ms-python.python)
- C++ development (ms-vscode.cpptools)
- Git integration (eamodio.gitlens)
- Web development (prettier, eslint)
- Docker support (ms-azuretools.vscode-docker)
- And many more...

## 📁 Project Structure

```
cloudcode-server/
├── Dockerfile                 # Main container definition
├── docker-compose.yml         # Local development setup
├── .env.example              # Environment configuration template
├── scripts/
│   ├── start.sh              # Container startup script
│   ├── install-extensions.sh # VS Code extensions installer
│   ├── deploy-local.sh       # Local deployment script
│   └── deploy-cloud.sh       # Cloud deployment guide
├── deploy/
│   ├── render.yaml           # Render.com configuration
│   └── railway.json          # Railway.app configuration
└── README.md                 # This file
```

## 🔧 Usage Examples

### Web Development
```bash
# Create a new React app
npx create-react-app my-app
cd my-app
npm start

# Start live server for static sites
live-server .
```

### Python Development
```bash
# Create virtual environment
python3 -m venv myproject
source myproject/bin/activate

# Install packages
pip install flask requests

# Run Python scripts
python3 app.py
```

### C++ Development
```bash
# Compile and run
g++ -o myapp main.cpp
./myapp

# Debug with GDB
g++ -g -o myapp main.cpp
gdb ./myapp
```

## 🔒 Security Best Practices

### Essential Security Steps
1. **Change Default Password** - Use strong, unique password
2. **Enable HTTPS** - Use reverse proxy with SSL certificate
3. **Firewall Configuration** - Only expose necessary ports
4. **Regular Updates** - Keep container image updated
5. **Backup Workspace** - Regular backups of persistent data

### Production Deployment
```bash
# Use strong passwords
PASSWORD=$(openssl rand -base64 32)

# Enable HTTPS with reverse proxy
# Example nginx configuration:
server {
    listen 443 ssl;
    server_name code.yourdomain.com;
    ssl_certificate /path/to/cert.pem;
    ssl_certificate_key /path/to/key.pem;
    
    location / {
        proxy_pass http://localhost:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

## 🚨 Troubleshooting

### Common Issues

#### Container Won't Start
```bash
# Check logs
docker-compose logs cloudcode-server

# Common causes:
# - Port 8080 already in use
# - Invalid environment variables
# - Insufficient disk space
```

#### Can't Access from Browser
```bash
# Check if service is running
docker-compose ps

# Verify port mapping
netstat -tlnp | grep 8080

# Test locally
curl http://localhost:8080
```

#### Extensions Not Loading
```bash
# Reinstall extensions
docker-compose exec cloudcode-server /usr/local/bin/install-extensions.sh

# Check extension directory
ls ~/.local/share/code-server/extensions/
```

#### Workspace Data Lost
```bash
# Check volume status
docker volume ls | grep cloudcode

# Backup workspace
docker cp cloudcode-server:/workspace ./workspace-backup
```

### Performance Optimization

#### For Better Performance
- Increase container memory allocation
- Use SSD storage for volumes
- Enable swap if needed
- Optimize VS Code settings

#### Resource Requirements
- **Minimum**: 1GB RAM, 10GB storage
- **Recommended**: 2GB RAM, 20GB storage
- **Optimal**: 4GB RAM, 50GB storage

## 🔄 Updates & Maintenance

### Update CloudCode Server
```bash
# Pull latest changes
git pull origin main

# Rebuild and restart
docker-compose down
docker-compose build --no-cache
docker-compose up -d
```

### Backup Workspace
```bash
# Create backup
docker-compose exec cloudcode-server tar -czf /tmp/workspace-backup.tar.gz -C /workspace .
docker cp cloudcode-server:/tmp/workspace-backup.tar.gz ./workspace-backup.tar.gz

# Restore backup
docker cp ./workspace-backup.tar.gz cloudcode-server:/tmp/
docker-compose exec cloudcode-server tar -xzf /tmp/workspace-backup.tar.gz -C /workspace
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

### Development Setup
```bash
git clone <repo-url>
cd cloudcode-server
cp .env.example .env
./scripts/deploy-local.sh
```

## 📄 License

MIT License - feel free to use this for personal or commercial projects.

## 🆘 Support

- 📚 Check the troubleshooting section above
- 🐛 Report issues on GitHub
- 💬 Community discussions in GitHub Discussions
- 📧 Email support: [your-email]

## 🌟 Credits

Built with:
- [code-server](https://github.com/coder/code-server) - VS Code in the browser
- [Docker](https://docker.com) - Containerization
- [Ubuntu](https://ubuntu.com) - Base operating system
- Love ❤️ and lots of coffee ☕

---

**Happy Coding! 🎉**

Made with ❤️ for developers who code everywhere.