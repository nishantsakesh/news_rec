#!/bin/bash

echo "🚀 NewsRec Quick Start Script"
echo "============================="

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to print colored output
print_success() {
    echo -e "\033[32m✅ $1\033[0m"
}

print_error() {
    echo -e "\033[31m❌ $1\033[0m"
}

print_info() {
    echo -e "\033[34mℹ️  $1\033[0m"
}

print_warning() {
    echo -e "\033[33m⚠️  $1\033[0m"
}

# Check prerequisites
print_info "Checking prerequisites..."

if ! command_exists python3; then
    print_error "Python 3 is not installed. Please install Python 3.11+"
    exit 1
fi

if ! command_exists node; then
    print_error "Node.js is not installed. Please install Node.js 18+"
    exit 1
fi

if ! command_exists psql; then
    print_error "PostgreSQL is not installed. Please install PostgreSQL"
    exit 1
fi

if ! command_exists pip; then
    print_error "pip is not installed. Please install pip"
    exit 1
fi

print_success "All prerequisites are installed!"

# Check Python version
PYTHON_VERSION=$(python3 -c 'import sys; print(".".join(map(str, sys.version_info[:2])))')
print_info "Python version: $PYTHON_VERSION"

if [[ $(echo "$PYTHON_VERSION < 3.11" | bc -l) -eq 1 ]]; then
    print_warning "Python version is less than 3.11. Some features may not work correctly."
fi

# Create database
print_info "Setting up database..."
read -p "Enter PostgreSQL password: " -s PGPASSWORD
export PGPASSWORD

if psql -U postgres -d newsrec_db -c "SELECT 1;" >/dev/null 2>&1; then
    print_success "Database already exists"
else
    if psql -U postgres -c "CREATE DATABASE newsrec_db;" >/dev/null 2>&1; then
        print_success "Database created successfully"
    else
        print_error "Failed to create database. Please check PostgreSQL is running and you have the correct password."
        exit 1
    fi
fi

# Backend setup
print_info "Setting up backend..."
cd backend

# Create virtual environment if it doesn't exist
if [ ! -d "venv" ]; then
    print_info "Creating virtual environment..."
    python3 -m venv venv
    print_success "Virtual environment created"
else
    print_success "Virtual environment already exists"
fi

# Activate virtual environment
print_info "Activating virtual environment..."
source venv/bin/activate

# Install dependencies
print_info "Installing Python dependencies..."
if pip install -r requirements.txt >/dev/null 2>&1; then
    print_success "Python dependencies installed"
else
    print_error "Failed to install Python dependencies"
    exit 1
fi

# Create .env file if it doesn't exist
if [ ! -f ".env" ]; then
    print_info "Creating .env file..."
    cat > .env << EOF
# Database Configuration
DATABASE_URL=postgresql://postgres:$PGPASSWORD@localhost:5432/newsrec_db

# JWT Configuration (Change this to a secure random string)
JWT_SECRET_KEY=dev-secret-key-change-in-production

# News API Configuration (Get from https://newsapi.org/)
NEWS_API_KEY=your-news-api-key-here

# Flask Configuration
FLASK_ENV=development
FLASK_DEBUG=True
EOF
    print_success ".env file created"
    print_warning "Please edit .env file and add your NewsAPI.org API key"
else
    print_success ".env file already exists"
fi

# Initialize database
print_info "Initializing database..."
if flask db upgrade >/dev/null 2>&1; then
    print_success "Database initialized"
else
    print_info "Running database migrations..."
    if flask db init >/dev/null 2>&1 && flask db migrate -m "Initial migration" >/dev/null 2>&1 && flask db upgrade >/dev/null 2>&1; then
        print_success "Database migrations completed"
    else
        print_error "Failed to initialize database"
        exit 1
    fi
fi

# Return to project root
cd ..

# Frontend setup
print_info "Setting up frontend..."
cd frontend

# Install dependencies
print_info "Installing Node.js dependencies..."
if npm install >/dev/null 2>&1; then
    print_success "Node.js dependencies installed"
else
    print_error "Failed to install Node.js dependencies"
    exit 1
fi

# Return to project root
cd ..

# Summary
print_success "Setup completed successfully!"
echo ""
print_info "Next steps:"
echo "1. Edit backend/.env and add your NewsAPI.org API key"
echo "2. Run the application using one of these methods:"
echo ""
echo "   Method 1 - Separate terminals:"
echo "     Terminal 1: cd backend && source venv/bin/activate && python run.py"
echo "     Terminal 2: cd frontend && npm run dev"
echo ""
echo "   Method 2 - Single terminal (using concurrently):"
echo "     npm install -g concurrently"
echo "     npm run dev"
echo ""
echo "   Method 3 - Using Docker:"
echo "     docker-compose up"
echo ""
echo "Frontend will be available at: http://localhost:3000"
echo "Backend API will be available at: http://localhost:5000"
echo ""
print_warning "Don't forget to get your free API key from https://newsapi.org/"