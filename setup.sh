#!/bin/bash

# Full-Stack Practice Workspace Setup Script
# Ensures Docker, dependencies, and databases are properly configured

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_header() {
    echo -e "${BLUE}============================================${NC}"
    echo -e "${BLUE}🚀 Full-Stack Practice Workspace Setup${NC}"
    echo -e "${BLUE}============================================${NC}"
    echo
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check Docker status
check_docker() {
    print_info "Checking Docker installation..."
    
    if ! command_exists docker; then
        print_error "Docker is not installed!"
        echo
        echo "Please install Docker:"
        echo "  macOS: https://docs.docker.com/desktop/install/mac-install/"
        echo "  Linux: https://docs.docker.com/engine/install/"
        echo "  Windows: https://docs.docker.com/desktop/install/windows-install/"
        exit 1
    fi
    
    if ! docker info >/dev/null 2>&1; then
        print_error "Docker is installed but not running!"
        echo
        echo "Please start Docker:"
        echo "  macOS/Windows: Open Docker Desktop"
        echo "  Linux: sudo systemctl start docker"
        exit 1
    fi
    
    print_success "Docker is installed and running"
}

# Function to check Node.js
check_node() {
    print_info "Checking Node.js installation..."
    
    if ! command_exists node; then
        print_error "Node.js is not installed!"
        echo
        echo "Please install Node.js (v18 or higher):"
        echo "  Visit: https://nodejs.org/"
        echo "  Or use nvm: https://github.com/nvm-sh/nvm"
        exit 1
    fi
    
    NODE_VERSION=$(node --version | cut -d'v' -f2 | cut -d'.' -f1)
    if [ "$NODE_VERSION" -lt 18 ]; then
        print_warning "Node.js version is $NODE_VERSION. Recommended: 18 or higher"
    else
        print_success "Node.js $(node --version) is installed"
    fi
}

# Function to check Python
check_python() {
    print_info "Checking Python installation..."
    
    if command_exists python3; then
        PYTHON_CMD="python3"
    elif command_exists python; then
        PYTHON_CMD="python"
    else
        print_error "Python is not installed!"
        echo
        echo "Please install Python 3.8 or higher:"
        echo "  Visit: https://www.python.org/downloads/"
        exit 1
    fi
    
    PYTHON_VERSION=$($PYTHON_CMD --version 2>&1 | cut -d' ' -f2 | cut -d'.' -f1,2)
    print_success "Python $PYTHON_VERSION is installed"
}

# Function to check Ruby (for Rails)
check_ruby() {
    print_info "Checking Ruby installation..."
    
    if ! command_exists ruby; then
        print_warning "Ruby is not installed!"
        echo
        echo "Ruby is needed for the Rails app. Install options:"
        echo "  macOS: brew install ruby"
        echo "  Linux: sudo apt-get install ruby-full (Ubuntu/Debian)"
        echo "  Or use rbenv: https://github.com/rbenv/rbenv"
        echo
        echo "You can still use Express and FastAPI apps without Ruby."
        return
    fi
    
    if ! command_exists bundle; then
        print_warning "Bundler is not installed!"
        echo "Installing bundler..."
        gem install bundler
    fi
    
    print_success "Ruby $(ruby --version | cut -d' ' -f2) is installed"
}

# Function to setup environment files
setup_environment() {
    print_info "Setting up environment configuration..."
    
    # Function to create .env file from .env.example if it doesn't exist
    setup_env_file() {
        local example_file="$1"
        local env_file="${example_file%.example}"
        
        if [[ -f "$example_file" ]]; then
            if [[ ! -f "$env_file" ]]; then
                print_info "Creating $env_file from $example_file"
                cp "$example_file" "$env_file"
                print_success "Created $env_file"
            else
                print_info "$env_file already exists, skipping..."
            fi
        else
            print_warning "$example_file not found"
        fi
    }
    
    # Set up environment files for all apps
    setup_env_file "react-express-app/backend/.env.example"
    setup_env_file "react-python-app/backend/.env.example"
    
    print_success "Environment configuration complete!"
    echo "   • Express backend: Port 3001, PostgreSQL connection"
    echo "   • Python backend: Port 5001, PostgreSQL connection"  
    echo "   • Database credentials: wit_user/dev_password (matches Docker)"
    echo
}

# Function to setup PostgreSQL
setup_database() {
    print_info "Setting up PostgreSQL database..."
    
    # Stop any existing container
    if docker ps -q -f name=wit_postgres >/dev/null; then
        print_info "Stopping existing PostgreSQL container..."
        docker stop wit_postgres >/dev/null 2>&1 || true
    fi
    
    # Remove any existing container
    if docker ps -aq -f name=wit_postgres >/dev/null; then
        print_info "Removing existing PostgreSQL container..."
        docker rm wit_postgres >/dev/null 2>&1 || true
    fi
    
    # Start PostgreSQL
    print_info "Starting PostgreSQL container..."
    docker-compose up -d postgres
    
    # Wait for PostgreSQL to be ready
    print_info "Waiting for PostgreSQL to be ready..."
    timeout=60
    while [ $timeout -gt 0 ]; do
        if docker exec wit_postgres pg_isready -U wit_user -d postgres >/dev/null 2>&1; then
            break
        fi
        sleep 2
        timeout=$((timeout - 2))
    done
    
    if [ $timeout -le 0 ]; then
        print_error "PostgreSQL failed to start within 60 seconds"
        exit 1
    fi
    
    print_success "PostgreSQL is running and ready"
}

# Function to install dependencies
install_dependencies() {
    print_info "Installing dependencies for all apps..."
    
    # Express app
    if [ -d "react-express-app/backend" ]; then
        print_info "Installing Express backend dependencies..."
        cd react-express-app/backend && npm install && cd ../..
    fi
    
    if [ -d "react-express-app/frontend" ]; then
        print_info "Installing Express frontend dependencies..."
        cd react-express-app/frontend && npm install && cd ../..
    fi
    
    # FastAPI app
    if [ -d "react-python-app/frontend" ]; then
        print_info "Installing FastAPI frontend dependencies..."
        cd react-python-app/frontend && npm install && cd ../..
    fi
    
    # Rails app
    if [ -d "react-rails-app/frontend" ]; then
        print_info "Installing Rails frontend dependencies..."
        cd react-rails-app/frontend && npm install && cd ../..
    fi
    
    if [ -d "react-rails-app/backend" ] && command_exists bundle; then
        print_info "Installing Rails backend dependencies..."
        cd react-rails-app/backend && bundle install && cd ../..
    fi
    
    print_success "All dependencies installed"
}

# Function to make scripts executable
setup_scripts() {
    print_info "Making scripts executable..."
    
    chmod +x setup.sh 2>/dev/null || true
    chmod +x dev-start.sh 2>/dev/null || true
    chmod +x react-express-app/start.sh 2>/dev/null || true
    chmod +x react-python-app/start.sh 2>/dev/null || true
    chmod +x react-rails-app/start.sh 2>/dev/null || true
    
    print_success "Scripts are executable"
}

# Function to run database migrations
setup_databases() {
    print_info "Setting up databases and running migrations..."
    
    # Express app - Prisma
    if [ -d "react-express-app/backend" ]; then
        print_info "Setting up Express database (Prisma)..."
        cd react-express-app/backend
        npx prisma generate >/dev/null 2>&1 || true
        npx prisma db push >/dev/null 2>&1 || true
        cd ../..
    fi
    
    # Rails app - Active Record
    if [ -d "react-rails-app/backend" ] && command_exists bundle; then
        print_info "Setting up Rails database (Active Record)..."
        cd react-rails-app/backend
        bundle exec rails db:create >/dev/null 2>&1 || true
        bundle exec rails db:migrate >/dev/null 2>&1 || true
        bundle exec rails db:seed >/dev/null 2>&1 || true
        cd ../..
    fi
    
    print_success "Databases are set up and ready"
}

# Function to show final instructions
show_instructions() {
    echo
    echo -e "${GREEN}============================================${NC}"
    echo -e "${GREEN}🎉 Setup Complete!${NC}"
    echo -e "${GREEN}============================================${NC}"
    echo
    echo -e "${BLUE}Quick Start Commands:${NC}"
    echo -e "  ${YELLOW}npm run react-express${NC}    # Express + React + TypeScript"
    echo -e "  ${YELLOW}npm run react-python${NC}     # FastAPI + React + Python"
    echo -e "  ${YELLOW}npm run react-rails${NC}      # Rails + React + Ruby"
    echo
    echo -e "${BLUE}Database Commands:${NC}"
    echo -e "  ${YELLOW}npm run db:start${NC}         # Start PostgreSQL"
    echo -e "  ${YELLOW}npm run db:stop${NC}          # Stop PostgreSQL"
    echo -e "  ${YELLOW}npm run db:reset${NC}         # Reset all databases"
    echo
    echo -e "${BLUE}App URLs (when running):${NC}"
    echo -e "  Express:  http://localhost:5173 (frontend) | http://localhost:5000 (backend)"
    echo -e "  FastAPI:  http://localhost:5174 (frontend) | http://localhost:5001 (backend)"
    echo -e "  Rails:    http://localhost:5175 (frontend) | http://localhost:3000 (backend)"
    echo
    echo -e "${GREEN}Happy coding! 🚀${NC}"
    echo
}

# Main execution
main() {
    print_header
    
    check_docker
    check_node
    check_python
    check_ruby
    
    setup_environment
    setup_database
    setup_scripts
    install_dependencies
    setup_databases
    
    show_instructions
}

# Run main function
main "$@"
