# claude-rocker
Docker Compose setup for running RStudio Server with Claude Code

```
# Start everything
docker-compose up -d

# View logs
docker-compose logs -f

# Stop everything
docker-compose down

# Rebuild after Dockerfile changes
docker-compose up -d --build
```
