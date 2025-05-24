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

Due to Ruby version mismatches and dependencies, running the full Chatwoot application with customizations has some challenges. The demo provides a comprehensive view of all features without requiring a complex setup.

If you want to attempt running the full application:

1. Ensure Docker is installed on your system
2. Run `docker-compose -f docker-compose.demo.yml up -d`
3. Access the application at http://localhost:3000

## Implementation Details

The customization works through client-side JavaScript injection:

- `public/support-hub-inject.js` - Main script that handles text replacements and adds the insights panel
- `public/support-hub-style.css` - Styling for the customizations
- `public/demo.html` - A static demo showcasing all features

## Troubleshooting

If you encounter issues with the Docker installation, the static demo provides the most reliable way to see the customizations. The Docker setup may require adjustments based on your specific environment.

## Credits

Created for the Support Hub rebranding project.
