#!/bin/bash

# Multi-App Development Server Launcher
# Starts all React frontends and backends with hot reload

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[$(date +'%H:%M:%S')] $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}[$(date +'%H:%M:%S')] $1${NC}"
}

print_error() {
    echo -e "${RED}[$(date +'%H:%M:%S')] $1${NC}"
}

print_info() {
    echo -e "${BLUE}[$(date +'%H:%M:%S')] $1${NC}"
}

# Function to check if port is in use
check_port() {
    if lsof -Pi :$1 -sTCP:LISTEN -t >/dev/null ; then
        print_warning "Port $1 is already in use"
        return 1
    fi
    return 0
}

# Function to check dependencies
check_dependencies() {
    print_info "Checking dependencies..."
    
    if ! command -v node &> /dev/null; then
        print_error "Node.js is not installed"
        exit 1
    fi
    
    if ! command -v npm &> /dev/null; then
        print_error "npm is not installed"
        exit 1
    fi
    
    if ! command -v python3 &> /dev/null; then
        print_error "Python 3 is not installed"
        exit 1
    fi
    
    if ! command -v rails &> /dev/null; then
        print_warning "Rails is not installed - Rails app will be skipped"
        SKIP_RAILS=true
    fi
    
    print_status "All required dependencies found!"
}

# Function to install dependencies if needed
install_dependencies() {
    print_info "Installing dependencies..."
    
    # Express app dependencies
    if [ ! -d "react-express-app/frontend/node_modules" ]; then
        print_info "Installing Express frontend dependencies..."
        cd react-express-app/frontend && npm install && cd ../..
    fi
    
    if [ ! -d "react-express-app/backend/node_modules" ]; then
        print_info "Installing Express backend dependencies..."
        cd react-express-app/backend && npm install && cd ../..
    fi
    
    # Python app dependencies
    if [ ! -d "react-python-app/frontend/node_modules" ]; then
        print_info "Installing Python frontend dependencies..."
        cd react-python-app/frontend && npm install && cd ../..
    fi
    
    # Rails app dependencies
    if [ "$SKIP_RAILS" != "true" ]; then
        if [ ! -d "react-rails-app/frontend/node_modules" ]; then
            print_info "Installing Rails frontend dependencies..."
            cd react-rails-app/frontend && npm install && cd ../..
        fi
    fi
    
    print_status "Dependencies installed!"
}

# Function to start Express backend
start_express_backend() {
    print_info "Starting Express backend (Port 5000)..."
    cd react-express-app/backend
    npm run dev &
    EXPRESS_BACKEND_PID=$!
    cd ../..
    print_status "Express backend started (PID: $EXPRESS_BACKEND_PID)"
}

# Function to start Express frontend
start_express_frontend() {
    print_info "Starting Express frontend (Port 5173)..."
    cd react-express-app/frontend
    npm run dev &
    EXPRESS_FRONTEND_PID=$!
    cd ../..
    print_status "Express frontend started (PID: $EXPRESS_FRONTEND_PID)"
}

# Function to start Python backend
start_python_backend() {
    print_info "Starting Python FastAPI backend (Port 5001)..."
    cd react-python-app/backend
    python3 app.py &
    PYTHON_BACKEND_PID=$!
    cd ../..
    print_status "Python FastAPI backend started (PID: $PYTHON_BACKEND_PID)"
}

# Function to start Python frontend
start_python_frontend() {
    print_info "Starting Python frontend (Port 5174)..."
    cd react-python-app/frontend
    VITE_PORT=5174 npm run dev &
    PYTHON_FRONTEND_PID=$!
    cd ../..
    print_status "Python frontend started (PID: $PYTHON_FRONTEND_PID)"
}

# Function to start Rails backend
start_rails_backend() {
    if [ "$SKIP_RAILS" == "true" ]; then
        print_warning "Skipping Rails backend (Rails not installed)"
        return
    fi
    
    print_info "Starting Rails backend (Port 3000)..."
    cd react-rails-app/backend
    rails server &
    RAILS_BACKEND_PID=$!
    cd ../..
    print_status "Rails backend started (PID: $RAILS_BACKEND_PID)"
}

