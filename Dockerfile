FROM rocker/rstudio:latest

# Install system dependencies including Node.js
RUN apt-get update && apt-get install -y \
    curl \
    git \
    sudo \
    ca-certificates \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# Switch to rstudio user for npm installation
USER rstudio
WORKDIR /home/rstudio

# Configure npm to install packages in user directory
RUN mkdir -p /home/rstudio/.npm-global && \
    npm config set prefix '/home/rstudio/.npm-global'

# Add npm global bin to PATH
ENV PATH="/home/rstudio/.npm-global/bin:$PATH"

# Install Claude Code CLI as rstudio user
RUN npm install -g @anthropic-ai/claude-code

# Create directory for Claude credentials
RUN mkdir -p /home/rstudio/.claude

# Set RStudio theme and preferences
RUN mkdir -p /home/rstudio/.config/rstudio && \
    echo '{\n\
    "editor_theme": "Tomorrow Night",\n\
    "font_size_points": 11,\n\
    "posix_terminal_shell": "bash"\n\
}' > /home/rstudio/.config/rstudio/rstudio-prefs.json

# Switch back to root for container startup
USER root

EXPOSE 8787
CMD ["/init"]
