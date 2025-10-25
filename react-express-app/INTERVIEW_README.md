# 🎯 Interview Setup - React + Express Full-Stack Project

## ✅ Quick Start Commands

```bash
# Start backend (Terminal 1)
cd react-express-app/backend
npm install
npm run dev

# Start frontend (Terminal 2) 
cd react-express-app/frontend
npm install
npm run dev
```

**Backend:** http://localhost:3001  
**Frontend:** http://localhost:5173

## 🏗️ Project Structure

```
react-express-app/
├── backend/          # Express + TypeScript + PostgreSQL
│   ├── src/index.ts  # Main server file with API routes
│   └── package.json  # Dependencies
└── frontend/         # React + TypeScript + Vite
    ├── src/
    │   ├── App.tsx         # Main app component
    │   └── InterviewApp.tsx # Clean starting component
    └── package.json    # Dependencies
```

## 🚀 What's Ready

- ✅ **Backend API** - Express server with TypeScript
- ✅ **Database** - PostgreSQL with users/todos tables
- ✅ **Frontend** - React with TypeScript and Vite
- ✅ **CORS** - Configured for local development
- ✅ **Sample Data** - Users endpoint with test data
- ✅ **Clean Starting Point** - InterviewApp.tsx component

## 📡 Available API Endpoints

- `GET /api/health` - Server health check
- `GET /api/users` - Fetch all users
- `GET /api/todos` - Fetch all todos
- `POST /api/todos` - Create new todo
- `PUT /api/todos/:id` - Update todo
- `DELETE /api/todos/:id` - Delete todo

## 🎯 Interview Strategy

1. **Show existing setup** - Demonstrate working full-stack connection
2. **Build incrementally** - Start with simple features, add complexity
3. **Explain decisions** - Talk through your approach as you code
4. **Use TypeScript** - Show type safety and interfaces
5. **Handle errors** - Add proper error handling and loading states

## 💡 Quick Feature Ideas

- User management (CRUD operations)
- Todo app with user assignment
- Real-time updates
- Form validation
- Search/filtering
- Authentication simulation
- Data visualization

## 🔧 Development Tips

- Frontend runs on port 5173 (Vite)
- Backend runs on port 3001 (Express)
- Database auto-initializes with sample data
- Hot reload enabled for both frontend/backend
- TypeScript configured for both projects

**Ready to impress! 🚀**
```bash
# Test backend endpoints
curl http://localhost:3001/api/health

# Database operations (if needed)
psql -d express_todos_db

# Frontend development
npm run dev
```

## 📁 Project Structure
```
interview-project/
├── backend/
│   ├── src/
│   │   ├── index.ts          # Express server
│   │   ├── routes/           # API endpoints
│   │   └── database/         # DB setup
│   └── package.json
├── frontend/
│   ├── src/
│   │   ├── InterviewApp.tsx  # Clean starting point
│   │   ├── components/       # Build components here
│   │   └── App.tsx           # Main app
│   └── package.json
└── README.md
```

Ready for your interview! 🎉