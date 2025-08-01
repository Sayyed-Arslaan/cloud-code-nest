#!/bin/bash

echo "🔌 Installing VS Code extensions for CloudCode Server..."

# Essential extensions for web development
extensions=(
    # Language Support
    "ms-python.python"
    "ms-python.pylint"
    "ms-python.black-formatter"
    "ms-vscode.cpptools"
    "ms-vscode.cmake-tools"
    "bradlc.vscode-tailwindcss"
    "esbenp.prettier-vscode"
    "dbaeumer.vscode-eslint"
    "ms-vscode.vscode-typescript-next"
    
    # Frameworks & Libraries
    "ms-vscode.vscode-json"
    "redhat.vscode-yaml"
    "ms-vscode.vscode-css"
    "ecmel.vscode-html-css"
    "formulahendry.auto-rename-tag"
    "bradlc.vscode-tailwindcss"
    
    # Git & Version Control
    "eamodio.gitlens"
    "github.vscode-pull-request-github"
    "github.copilot"
    "github.copilot-chat"
    
    # Productivity
    "ms-vscode.vscode-terminal"
    "ms-vscode-remote.remote-containers"
    "ms-vscode.live-server"
    "ritwickdey.liveserver"
    "formulahendry.code-runner"
    "aaron-bond.better-comments"
    "pkief.material-icon-theme"
    "zhuangtongfa.material-theme"
    
    # Docker & DevOps
    "ms-azuretools.vscode-docker"
    "ms-kubernetes-tools.vscode-kubernetes-tools"
    "redhat.vscode-yaml"
    
    # Utilities
    "streetsidesoftware.code-spell-checker"
    "wayou.vscode-todo-highlight"
    "gruntfuggly.todo-tree"
    "alefragnani.bookmarks"
    "ms-vscode.hexeditor"
)

# Install each extension
for extension in "${extensions[@]}"; do
    echo "Installing $extension..."
    code-server --install-extension "$extension" --force || echo "Failed to install $extension"
done

echo "✅ Extension installation completed!"

# Create default settings.json for better experience
mkdir -p ~/.local/share/code-server/User
cat > ~/.local/share/code-server/User/settings.json << EOF
{
    "workbench.colorTheme": "Material Theme Darker High Contrast",
    "workbench.iconTheme": "material-icon-theme",
    "editor.fontFamily": "'JetBrains Mono', 'Fira Code', 'Consolas', 'Courier New', monospace",
    "editor.fontSize": 14,
    "editor.fontLigatures": true,
    "editor.tabSize": 2,
    "editor.insertSpaces": true,
    "editor.detectIndentation": true,
    "editor.formatOnSave": true,
    "editor.formatOnPaste": true,
    "editor.minimap.enabled": true,
    "editor.suggestSelection": "first",
    "editor.quickSuggestions": {
        "other": true,
        "comments": false,
        "strings": true
    },
    "files.autoSave": "afterDelay",
    "files.autoSaveDelay": 1000,
    "terminal.integrated.shell.linux": "/bin/bash",
    "terminal.integrated.fontFamily": "'JetBrains Mono', 'Fira Code', monospace",
    "terminal.integrated.fontSize": 13,
    "python.defaultInterpreterPath": "/usr/bin/python3",
    "python.linting.enabled": true,
    "python.linting.pylintEnabled": true,
    "python.formatting.provider": "black",
    "javascript.updateImportsOnFileMove.enabled": "always",
    "typescript.updateImportsOnFileMove.enabled": "always",
    "git.autofetch": true,
    "git.enableSmartCommit": true,
    "git.confirmSync": false,
    "extensions.autoUpdate": true,
    "security.workspace.trust.untrustedFiles": "open",
    "telemetry.telemetryLevel": "off",
    "update.showReleaseNotes": false
}
EOF

echo "⚙️ Default settings configured!"