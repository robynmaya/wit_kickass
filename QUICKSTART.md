# 🚀 Quick Start Guide

For developers cloning this repository:

## Prerequisites

- **Docker** (with Docker Desktop running)
- **Node.js** 18+ 
- **Python** 3.8+
- **Ruby** 3.0+ (optional - only needed for Rails app)

## One-Command Setup

```bash
./setup.sh
```

This script will:
- ✅ Check all prerequisites
- ✅ Start PostgreSQL in Docker
- ✅ Install all dependencies
- ✅ Run database migrations
- ✅ Make all scripts executable

## Running Apps

After setup, use these commands:

```bash
npm run react-express    # Express + React + TypeScript
npm run react-python     # FastAPI + React + Python  
npm run react-rails      # Rails + React + Ruby
```

## Database Management

```bash
npm run db:start    # Start PostgreSQL
npm run db:stop     # Stop PostgreSQL
npm run db:reset    # Reset all data
```

## Troubleshooting

### Docker Issues
```bash
# Check if Docker is running
docker info

# Restart PostgreSQL
npm run db:reset
```

### Port Conflicts
If ports are occupied, the frontend will auto-increment:
- Express: 5173 → 5174 → 5175 (auto-finds available)
- FastAPI: 5174 → 5175 → 5176 (auto-finds available)
- Rails: 5175 → 5176 → 5177 (auto-finds available)

### Clean Restart
```bash
npm run db:stop
docker system prune -f
./setup.sh
```

That's it! Happy coding! 🎉
