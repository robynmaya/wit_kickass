#!/bin/bash

# React + Rails App Launcher
# Starts both frontend and backend with hot reload

set -e

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
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

print_error() {
    echo -e "${RED}[$(date +'%H:%M:%S')] $1${NC}"
}

# Function to cleanup processes on exit
cleanup() {
    print_info "Shutting down Rails app..."
    if [ ! -z "$BACKEND_PID" ]; then
        kill $BACKEND_PID 2>/dev/null || true
    fi
    if [ ! -z "$FRONTEND_PID" ]; then
        kill $FRONTEND_PID 2>/dev/null || true
    fi
    print_status "Rails app stopped. Goodbye!"
}

# Set up signal handlers
trap cleanup SIGINT SIGTERM EXIT

print_status "💎 Starting React + Rails App"
echo

# Check if we're in the right directory
if [ ! -d "backend" ] || [ ! -d "frontend" ]; then
    echo "Error: Please run this script from the react-rails-app directory"
    echo "Usage: cd react-rails-app && ./start.sh"
    exit 1
fi

# Check if Rails is installed
if ! command -v rails &> /dev/null; then
    print_error "Rails is not installed. Please install Rails first:"
    print_info "gem install rails"
    exit 1
fi

# Check if bundle is installed and run bundle install if needed
cd backend
if [ ! -f "Gemfile.lock" ] || [ "Gemfile" -nt "Gemfile.lock" ]; then
    print_warning "Installing Ruby gems..."
    bundle install
fi

# Check if database exists, if not, set it up
if [ ! -f "db/development.sqlite3" ]; then
    print_info "Setting up database..."
    rails db:create db:migrate db:seed
fi
cd ..

# Install frontend dependencies if needed
if [ ! -d "frontend/node_modules" ]; then
    print_info "Installing frontend dependencies..."
    cd frontend && npm install && cd ..
fi

# Start backend
print_info "Starting Rails backend (Port 3000)..."
cd backend
rails server &
BACKEND_PID=$!
cd ..
print_status "Rails backend started (PID: $BACKEND_PID)"

# Wait for backend to start
sleep 6

# Start frontend
print_info "Starting React frontend (Port 5175)..."
cd frontend
VITE_PORT=5175 npm run dev &
FRONTEND_PID=$!
cd ..
print_status "React frontend started (PID: $FRONTEND_PID)"

echo
print_status "🎉 Rails app is running!"
print_info "Frontend:   http://localhost:5175"
print_info "Backend:    http://localhost:3000"
print_info "API:        http://localhost:3000/api/health"
print_info "Projects:   http://localhost:3000/api/projects"
echo
print_status "Press Ctrl+C to stop both servers"
print_info "Both servers have hot reload enabled"

# Keep script running
wait
