# Chatwoot Customizations

This project implements two key customizations for Chatwoot:
1. **AI Assistant Rebranding**: Replaces "Captain" with "AI Assistant" and "Assistant" with "Topic"
2. **Conversation Analytics Enhancement**: Adds detailed metrics to conversation view

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Getting Started](#getting-started)
- [Implementation Details](#implementation-details)
- [Deployment Options](#deployment-options)
- [Troubleshooting](#troubleshooting)
- [Advanced Customization](#advanced-customization)
- [Project Structure](#project-structure)

## Overview

This project customizes Chatwoot's UI without modifying the core application code, making it compatible with both self-hosted and cloud versions of Chatwoot. The customizations are implemented through JavaScript and CSS injected into the Chatwoot frontend.

### Customization #1: AI Assistant Rebranding

The first customization replaces instances of "Captain" with "AI Assistant" styled in blue, and "Assistant" with "Topic" styled in green. This is achieved through CSS selectors that target Chatwoot's DOM structure.

### Customization #2: Conversation Analytics

The second customization adds a detailed analytics panel to conversation views with metrics including:
- Message counts
- Response times
- Sentiment analysis
- Language detection
- Topic detection
- Complexity scoring
- Conversation summary

## Features

- **Non-intrusive**: All customizations are applied via JavaScript without modifying Chatwoot's core code
- **Visible Branding**: Clear visual distinction with color-coded labels
- **Enhanced Analytics**: Comprehensive conversation metrics panel
- **Multiple Deployment Options**: From simple script inclusion to full Docker deployment
- **Easy to Customize**: Well-documented code for easy modification
- **Interactive Demo**: Included demo page to preview customizations

## Getting Started

### Quick Demo

1. Clone this repository
2. Start the demo server:
   ```bash
   docker-compose -f demo-docker-compose.yml up -d
   ```
3. Open [http://localhost:3000](http://localhost:3000) in your browser
4. Explore the demo page and installation guide

### Applying to Your Chatwoot Installation

#### Method 1: Direct JavaScript Injection

1. Copy `deploy-customizations.js` to your Chatwoot server's public directory
2. Add this script tag to your Chatwoot's index.html just before the closing body tag:
   ```html
   <script src="/deploy-customizations.js"></script>
   ```

#### Method 2: Browser Extension

1. Install the [Tampermonkey](https://www.tampermonkey.net/) browser extension
2. Create a new script and paste the contents of `deploy-customizations.js`
3. Configure it to run on your Chatwoot domain

#### Method 3: Full Docker Deployment

```bash
# Clone the repository
git clone https://github.com/yourusername/chatwoot-customizations.git
cd chatwoot-customizations

# Start the Chatwoot stack
docker-compose -f docker-compose.deploy.yml up -d

# Wait for all services to start
docker-compose -f docker-compose.deploy.yml ps

# Apply customizations
# For Linux/Mac
./inject-customizations.sh
# For Windows
./inject-customizations.ps1
```

## Implementation Details

### AI Assistant Rebranding

The rebranding is implemented using CSS selectors that target specific elements in Chatwoot's UI:

```css
/* Rebrand Captain to AI Assistant */
.captain-container::before,
.captain-assistant-container::before,
.captain-label::before,
.captain-topic-container::before,
[data-testid="captain-assistant"]::before,
[data-testid="captain-topic"]::before {
  content: "AI Assistant";
  color: #3B82F6;
  font-weight: 600;
}

/* Rebrand Assistant to Topic */
.assistant-container::before,
.assistant-label::before,
[data-testid="assistant-label"]::before {
  content: "Topic";
  color: #10B981;
  font-weight: 600;
}
```

The original text is hidden, and new text is inserted using the `::before` pseudo-element.

### Conversation Analytics

The analytics panel is dynamically injected into conversation views using JavaScript:

1. The script looks for elements with the `.conversation-view` class
2. It creates a new panel with analytics metrics
3. The panel is inserted at the top of the conversation view
4. Analytics update automatically as the conversation progresses

## Deployment Options

### Option 1: Simple Demo (Nginx)

```bash
docker-compose -f demo-docker-compose.yml up -d
```

This starts an Nginx container that serves the demo pages on port 3000.

### Option 2: Full Chatwoot Deployment

```bash
docker-compose -f docker-compose.deploy.yml up -d
```

This deploys:
- PostgreSQL with pgvector extension
- Redis
- Chatwoot web application
- Chatwoot Sidekiq worker

### Option 3: Manual Installation

For existing Chatwoot installations, simply copy the `deploy-customizations.js` file and include it in your Chatwoot's HTML.

## Troubleshooting

### Common Issues

#### 1. Customizations not appearing
- Check browser console for errors
- Verify the script is properly loaded
- Confirm CSS selectors match your Chatwoot version

#### 2. Docker deployment issues
- Make sure required ports (3000, 5432, 6379) are available
- Check container logs: `docker-compose -f docker-compose.deploy.yml logs chatwoot`
- Ensure PostgreSQL and Redis are healthy

#### 3. Analytics panel not showing
- Verify conversation view DOM structure matches selectors
- Check for JavaScript errors in console

## Advanced Customization

### Modifying Labels

To change the labels, modify the `content` property in the CSS:

```css
.captain-container::before {
  content: "Your Custom Label";
  color: #YourColor;
}
```

### Customizing Analytics

To modify the analytics panel:

1. Edit the HTML in the `analyticsPanel.innerHTML` section
2. Customize the metrics, layout, and styling
3. Add or remove sections as needed

### Integrating with Real Data

For production use, modify the script to fetch real data:

```javascript
// Example: fetch real data from Chatwoot API
async function fetchConversationAnalytics(conversationId) {
  const response = await fetch(`/api/v1/conversations/${conversationId}/analytics`);
  return await response.json();
}
```

## Project Structure

```
chatwoot-customizations/
│
├── deploy-customizations.js   # Main JavaScript file with customizations
├── demo.html                  # Interactive demo of customizations
├── installation-guide.html    # Guide for applying customizations
├── index.html                 # Project landing page
│
├── docker-compose.deploy.yml  # Full Chatwoot deployment configuration
├── demo-docker-compose.yml    # Simple demo deployment configuration
│
├── inject-customizations.sh   # Linux/Mac script to inject customizations
├── inject-customizations.ps1  # Windows script to inject customizations
│
└── README-CUSTOMIZATIONS.md   # This documentation file
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgements

- [Chatwoot](https://www.chatwoot.com/) - The open-source customer support platform
- [TailwindCSS](https://tailwindcss.com/) - Used for styling the demo pages

---

Created with ❤️ for enhancing the Chatwoot experience. 