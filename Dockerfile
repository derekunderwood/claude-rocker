FROM rocker/rstudio:latest

# Install system dependencies including Node.js
RUN apt-get update && apt-get install -y \
    curl \
    git \
    sudo \
    ca-certificates \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js (required for Claude Code)
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# Install Claude Code CLI globally via npm
RUN npm install -g @anthropic-ai/claude-code

# Create directory for Claude credentials
RUN mkdir -p /home/rstudio/.claude && \
    chown -R rstudio:rstudio /home/rstudio/.claude

EXPOSE 8787

CMD ["/init"]
