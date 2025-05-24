#!/bin/bash
# Setup script for Chatwoot database initialization

echo "Setting up Chatwoot database..."

# Wait for PostgreSQL to be ready
echo "Waiting for PostgreSQL to be ready..."
until docker-compose -f docker-compose.runnable.yml exec -T postgres pg_isready -U postgres; do
  echo "PostgreSQL is unavailable - sleeping"
  sleep 1
done

echo "PostgreSQL is up - executing database setup"

# Create database and run migrations
docker-compose -f docker-compose.runnable.yml exec -T chatwoot bundle exec rails db:prepare

# Create a default admin account
docker-compose -f docker-compose.runnable.yml exec -T chatwoot bundle exec rails db:seed

echo "Database setup complete. You can now access Chatwoot at http://localhost:3000"
echo "Use the following credentials to log in:"
echo "Email: admin@example.com"
echo "Password: Password1!" 