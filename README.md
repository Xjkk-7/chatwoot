# Support Hub - Chatwoot Customization

This project provides a customized version of Chatwoot rebranded as "Support Hub" with enhanced conversation features.

## Customizations

1. **Branding Changes**
   - Replaced "Chatwoot" with "Support Hub"
   - Changed "Captain" to "AI Assistant" 
   - Changed "Assistant" to "Topic"
   - Added a custom blue square logo with white box

2. **Conversation Insights Panel**
   - Added a side panel with comprehensive conversation analysis
   - Includes sentiment analysis with percentage breakdown
   - Topic classification with primary topic identification
   - Response time metrics (first response, average response, resolution time)
   - AI response suggestions with confidence scores
   - Relevant knowledge base information

## Viewing the Demo

The simplest way to see the customizations is to open the static demo:

1. Navigate to the `public` directory
2. Open `start-demo.html` in your web browser
3. Click on "View Demo" to see the full interface

## Running with Docker

You can run the full Support Hub application with Docker using our compatible configuration:

1. Ensure Docker is installed on your system
2. Run the start script:
   - On Windows: `start-support-hub.bat`
   - On Linux/Mac: `bash setup-db.sh` and then `docker-compose -f docker-compose.runnable.yml up -d`
3. Access Support Hub at http://localhost:3000
4. Login with these credentials:
   - Email: admin@example.com
   - Password: Password1!

For compatibility reasons, we use Chatwoot v2.18.0 which is guaranteed to work with our customizations.

## Quick Installation on Existing Chatwoot

If you already have a running Chatwoot instance and just want to add Support Hub customizations:

1. Copy the following files to your Chatwoot's public directory:
   - `public/support-hub-inject.js`
   - `public/support-hub-style.css`
   - `public/support-hub-loader.js`
   - `public/support-hub-app-injector.js`

2. Add this line to your Chatwoot's app/views/layouts/vueapp.html.erb file:
   ```html
   <script src="/support-hub-app-injector.js"></script>
   ```

3. Alternatively, use the bookmarklet provided in `public/support-hub-customizer.html`

## Implementation Details

The customization works through client-side JavaScript injection:

- `public/support-hub-inject.js` - Main script that handles text replacements and adds the insights panel
- `public/support-hub-style.css` - Styling for the customizations
- `public/demo.html` - A static demo showcasing all features

## Troubleshooting

If you encounter issues with the Docker installation, the static demo provides the most reliable way to see the customizations. The Docker setup may require adjustments based on your specific environment.

## Credits

Created for the Support Hub rebranding project.
