# 🚀 Full-Stack Practice Workspace

**Master React with multiple backend technologies in one comprehensive workspace!**

A complete development environment featuring **React frontends** paired with **Express (Node.js)**, **FastAPI (Python)**, and **Rails (Ruby)** backends. Each app demonstrates the same features using different technology stacks, making it perfect for learning and comparing approaches.

---

## 📁 Project Structure

```
wit_kickass/
├── 🟨 react-express-app/     # React + Express + TypeScript + Raw SQL
├── 🐍 react-python-app/      # React + FastAPI + Python + Raw SQL
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

| App | Database Type | Query Method | Persistence |
|-----|---------------|--------------|-------------|
| **Express** | PostgreSQL | Raw SQL + pg | ✅ Persistent |
| **Python** | PostgreSQL | Raw SQL + psycopg2 | ✅ Persistent |
| **Rails** | PostgreSQL | Active Record ORM | ✅ Persistent |

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
- **Raw SQL queries** with pg (node-postgres)
- **Nodemon** for auto-restart
- **CORS** enabled for local development
- **RESTful** todo management API

#### 🐍 FastAPI App
- **Python 3.8+** + FastAPI with async/await
- **Raw SQL queries** with psycopg2 or asyncpg
- **Pydantic** models for automatic validation
- **Uvicorn** ASGI server with hot reload
- **Automatic API documentation** at `/docs`

#### 💎 Rails App
- **Ruby 3.0+** + Rails 8 API-only mode
- **Active Record ORM** for database interactions
- **Rack-CORS** for cross-origin requests
- **Database migrations** for schema management
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
- React state management with `useState`, `useEffect`, and `useReducer`
- Custom hooks creation and reusable logic patterns
- Component composition and prop drilling solutions
- Context API for global state management
- Performance optimization with `useMemo`, `useCallback`, and `React.memo`
- Code splitting and lazy loading with `React.lazy` and `Suspense`
- Error boundaries and error handling strategies
- Conditional rendering and list rendering patterns
- Event handling and form management
- API integration with `fetch()`, loading states, and error handling
- Real-time data with polling, WebSockets, and Server-Sent Events
- Debouncing and throttling for performance optimization
- Virtual scrolling for large datasets
- TypeScript integration with React components and props
- Modern CSS techniques (Flexbox, Grid, CSS Modules)
- Responsive design and mobile-first approaches
- Component testing strategies and best practices
- Advanced patterns: Render props, Higher-Order Components (HOCs)
- State machines and complex state management
- Micro-frontends and component libraries

#### Backend Skills
- **Express**: Middleware patterns, routing, raw SQL queries with pg
- **FastAPI**: Async programming, raw SQL with psycopg2/asyncpg, API documentation
- **Rails**: MVC architecture, Active Record ORM, database migrations and associations

#### Full-Stack Integration
- Database design and SQL query optimization
- SQL injection prevention and parameterized queries (Express/FastAPI)
- ORM relationships and migrations (Rails Active Record)
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

This workspace is designed for learning and experimentation! We welcome contributions that help improve the learning experience for everyone.

### 🌿 **Contribution Workflow**

1. **Fork the repository** to your GitHub account
2. **Create a new branch** from `main` for your changes:
   ```bash
   git checkout -b feature/your-feature-name
   # or
   git checkout -b fix/issue-description
   ```
3. **Make your changes** and test them thoroughly
4. **Commit using conventional format** (see below)
5. **Push your branch** to your fork
6. **Create a Pull Request** against the `main` branch

### 📝 **Commit Message Format**

Use conventional commit format: `type: description`

#### **Commit Types:**
- **`feat:`** ✨ **New features** - Adding new functionality, components, or capabilities
  ```bash
  feat: add user authentication to Express app
  feat: implement real-time updates with WebSockets
  ```

- **`fix:`** 🐛 **Bug fixes** - Correcting errors, issues, or broken functionality
  ```bash
  fix: resolve CORS issue in FastAPI backend
  fix: correct database connection timeout
  ```

- **`docs:`** 📚 **Documentation** - Updates to README, comments, or guides
  ```bash
  docs: update installation instructions
  docs: add API endpoint examples
  ```

- **`chore:`** 🧹 **Maintenance** - Dependencies, configuration, or housekeeping tasks
  ```bash
  chore: update npm dependencies
  chore: configure ESLint rules
  ```

### 💡 **Contribution Ideas**

Feel free to contribute:

- ✅ **Add new features** to existing apps (authentication, file upload, etc.)
- ✅ **Add more API endpoints** - Expand functionality with new routes like:
  - User authentication (login, register, JWT tokens)
  - File upload/download endpoints
  - Search and filtering capabilities
  - User profiles and settings
  - Comments or reviews system
- ✅ **Improve styling and UX** with better CSS or UI libraries
- ✅ **Add testing frameworks** (Jest, Pytest, RSpec)
- ✅ **Experiment with different React patterns** (Context, Redux, Zustand)
- ✅ **Try new database schemas** or add more complex relationships
- ✅ **Enhance developer experience** with better tooling or scripts
- ✅ **Add deployment guides** (Docker, Heroku, Vercel)

### 🔍 **Code Review Guidelines**

- Ensure all apps still work after your changes
- Test with `npm run health` before submitting
- Keep changes focused and atomic
- Update documentation if needed
- Follow existing code style and patterns

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
