#!/bin/bash

set -e

# Clear homepage for local development
echo "Clearing homepage for local development..."

if command -v jq >/dev/null 2>&1; then
    echo "Using jq to clear homepage..."
    jq '.homepage = ""' package.json > package.tmp.json && mv package.tmp.json package.json
else
    echo "Using sed to clear homepage..."
    sed -i 's|"homepage"[[:space:]]*:[[:space:]]*"[^"]*"|"homepage": ""|' package.json
fi

echo "Homepage cleared successfully"

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

echo "Checking environment..."

# Check for npm
if ! command_exists npm; then
    echo "npm is not installed. Please install Node.js and npm first."
    exit 1
fi

# Check for git
if ! command_exists git; then
    echo "git is not installed. Please install git first."
    exit 1
fi

# Install dependencies
echo "Installing npm dependencies..."
npm install

# Start development server
echo "Starting development server (npm start)..."
npm start