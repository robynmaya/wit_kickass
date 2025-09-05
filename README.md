# 🚀 Full-Stack Practice Workspace

**Master React with multiple backend technologies in one comprehensive workspace!**

A complete development environment featuring **React frontends** paired with **Express (Node.js)**, **FastAPI (Python)**, and **Rails (Ruby)** backends. Each app demonstrates the same features using different technology stacks, making it perfect for learning and comparing approaches.

---

## 📁 Project Structure

```
wit_kickass/
├── 🟨 react-express-app/     # React + Express + TypeScript + Prisma
├── 🐍 react-python-app/      # React + FastAPI + Python + SQLAlchemy
├── 💎 react-rails-app/       # React + Rails + Ruby + Active Record
├── 🐘 docker-compose.yml     # Shared PostgreSQL database
├── 📋 setup.sh              # One-command setup script
└── 📖 README.md              # This guide
```

---

## ⚡ Quick Start

### 📥 **Clone & Setup (New Users)**

```bash
git clone https://github.com/robynmaya/wit_kickass.git
cd wit_kickass
./setup.sh          # 🎯 One command sets up everything!
```

**What happens automatically:**
- ✅ Validates prerequisites (Docker, Node.js, Python, Ruby)
- ✅ Starts PostgreSQL in Docker
- ✅ Installs ALL dependencies for ALL apps
- ✅ Creates and migrates ALL databases
- ✅ Makes scripts executable

### 🚀 **Start Any App (After Setup)**

```bash
npm run react-express    # Express + React + TypeScript
npm run react-python     # FastAPI + React + Python
npm run react-rails      # Rails + React + Ruby
```

### 🔍 **Health Check**

```bash
npm run health      # Verify everything is working correctly
```

---

## 🌐 App URLs & Ports

| App | Frontend | Backend | API Docs | Database |
|-----|----------|---------|----------|----------|
| **Express** | http://localhost:5173 | http://localhost:5000 | http://localhost:5000/api/health | `express_todos_db` |
| **Python** | http://localhost:5174 | http://localhost:5001 | http://localhost:5001/docs | `fastapi_tasks_db` |
| **Rails** | http://localhost:5175 | http://localhost:3000 | http://localhost:3000/api/projects | `rails_projects_db` |

### 🔌 **Port Configuration**
- **Backends**: Fixed ports (5000, 5001, 3000)
- **Frontends**: Auto-increment if occupied (5173→5174→5175...)
- **PostgreSQL**: Port 5432 (Docker container)

---

## 🗄️ Database Configuration

| App | Database Type | ORM | Persistence |
|-----|---------------|-----|-------------|
| **Express** | PostgreSQL | Prisma | ✅ Persistent |
| **Python** | PostgreSQL | SQLAlchemy | ✅ Persistent |
| **Rails** | PostgreSQL | Active Record | ✅ Persistent |

### � **Shared PostgreSQL Setup:**

- **Single PostgreSQL server** in Docker container
- **Separate databases** for each app:
  - `express_todos_db` - Express app todos
  - `fastapi_tasks_db` - FastAPI app tasks  
  - `rails_projects_db` - Rails app projects
- **Automatic initialization** - databases created on first run
- **Persistent data** - survives container restarts

### 📋 **Database Commands**
```bash
npm run db:start    # Start PostgreSQL container
npm run db:stop     # Stop PostgreSQL container
npm run db:reset    # Reset all databases (removes data!)
```

---

## 🛠️ Tech Stack

### Frontend (All Apps)
- ⚛️ **React 18** with TypeScript
- ⚡ **Vite** for lightning-fast development
- 🎨 **Modern CSS** with responsive design
- 🔄 **Hot Module Replacement** (HMR)

### Backend Technologies

#### 🟨 Express App
- **Node.js 18+** + Express + TypeScript
- **Prisma** ORM with PostgreSQL
- **Nodemon** for auto-restart
- **CORS** enabled for local development
- **RESTful** todo management API

#### 🐍 FastAPI App
- **Python 3.8+** + FastAPI with async/await
- **SQLAlchemy** ORM with PostgreSQL
- **Pydantic** models for automatic validation
- **Uvicorn** ASGI server with hot reload
- **Automatic API documentation** at `/docs`

#### 💎 Rails App
- **Ruby 3.0+** + Rails 8 API-only mode
- **Active Record** ORM with PostgreSQL
- **Rack-CORS** for cross-origin requests
- **Database migrations** and seed data
- **Convention over configuration**

---

## ✨ Features & Learning Objectives

