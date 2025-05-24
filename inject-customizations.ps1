# PowerShell version of the injection script for Windows

# Copy the customization script to the public directory
Write-Host 'Copying customization script to public directory...'
docker cp deploy-customizations.js chatwoot-chatwoot-1:/app/public/

# Modify the index.html to load our script at the end of the body
Write-Host 'Injecting script tag into index.html...'
docker exec chatwoot-chatwoot-1 sh -c 'if ! grep -q "deploy-customizations.js" /app/public/index.html; then sed -i "s|</body>|  <script src=\"/deploy-customizations.js\"></script>\n</body>|" /app/public/index.html; echo "Script injected successfully!"; else echo "Script is already injected."; fi'

Write-Host 'Customizations have been deployed!'
Write-Host 'You can now access Chatwoot at http://localhost:3000'
Write-Host 'Login with:'
Write-Host '  Email: admin@example.com'
Write-Host '  Password: Password1!' 