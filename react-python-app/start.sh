#!/bin/bash

# React + FastAPI App Launcher
# Starts both frontend and backend with hot reload

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
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
    print_info "Shutting down FastAPI app..."
    if [ ! -z "$BACKEND_PID" ]; then
        kill $BACKEND_PID 2>/dev/null || true
    fi
    if [ ! -z "$FRONTEND_PID" ]; then
        kill $FRONTEND_PID 2>/dev/null || true
    fi
    print_status "FastAPI app stopped. Goodbye!"
}

# Set up signal handlers
trap cleanup SIGINT SIGTERM EXIT

print_status "🐍 Starting React + FastAPI App"
echo

# Check if we're in the right directory
if [ ! -d "backend" ] || [ ! -d "frontend" ]; then
    echo "Error: Please run this script from the react-python-app directory"
    echo "Usage: cd react-python-app && ./start.sh"
    exit 1
fi

# Check Python dependencies
if ! python3 -c "import fastapi" 2>/dev/null; then
    print_warning "FastAPI not found. Installing Python dependencies..."
    cd backend
    pip3 install -r requirements.txt
    cd ..
fi

# Install frontend dependencies if needed
if [ ! -d "frontend/node_modules" ]; then
    print_info "Installing frontend dependencies..."
    cd frontend && npm install && cd ..
fi

# Start backend
print_info "Starting FastAPI backend (Port 5001)..."
cd backend
python3 app.py &
BACKEND_PID=$!
cd ..
print_status "FastAPI backend started (PID: $BACKEND_PID)"

# Wait for backend to start
sleep 4

# Start frontend
print_info "Starting React frontend (Port 5174)..."
cd frontend
VITE_PORT=5174 npm run dev &
FRONTEND_PID=$!
cd ..
print_status "React frontend started (PID: $FRONTEND_PID)"

echo
print_status "🎉 FastAPI app is running!"
print_info "Frontend:  http://localhost:5174"
print_info "Backend:   http://localhost:5001"
print_info "API:       http://localhost:5001/api/health"
print_info "Docs:      http://localhost:5001/docs"
print_info "ReDoc:     http://localhost:5001/redoc"
echo
print_status "Press Ctrl+C to stop both servers"
print_info "Both servers have hot reload enabled"

# Keep script running
wait
