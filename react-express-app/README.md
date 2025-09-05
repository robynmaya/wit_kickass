# React + Express Todo App

A simple full-stack todo application built with React (TypeScript) and Express.js.

## 🏗 Architecture

- **Frontend**: React + TypeScript + Vite
- **Backend**: Node.js + Express + TypeScript
- **Database**: In-memory (easily extensible to MongoDB/PostgreSQL)

## 🚀 Getting Started

### Prerequisites
- Node.js (v18+)
- npm

### Installation & Setup

1. **Install Backend Dependencies**
   ```bash
   cd backend
   npm install
   ```

2. **Install Frontend Dependencies**
   ```bash
   cd frontend
   npm install
   ```

### Running the Application

1. **Start the Backend Server**
   ```bash
   cd backend
   npm run dev
   ```
   Server will run on `http://localhost:5000`

2. **Start the Frontend (in a new terminal)**
   ```bash
   cd frontend
   npm run dev
   ```
   Frontend will run on `http://localhost:5173`

## 📚 Learning Goals

- [x] Set up a basic Express server with TypeScript
- [x] Create RESTful API endpoints
- [x] Handle CORS for local development
- [x] Build React frontend with TypeScript
- [x] Make HTTP requests from React to Express
- [x] Handle form submissions and state management
- [ ] Add database integration (MongoDB/PostgreSQL)
- [ ] Implement user authentication
- [ ] Add real-time updates with WebSockets
- [ ] Deploy to cloud platforms

## 🛠 API Endpoints

- `GET /api/health` - Health check
- `GET /api/todos` - Get all todos
- `POST /api/todos` - Create a new todo

## 🎯 Next Features to Implement

1. **Database Integration**
   - Add MongoDB with mongoose
   - Or PostgreSQL with prisma

2. **Todo Operations**
   - Update todo completion status
   - Delete todos
   - Edit todo text

3. **User Authentication**
   - JWT-based auth
   - Protected routes

4. **Real-time Updates**
   - WebSocket connection
   - Live updates across clients

5. **Testing**
   - Unit tests for API endpoints
   - React component testing

## 📝 Notes

This is a practice project focusing on:
- Modern React patterns (hooks, functional components)
- TypeScript in both frontend and backend
- RESTful API design
- Local development workflow
