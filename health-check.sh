#!/bin/bash

# Health check script for the development environment
# Verifies Docker, PostgreSQL, and all services are running correctly

set -e

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_header() {
    echo -e "${BLUE}============================================${NC}"
    echo -e "${BLUE}🔍 Environment Health Check${NC}"
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

# Check Docker
check_docker() {
    if ! command -v docker >/dev/null 2>&1; then
        print_error "Docker not installed"
        return 1
    fi
    
    if ! docker info >/dev/null 2>&1; then
        print_error "Docker not running"
        return 1
    fi
    
    print_success "Docker is running"
    return 0
}

# Check PostgreSQL container
check_postgres() {
    if ! docker ps | grep -q wit_postgres; then
        print_warning "PostgreSQL container not running"
        print_info "Run: npm run db:start"
        return 1
    fi
    
    if ! docker exec wit_postgres pg_isready -U wit_user -d postgres >/dev/null 2>&1; then
        print_error "PostgreSQL not ready"
        return 1
    fi
    
    print_success "PostgreSQL is running and ready"
    return 0
}

# Check databases exist
check_databases() {
    local databases=("express_todos_db" "fastapi_tasks_db" "rails_projects_db")
    local missing=0
    
    for db in "${databases[@]}"; do
        if docker exec wit_postgres psql -U wit_user -d postgres -tAc "SELECT 1 FROM pg_database WHERE datname='$db'" | grep -q 1; then
            print_success "Database $db exists"
        else
            print_warning "Database $db missing"
            missing=1
        fi
    done
    
    if [ $missing -eq 1 ]; then
        print_info "Run: npm run db:reset to recreate databases"
        return 1
    fi
    
    return 0
}

# Check ports
check_ports() {
    local ports=(5432 5000 5001 3000)
    local descriptions=("PostgreSQL" "Express API" "FastAPI" "Rails API")
    
    for i in "${!ports[@]}"; do
        if lsof -Pi :${ports[$i]} -sTCP:LISTEN -t >/dev/null 2>&1; then
            print_success "Port ${ports[$i]} (${descriptions[$i]}) is in use"
        else
            print_info "Port ${ports[$i]} (${descriptions[$i]}) is available"
        fi
    done
}

# Show running services
show_services() {
    echo
    print_info "Docker containers:"
    docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}" 2>/dev/null || print_warning "No containers running"
    
    echo
    print_info "Active processes on app ports:"
    for port in 5000 5001 3000 5173 5174 5175; do
        if lsof -Pi :$port -sTCP:LISTEN -t >/dev/null 2>&1; then
            echo "  Port $port: $(lsof -Pi :$port -sTCP:LISTEN | tail -n +2 | awk '{print $1}' | head -1)"
        fi
    done
}

# Main function
main() {
    print_header
    
    local errors=0
    
    check_docker || errors=$((errors + 1))
    check_postgres || errors=$((errors + 1))
    check_databases || errors=$((errors + 1))
    check_ports
    show_services
    
    echo
    if [ $errors -eq 0 ]; then
        print_success "Environment is healthy! 🎉"
        echo
        print_info "Ready to run:"
        echo "  npm run react-express"
        echo "  npm run react-python"
        echo "  npm run react-rails"
    else
        print_error "Found $errors issue(s)"
        echo
        print_info "Quick fixes:"
        echo "  ./setup.sh          # Full setup"
        echo "  npm run db:start    # Start database"
        echo "  npm run db:reset    # Reset everything"
    fi
    echo
}

main "$@"
