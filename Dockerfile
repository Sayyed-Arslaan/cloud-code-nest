# CloudCode Server - Professional Development Environment
# Based on Ubuntu 22.04 LTS with multi-language support

FROM ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC
ENV CODE_SERVER_VERSION=4.19.1
ENV USER=coder
ENV PASSWORD=cloudcode123
ENV WORKSPACE=/workspace

# Create user for code-server
RUN useradd --create-home --shell /bin/bash $USER

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    sudo \
    build-essential \
    python3 \
    python3-pip \
    python3-venv \
    nodejs \
    npm \
    vim \
    nano \
    htop \
    tree \
    zip \
    unzip \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    gnupg \
    lsb-release \
    openssh-client \
    && rm -rf /var/lib/apt/lists/*

# Install latest Node.js LTS
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs

# Install C++ compiler and development tools
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    gdb \
    cmake \
    make \
    clang \
    && rm -rf /var/lib/apt/lists/*

# Install Python development tools
RUN pip3 install --upgrade pip \
    && pip3 install \
    virtualenv \
    pylint \
    black \
    pytest \
    jupyter \
    requests \
    flask \
    django \
    fastapi \
    numpy \
    pandas

# Install global npm packages
RUN npm install -g \
    typescript \
    ts-node \
    nodemon \
    express-generator \
    create-react-app \
    @vue/cli \
    @angular/cli \
    live-server \
    http-server \
    eslint \
    prettier

# Install code-server
RUN curl -fsSL https://code-server.dev/install.sh | sh -s -- --version=$CODE_SERVER_VERSION

# Grant sudo access to coder user
RUN echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Create workspace directory
RUN mkdir -p $WORKSPACE && chown -R $USER:$USER $WORKSPACE

# Copy startup scripts
COPY scripts/start.sh /usr/local/bin/start.sh
COPY scripts/install-extensions.sh /usr/local/bin/install-extensions.sh
RUN chmod +x /usr/local/bin/start.sh /usr/local/bin/install-extensions.sh

# Create .gitconfig for the user
USER $USER
RUN git config --global user.name "CloudCode User" \
    && git config --global user.email "user@cloudcode.dev" \
    && git config --global init.defaultBranch main

# Install VS Code extensions
RUN /usr/local/bin/install-extensions.sh

# Create default workspace structure
RUN mkdir -p $WORKSPACE/projects \
    && mkdir -p $WORKSPACE/temp \
    && echo "# Welcome to CloudCode Server" > $WORKSPACE/README.md \
    && echo "console.log('Hello from CloudCode!');" > $WORKSPACE/projects/hello.js \
    && echo "print('Hello from CloudCode!')" > $WORKSPACE/projects/hello.py

WORKDIR $WORKSPACE

# Expose code-server port
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
    CMD curl -f http://localhost:8080/healthz || exit 1

# Start code-server
CMD ["/usr/local/bin/start.sh"]