# Development Commands Cheat Sheet

## Individual App Scripts (Recommended)

### Express App
```bash
cd react-express-app
./start.sh
```
- Starts both Express backend (5000) and React frontend (5173)
- Includes dependency installation and hot reload
- Ctrl+C stops both servers

### Python/FastAPI App  
```bash
cd react-python-app
./start.sh
```
- Starts both FastAPI backend (5001) and React frontend (5174)
- Includes dependency installation and hot reload
- Ctrl+C stops both servers
- Access API docs at http://localhost:5001/docs

### Rails App
```bash
cd react-rails-app
./start.sh
```
- Starts both Rails backend (3000) and React frontend (5175)
- Includes gem installation, database setup, and hot reload
- Ctrl+C stops both servers

## Manual Commands (Alternative)

### Express App (Port 5000 + 5173)
```bash
# Backend
cd react-express-app/backend
npm run dev

# Frontend  
cd react-express-app/frontend
npm run dev
```

### Python App (Port 5001 + 5174)
```bash
# Backend
cd react-python-app/backend
python3 app.py

# Frontend
cd react-python-app/frontend  
VITE_PORT=5174 npm run dev
```

### Rails App (Port 3000 + 5175)
```bash
# Backend
cd react-rails-app/backend
rails server

# Frontend
cd react-rails-app/frontend
VITE_PORT=5175 npm run dev
```

## All Apps at Once
```bash
# From workspace root
./dev-start.sh              # All apps
./dev-start.sh --express-only # Express only
./dev-start.sh --python-only  # Python only  
./dev-start.sh --rails-only   # Rails only
```

## VS Code Tasks
- `Ctrl+Shift+P` → "Tasks: Run Task"
- Choose from pre-configured tasks for each app

## Learning Path Suggestions

### Week 1: Express App
- [ ] Get basic todo CRUD working
- [ ] Add database (MongoDB/PostgreSQL)
- [ ] Implement user authentication

### Week 2: Python/FastAPI App  
- [ ] Build task management with FastAPI
- [ ] Explore automatic API documentation
- [ ] Implement async patterns and JWT auth

### Week 3: Rails App
- [ ] Set up Rails API
- [ ] Learn Rails conventions
- [ ] Build RESTful resources

## Port Reference
- Express Backend: 5000
- FastAPI Backend: 5001  
- Rails Backend: 3000
- Express Frontend: 5173
- Python Frontend: 5174
- Rails Frontend: 5175

## API Documentation
- Express: http://localhost:5000/api/health
- FastAPI: http://localhost:5001/docs (Swagger UI)
- Rails: http://localhost:3000/api/health
