# Chatwoot Customizations

This repository contains code for deploying and customizing Chatwoot with two key features:

1. **AI Assistant Rebranding**: Replacing "Captain" with "AI Assistant" and "Assistant" with "Topic"
2. **Conversation Analytics Enhancement**: Adding detailed metrics to conversation contentAttributes

## Deployment Guide

### Option 1: Deploy with Docker (Recommended)

```bash
# Clone the repository
git clone https://github.com/yourusername/chatwoot-customizations.git
cd chatwoot-customizations

# Start the Chatwoot stack
docker-compose -f docker-compose.deploy.yml up -d

# Wait for all services to start
docker-compose -f docker-compose.deploy.yml ps

# Create an admin user
docker-compose -f docker-compose.deploy.yml exec chatwoot bundle exec rails runner "Account.create!(name: 'Test Account'); User.create!(name: 'Admin', email: 'admin@example.com', password: 'Password1!', account_ids: [1], confirmed_at: Time.now.utc)"

# Make the user an administrator
docker-compose -f docker-compose.deploy.yml exec chatwoot bundle exec rails runner "user = User.find_by(email: 'admin@example.com'); account_user = AccountUser.find_by(user_id: user.id); account_user.update!(role: 0); puts 'User is now an administrator'"
```

Access the application at http://localhost:3000 and log in with:
- Email: admin@example.com
- Password: Password1!

### Option 2: Add customizations to existing Chatwoot installation

1. Copy the `deploy-customizations.js` file to your Chatwoot server
2. Inject the script into the Chatwoot frontend:
   - For self-hosted installations, add a script tag in `public/index.html`
   - For integrated installations, use browser extension like Tampermonkey to inject the script

## Demonstration

For a quick demonstration without running the full Chatwoot stack:

1. Open `demo.html` in your browser
2. The demo page will show:
   - "AI Assistant" labels (blue) instead of "Captain"
   - "Topic" labels (green) instead of "Assistant"
   - Enhanced conversation analytics panel

## Troubleshooting

### Database Issues
- Make sure PostgreSQL is running on port 5432
- Ensure the pgvector extension is enabled
- Check database connection settings

### Container Issues
- Check container logs: `docker-compose -f docker-compose.deploy.yml logs chatwoot`
- Ensure all services are healthy: `docker-compose -f docker-compose.deploy.yml ps`
- For port conflicts, modify the port mappings in docker-compose.deploy.yml

### Custom CSS Not Working
- Make sure the script is loaded after the Chatwoot application is fully loaded
- Check browser console for any errors
- Adjust the CSS selectors if the Chatwoot DOM structure has changed 