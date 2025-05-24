#!/bin/bash

# This script injects the customization script into the Chatwoot application's public directory
# and modifies the index.html to load it.

# Copy the customization script to the public directory
echo "Copying customization script to public directory..."
docker cp deploy-customizations.js chatwoot-chatwoot-1:/app/public/

# Modify the index.html to load our script at the end of the body
echo "Injecting script tag into index.html..."
docker exec chatwoot-chatwoot-1 bash -c '
if ! grep -q "deploy-customizations.js" /app/public/index.html; then
  sed -i "s|</body>|  <script src=\"/deploy-customizations.js\"></script>\n</body>|" /app/public/index.html
  echo "Script injected successfully!"
else
  echo "Script is already injected."
fi
'

echo "Customizations have been deployed!"
echo "You can now access Chatwoot at http://localhost:3000"
echo "Login with:"
echo "  Email: admin@example.com"
echo "  Password: Password1!" 