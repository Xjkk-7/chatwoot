@echo off
echo Starting Support Hub...

REM Start Docker containers
docker-compose -f docker-compose.runnable.yml down
docker-compose -f docker-compose.runnable.yml up -d

REM Wait for containers to start
echo Waiting for containers to start...
timeout /t 10 /nobreak

REM Setup database if needed
echo Setting up database...
docker-compose -f docker-compose.runnable.yml exec chatwoot bundle exec rails db:prepare

REM Create a default admin account if needed
echo Creating default admin account...
docker-compose -f docker-compose.runnable.yml exec chatwoot bundle exec rails db:seed

echo.
echo Support Hub is now running!
echo Access it at http://localhost:3000
echo Use the following credentials to log in:
echo Email: admin@example.com
echo Password: Password1!
echo.

REM Open browser
start "" http://localhost:3000 