# Function to start Rails frontend
start_rails_frontend() {
    if [ "$SKIP_RAILS" == "true" ]; then
        print_warning "Skipping Rails frontend (Rails not installed)"
        return
    fi
    
    print_info "Starting Rails frontend (Port 5175)..."
    cd react-rails-app/frontend
    VITE_PORT=5175 npm run dev &
    RAILS_FRONTEND_PID=$!
    cd ../..
    print_status "Rails frontend started (PID: $RAILS_FRONTEND_PID)"
}

# Function to cleanup processes on exit
cleanup() {
    print_info "Shutting down servers..."
    
    if [ ! -z "$EXPRESS_BACKEND_PID" ]; then
        kill $EXPRESS_BACKEND_PID 2>/dev/null || true
    fi
    if [ ! -z "$EXPRESS_FRONTEND_PID" ]; then
        kill $EXPRESS_FRONTEND_PID 2>/dev/null || true
    fi
    if [ ! -z "$PYTHON_BACKEND_PID" ]; then
        kill $PYTHON_BACKEND_PID 2>/dev/null || true
    fi
    if [ ! -z "$PYTHON_FRONTEND_PID" ]; then
        kill $PYTHON_FRONTEND_PID 2>/dev/null || true
    fi
    if [ ! -z "$RAILS_BACKEND_PID" ]; then
        kill $RAILS_BACKEND_PID 2>/dev/null || true
    fi
    if [ ! -z "$RAILS_FRONTEND_PID" ]; then
        kill $RAILS_FRONTEND_PID 2>/dev/null || true
    fi
    
    print_status "All servers stopped. Goodbye!"
}

# Set up signal handlers
trap cleanup SIGINT SIGTERM EXIT

# Main execution
print_status "🚀 Starting WIT Kickass Development Environment"
print_info "This will start all React frontends and backends with hot reload"
echo

# Parse command line arguments
APPS_TO_START="all"
while [[ $# -gt 0 ]]; do
    case $1 in
        --express-only)
            APPS_TO_START="express"
            shift
            ;;
        --python-only)
            APPS_TO_START="python"
            shift
            ;;
        --rails-only)
            APPS_TO_START="rails"
            shift
            ;;
        --help)
            echo "Usage: $0 [OPTIONS]"
            echo "Options:"
            echo "  --express-only    Start only Express app"
            echo "  --python-only     Start only Python app"
            echo "  --rails-only      Start only Rails app"
            echo "  --help           Show this help message"
            exit 0
            ;;
        *)
            print_error "Unknown option: $1"
            exit 1
            ;;
    esac
done

check_dependencies
install_dependencies

# Wait a moment for any cleanup
sleep 2

# Start servers based on selection
case $APPS_TO_START in
    "express")
        start_express_backend
        sleep 3
        start_express_frontend
        print_status "Express app running at:"
        print_info "  Frontend: http://localhost:5173"
        print_info "  Backend:  http://localhost:5000"
        ;;
    "python")
        start_python_backend
        sleep 3
        start_python_frontend
        print_status "Python app running at:"
        print_info "  Frontend: http://localhost:5174"
        print_info "  Backend:  http://localhost:5001"
        print_info "  API Docs: http://localhost:5001/docs"
        ;;
    "rails")
        start_rails_backend
        sleep 5
        start_rails_frontend
        print_status "Rails app running at:"
        print_info "  Frontend: http://localhost:5175"
        print_info "  Backend:  http://localhost:3000"
        ;;
    "all")
        # Start all backends first
        start_express_backend
        sleep 2
        start_python_backend
        sleep 2
        start_rails_backend
        
        # Wait for backends to start
        sleep 5
        
        # Start all frontends
        start_express_frontend
        sleep 2
        start_python_frontend
        sleep 2
        start_rails_frontend
        
        echo
        print_status "🎉 All apps are running!"
        print_info "Express App:"
        print_info "  Frontend: http://localhost:5173"
        print_info "  Backend:  http://localhost:5000/api/health"
        echo
        print_info "Python App:"
        print_info "  Frontend: http://localhost:5174"
        print_info "  Backend:  http://localhost:5001/api/health"
        print_info "  API Docs: http://localhost:5001/docs"
        echo
        if [ "$SKIP_RAILS" != "true" ]; then
            print_info "Rails App:"
            print_info "  Frontend: http://localhost:5175"
            print_info "  Backend:  http://localhost:3000/api/health"
        fi
        ;;
esac

echo
print_status "Press Ctrl+C to stop all servers"
print_info "All servers have hot reload enabled - changes will be automatically reflected"

# Keep script running
wait
