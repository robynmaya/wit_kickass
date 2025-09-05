#!/bin/bash

# React + Express App Launcher
# Starts both frontend and backend with hot reload + PostgreSQL

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
NC='\033[0m'

print_status() {
    echo -e "${GREEN}[$(date +'%H:%M:%S')] $1${NC}"
}

print_info() {
    echo -e "${BLUE}[$(date +'%H:%M:%S')] $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}[$(date +'%H:%M:%S')] $1${NC}"
}

# Function to cleanup processes on exit
cleanup() {
    print_info "Shutting down Express app..."
    if [ ! -z "$BACKEND_PID" ]; then
        kill $BACKEND_PID 2>/dev/null || true
    fi
    if [ ! -z "$FRONTEND_PID" ]; then
        kill $FRONTEND_PID 2>/dev/null || true
    fi
    print_status "Express app stopped. Goodbye!"
}

# Set up signal handlers
trap cleanup SIGINT SIGTERM EXIT

print_status "🚀 Starting React + Express App with PostgreSQL"
echo

# Check if we're in the right directory
if [ ! -d "backend" ] || [ ! -d "frontend" ]; then
    echo "Error: Please run this script from the react-express-app directory"
    echo "Usage: cd react-express-app && ./start.sh"
    exit 1
fi

# Check if Docker is running
if ! docker info >/dev/null 2>&1; then
    print_warning "❌ Docker is not running. Please start Docker first."
    exit 1
fi

# Start PostgreSQL if not running
if ! docker ps | grep -q wit_postgres; then
    print_info "🐘 Starting PostgreSQL..."
    cd .. && docker-compose up -d postgres && cd react-express-app
    sleep 3
fi

# Install dependencies if needed
if [ ! -d "backend/node_modules" ]; then
    print_info "Installing backend dependencies..."
    cd backend && npm install && cd ..
fi

if [ ! -d "frontend/node_modules" ]; then
    print_info "Installing frontend dependencies..."
    cd frontend && npm install && cd ..
fi

# Run Prisma migrations
print_info "🔄 Setting up database..."
cd backend && npx prisma generate && npx prisma db push && cd ..

# Start backend
print_info "Starting Express backend (Port 5000)..."
cd backend
npm run dev &
BACKEND_PID=$!
cd ..
print_status "Express backend started (PID: $BACKEND_PID)"

# Wait for backend to start
sleep 3

# Start frontend
print_info "Starting React frontend (Port 5173)..."
cd frontend
npm run dev &
FRONTEND_PID=$!
cd ..
print_status "React frontend started (PID: $FRONTEND_PID)"

echo
print_status "🎉 Express app is running!"
print_info "Frontend: http://localhost:5173"
print_info "Backend:  http://localhost:5000"
print_info "API:      http://localhost:5000/api/health"
print_info "Database: PostgreSQL on localhost:5432"
echo
print_status "Press Ctrl+C to stop both servers"
print_info "Both servers have hot reload enabled"

# Keep script running
wait