Each app demonstrates identical functionality using different approaches:

### 🎯 **Core Features**
- ✅ **Full CRUD operations** (Create, Read, Update, Delete)
- ✅ **RESTful API design** with proper HTTP methods
- ✅ **Database relationships** and migrations
- ✅ **Input validation** and error handling
- ✅ **CORS configuration** for local development
- ✅ **Hot reload** for rapid development

### 📚 **What You'll Learn**

#### Frontend Skills
- React state management with `useState` and `useEffect`
- API integration with `fetch()` and error handling
- Form validation and user interaction patterns
- TypeScript integration with React components
- Modern CSS layout and responsive design

#### Backend Skills
- **Express**: Middleware patterns, routing, JSON APIs
- **FastAPI**: Async programming, automatic validation, API documentation
- **Rails**: MVC architecture, Active Record patterns, convention over configuration

#### Full-Stack Integration
- Database design and ORM usage across different frameworks
- API design patterns and RESTful conventions
- Cross-origin resource sharing (CORS) configuration
- Environment management and configuration
- Development workflow optimization

---

## 🚦 Prerequisites

- **Docker** (with Docker Desktop running)
- **Node.js** 18+ with npm
- **Python** 3.8+ (for FastAPI app)
- **Ruby** 3.0+ with Bundler (for Rails app)

> **Note:** The setup script validates all prerequisites and provides installation links if anything is missing.

---

## 📋 Available Commands

### 🏗️ **Setup & Health**
```bash
./setup.sh          # Complete environment setup
npm run health       # Check system status
```

### 🚀 **Run Applications**
```bash
npm run react-express    # Express + React (TypeScript)
npm run react-python     # FastAPI + React (Python)
npm run react-rails      # Rails + React (Ruby)
```

### �️ **Database Management**
```bash
npm run db:start    # Start PostgreSQL
npm run db:stop     # Stop PostgreSQL
npm run db:reset    # Reset all databases
```

---

## 📚 Learning Path

### 🥇 **Recommended Progression**

1. **Start with Express** - Most approachable for JavaScript developers
   - Familiar syntax and ecosystem
   - TypeScript for better development experience
   - Prisma for modern database interactions

2. **Try FastAPI** - Learn modern Python async patterns
   - Automatic API documentation
   - Type hints and validation
   - High-performance async capabilities

3. **Explore Rails** - Experience convention over configuration
   - Rapid development with scaffolding
   - Mature ORM with Active Record
   - Full-featured web framework patterns

Each app builds the same features with different approaches, making it easy to **compare and contrast** the technologies.

---

## 🔧 Development Tips

- ✅ **Each app runs independently** - no port conflicts
- ✅ **Hot reload enabled** for both frontend and backend
- ✅ **Use different browser tabs** to run multiple apps simultaneously
- ✅ **Check console logs** for debugging information
- ✅ **Explore API documentation** (especially FastAPI's auto-generated docs)
- ✅ **Database data persists** across application restarts

---

## 🚨 Troubleshooting

### **Docker Issues**
```bash
# Check if Docker is running
docker info

# Restart everything cleanly
npm run db:reset
```

### **Port Conflicts**
If ports are occupied, frontends auto-increment to find available ports:
- Express: 5173 → 5174 → 5175...
- FastAPI: 5174 → 5175 → 5176...
- Rails: 5175 → 5176 → 5177...

### **Complete Reset**
```bash
npm run db:stop
docker system prune -f
./setup.sh
```

### **Individual App Issues**
Each app has dependency checks in their start scripts:
```bash
cd react-express-app && ./start.sh    # Express app only
cd react-python-app && ./start.sh     # FastAPI app only
cd react-rails-app && ./start.sh      # Rails app only
```

---

## 🤝 Contributing

This workspace is designed for learning and experimentation! Feel free to:

- ✅ **Add new features** to existing apps
- ✅ **Create additional backend integrations**
- ✅ **Improve styling and UX**
- ✅ **Add testing frameworks**
- ✅ **Experiment with different React patterns**
- ✅ **Try new database schemas**

---

## 🎯 Perfect For

- 🎓 **Learning full-stack development**
- 🔄 **Comparing backend technologies**
- 🚀 **Rapid prototyping**
- 📚 **Teaching modern web development**
- 🏗️ **Architecture exploration**
- 💼 **Portfolio projects**

---

## 📄 License

MIT License - Feel free to use this for learning, teaching, and building amazing things!

---

<div align="center">

**🎉 Happy Coding! 🎉**

*Built with ❤️ for full-stack learning*

</div>
