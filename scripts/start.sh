#!/bin/bash
set -e

echo "🚀 Starting CloudCode Server..."

# Set default values
USER=${USER:-coder}
PASSWORD=${PASSWORD:-cloudcode123}
WORKSPACE=${WORKSPACE:-/workspace}
PORT=${PORT:-8080}

# Clone Git repository if specified
if [ ! -z "$GIT_REPO" ]; then
    echo "📦 Cloning repository: $GIT_REPO"
    if [ ! -z "$GIT_TOKEN" ]; then
        # Use token for private repos
        git clone https://$GIT_TOKEN@github.com/${GIT_REPO}.git $WORKSPACE/repo || true
    else
        # Public repo
        git clone https://github.com/${GIT_REPO}.git $WORKSPACE/repo || true
    fi
fi

# Set up SSH keys for Git if provided
if [ ! -z "$SSH_PRIVATE_KEY" ]; then
    echo "🔑 Setting up SSH keys..."
    mkdir -p ~/.ssh
    echo "$SSH_PRIVATE_KEY" > ~/.ssh/id_rsa
    chmod 600 ~/.ssh/id_rsa
    ssh-keyscan github.com >> ~/.ssh/known_hosts
fi

# Install additional extensions if specified
if [ ! -z "$EXTENSIONS" ]; then
    echo "🔌 Installing additional extensions..."
    IFS=',' read -ra ADDR <<< "$EXTENSIONS"
    for extension in "${ADDR[@]}"; do
        code-server --install-extension "$extension" || true
    done
fi

# Create initial project structure if workspace is empty
if [ ! "$(ls -A $WORKSPACE)" ]; then
    echo "📁 Setting up initial workspace..."
    mkdir -p $WORKSPACE/{projects,temp,scripts}
    
    # Create sample files
    cat > $WORKSPACE/projects/welcome.md << EOF
# Welcome to CloudCode Server! 🚀

Your professional cloud-based development environment is ready.

## Quick Start

### Python Development
\`\`\`bash
cd projects
python3 hello.py
\`\`\`

### Node.js Development
\`\`\`bash
cd projects
node hello.js
\`\`\`

### Web Development
\`\`\`bash
cd projects
live-server .
\`\`\`

## Installed Tools
- Python 3 with pip
- Node.js 20 with npm
- C++ compiler (gcc/g++)
- Git with GitHub integration
- VS Code extensions for web development

## Terminal Commands
Open the integrated terminal (Ctrl+\`) to access the full Linux environment.

Happy coding! 💻
EOF

    cat > $WORKSPACE/projects/hello.py << EOF
#!/usr/bin/env python3
"""
CloudCode Server - Python Example
"""

def main():
    print("🐍 Hello from CloudCode Server!")
    print("Python environment is ready for development.")
    
    # Example: Web server with Flask
    try:
        from flask import Flask
        app = Flask(__name__)
        
        @app.route('/')
        def hello():
            return "<h1>Hello from CloudCode Server!</h1><p>Flask is working!</p>"
        
        print("Run: python3 hello.py to start Flask server")
        # app.run(host='0.0.0.0', port=5000, debug=True)
    except ImportError:
        print("Install Flask: pip3 install flask")

if __name__ == "__main__":
    main()
EOF

    cat > $WORKSPACE/projects/hello.js << EOF
/**
 * CloudCode Server - Node.js Example
 */

console.log("🟢 Hello from CloudCode Server!");
console.log("Node.js environment is ready for development.");

// Example: Simple HTTP server
const http = require('http');
const fs = require('fs');
const path = require('path');

function createServer() {
    const server = http.createServer((req, res) => {
        res.writeHead(200, { 'Content-Type': 'text/html' });
        res.end(`
            <h1>Hello from CloudCode Server!</h1>
            <p>Node.js server is running!</p>
            <p>Time: ${new Date().toISOString()}</p>
        `);
    });
    
    const port = 3000;
    // server.listen(port, () => {
    //     console.log(\`Server running at http://localhost:\${port}\`);
    // });
    
    console.log("Uncomment lines above to start HTTP server");
}

// createServer();
EOF

    cat > $WORKSPACE/projects/index.html << EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CloudCode Server</title>
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            max-width: 800px;
            margin: 0 auto;
            padding: 2rem;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            min-height: 100vh;
        }
        .container {
            background: rgba(255, 255, 255, 0.1);
            padding: 2rem;
            border-radius: 15px;
            backdrop-filter: blur(10px);
        }
        h1 { color: #fff; margin-bottom: 1rem; }
        .feature { margin: 1rem 0; padding: 1rem; background: rgba(255, 255, 255, 0.1); border-radius: 8px; }
        code { background: rgba(0, 0, 0, 0.3); padding: 0.2rem 0.5rem; border-radius: 4px; }
    </style>
</head>
<body>
    <div class="container">
        <h1>🚀 CloudCode Server</h1>
        <p>Your professional cloud-based development environment</p>
        
        <div class="feature">
            <h3>✅ Environment Ready</h3>
            <p>All development tools are installed and configured</p>
        </div>
        
        <div class="feature">
            <h3>🔧 Available Tools</h3>
            <p>Python 3, Node.js, C++, Git, and more</p>
        </div>
        
        <div class="feature">
            <h3>🌐 Live Server</h3>
            <p>Run <code>live-server .</code> in terminal for live reload</p>
        </div>
        
        <div class="feature">
            <h3>📚 Getting Started</h3>
            <p>Check out <code>welcome.md</code> for examples and tutorials</p>
        </div>
    </div>
    
    <script>
        console.log('🎉 CloudCode Server is running!');
        console.log('Open the terminal (Ctrl+`) to start coding');
    </script>
</body>
</html>
EOF

    chmod +x $WORKSPACE/projects/*.py
fi

echo "🔧 Configuring code-server..."

# Start code-server with configuration
exec code-server \
    --bind-addr 0.0.0.0:$PORT \
    --auth password \
    --password "$PASSWORD" \
    --disable-telemetry \
    --disable-update-check \
    --user-data-dir ~/.local/share/code-server \
    --extensions-dir ~/.local/share/code-server/extensions \
    $WORKSPACE