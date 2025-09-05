# React + Rails Project Manager

A project management application built with React (TypeScript) and Ruby on Rails API.

## 🏗 Architecture

- **Frontend**: React + TypeScript + Vite (Port 5173)
- **Backend**: Ruby on Rails 8 API (Port 3000)
- **Database**: SQLite (development) / PostgreSQL (production)
- **API**: RESTful JSON API with Rails conventions

## 🚀 Getting Started

### Prerequisites
- Ruby 3.1+ (you have 3.2.1 ✅)
- Rails 8+ (you have 8.0.2.1 ✅)
- Node.js (v18+)
- npm

### Installation & Setup

✅ **Backend is already configured!**

The Rails API includes:
- Project model with validations
- RESTful API endpoints (`/api/projects`)
- CORS configuration for React
- Database migrations and seed data
- Health check endpoint (`/api/health`)

### Running the Application

1. **Start the Rails Backend**
   ```bash
   cd backend
   rails server
   ```
   API will run on `http://localhost:3000`

2. **Start the React Frontend (in a new terminal)**
   ```bash
   cd frontend
   npm run dev
   ```
   Frontend will run on `http://localhost:5173`

## 📚 Learning Goals

- [x] Set up Rails 8 API application
- [x] Create RESTful API with Rails conventions
- [x] Implement Active Record models and validations
- [x] Configure CORS for React integration
- [x] Database migrations and seed data
- [x] Full CRUD operations
- [x] React frontend with API integration
- [ ] Add user authentication (devise-jwt)
- [ ] Implement pagination and filtering
- [ ] Add background jobs with Active Job
- [ ] Deploy with Kamal
- [ ] Add real-time updates with Action Cable

## 🛠 API Endpoints

- `GET /api/health` - Health check with Rails/Ruby info
- `GET /api/projects` - Get all projects
- `POST /api/projects` - Create a new project
- `GET /api/projects/:id` - Get a specific project
- `PUT /api/projects/:id` - Update a project
- `DELETE /api/projects/:id` - Delete a project

## 🎯 Rails Concepts Practiced

### Backend (Rails)
- **API-only Rails application** configuration
- **Active Record** models, validations, and associations
- **RESTful routing** with Rails conventions
- **JSON API responses** with proper HTTP status codes
- **Database migrations** and schema management
- **Seed data** for development
- **CORS configuration** for cross-origin requests
- **Rails conventions** (naming, structure, etc.)

### Frontend (React)
- **HTTP API integration** with fetch
- **CRUD operations** from React
- **Error handling** and loading states
- **TypeScript interfaces** for API data
- **Form handling** and validation

## 🚀 Next Features to Implement

1. **User Authentication**
   - Add devise and devise-jwt gems
   - User registration/login API
   - Protected routes

2. **Advanced Rails Features**
   - Background jobs with Active Job
   - File uploads with Active Storage
   - Email with Action Mailer
   - Real-time with Action Cable

3. **Database Improvements**
   - PostgreSQL for production
   - Database indexing
   - Complex associations

4. **Testing**
   - RSpec for backend testing
   - Request specs for API
   - React Testing Library for frontend

5. **Deployment**
   - Kamal deployment (built-in with Rails 8)
   - Environment configuration
   - Production database setup

## 📝 Development Notes

This Rails app demonstrates:
- **Modern Rails patterns** (Rails 8 features)
- **API-first development** approach
- **Rails conventions** vs Express flexibility
- **Active Record ORM** vs raw SQL
- **Integrated tooling** (migrations, generators, etc.)

Perfect for comparing Rails conventions with Express.js patterns!
