# React + FastAPI Task Manager

A task management application built with React (TypeScript) and Python FastAPI.

## 🏗 Architecture

- **Frontend**: React + TypeScript + Vite (Port 5174)
- **Backend**: Python + FastAPI + Uvicorn (Port 5001)
- **Database**: In-memory (easily upgradeable to PostgreSQL/SQLite)
- **API**: RESTful with automatic OpenAPI docs

## 🚀 Getting Started

### Prerequisites
- Python 3.8+
- Node.js (v18+)
- pip (Python package manager)

### Installation & Setup

1. **Set up Python Virtual Environment (Recommended)**
   ```bash
   cd backend
   python3 -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

2. **Install Python Dependencies**
   ```bash
   pip install -r requirements.txt
   ```

3. **Install Frontend Dependencies**
   ```bash
   cd ../frontend
   npm install
   ```

### Running the Application

1. **Start the FastAPI Backend**
   ```bash
   cd backend
   python3 app.py
   # Or with uvicorn directly: uvicorn app:app --reload --port 5001
   ```
   Server will run on `http://localhost:5001`
   **API Docs**: `http://localhost:5001/docs` (automatic Swagger UI!)

2. **Start the React Frontend (in a new terminal)**
   ```bash
   cd frontend
   npm run dev
   ```
   Frontend will run on `http://localhost:5174`

## 📚 Learning Goals

- [x] Set up FastAPI web server with async support
- [x] Create RESTful API with automatic documentation
- [x] Implement Pydantic models for request/response validation
- [x] Handle CORS for React integration
- [x] Full CRUD operations with proper HTTP status codes
- [x] Type hints and async/await patterns
- [ ] Add SQLAlchemy for database ORM
- [ ] Implement JWT authentication with FastAPI Security
- [ ] Add background tasks with FastAPI BackgroundTasks
- [ ] Database migrations with Alembic
- [ ] Add comprehensive testing with pytest
- [ ] Deploy with Docker and FastAPI

## 🛠 API Endpoints

- `GET /api/health` - Health check with FastAPI info
- `GET /api/tasks` - Get all tasks
- `POST /api/tasks` - Create a new task
- `GET /api/tasks/{id}` - Get a specific task
- `PUT /api/tasks/{id}` - Update a task
- `DELETE /api/tasks/{id}` - Delete a task
- `GET /docs` - Interactive API documentation (Swagger UI)
- `GET /redoc` - Alternative API documentation

## 🎯 FastAPI Features Demonstrated

### Backend (FastAPI)
- **Async/await support** for high performance
- **Automatic API documentation** with Swagger UI
- **Pydantic models** for request/response validation
- **Type hints** throughout the codebase
- **Dependency injection** system
- **Built-in CORS middleware**
- **HTTP exception handling**
- **JSON schema generation**

### Frontend (React)
- **HTTP API integration** with fetch
- **TypeScript interfaces** matching Pydantic models
- **Error handling** and loading states
- **Form validation** and submission

## 🚀 Next Features to Implement

1. **Database Integration**
   - SQLAlchemy ORM with async support
   - PostgreSQL or SQLite database
   - Alembic migrations

2. **Authentication & Security**
   - JWT token authentication
   - FastAPI Security utilities
   - Password hashing with bcrypt
   - OAuth2 integration

3. **Advanced FastAPI Features**
   - Background tasks
   - WebSocket support for real-time updates
   - File upload handling
   - Request/response middleware

4. **Testing & Deployment**
   - pytest with async test client
   - Docker containerization
   - CI/CD with GitHub Actions
   - Deploy to cloud platforms

## ⚡ FastAPI Advantages

Compared to Flask, FastAPI offers:
- **Automatic API docs** (no extra setup needed)
- **Built-in data validation** with Pydantic
- **Async/await support** for better performance
- **Type hints** for better IDE support
- **Modern Python features** (3.8+)
- **High performance** (comparable to Node.js/Go)

## 📝 Development Notes

This FastAPI app demonstrates:
- **Modern Python async patterns**
- **Automatic API documentation**
- **Type-safe development** with Pydantic
- **Clean architecture** with separation of concerns
- **Performance-focused** async web framework

Perfect for learning modern Python web development!
