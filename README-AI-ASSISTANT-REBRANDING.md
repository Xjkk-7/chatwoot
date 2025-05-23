# AI Assistant Rebranding Documentation

## Overview

This document outlines the approach taken to rebrand "Captain" to "AI Assistant" and "Assistant" to "Topic" throughout the Chatwoot platform without modifying enterprise-licensed files.

## Challenge

The main challenge was to implement rebranding without modifying enterprise-licensed files, which are protected by proprietary licenses and cannot be directly changed. This required a non-invasive approach that would overlay the new branding on top of the existing codebase.

## Solution Approach

### 1. Localization Files

The primary approach was to modify the localization files in `app/javascript/dashboard/i18n/locale/en/` to replace occurrences of "Captain" with "AI Assistant" and "Assistant" with "Topic". This leverages Chatwoot's built-in internationalization system to display the new terminology.

Key files modified:
- `settings.json`
- `integrations.json`

### 2. Custom CSS Overlay

To handle cases where text was hardcoded in the UI or coming from enterprise files, we created a custom CSS file:
- `app/javascript/dashboard/assets/scss/custom/ai-assistant-rebranding.scss`

This CSS uses the following techniques:
- Position relative/absolute to overlay new text on top of existing text
- CSS `::before` pseudo-elements to replace text content
- Targeted selectors to ensure we only modify the intended elements

### 3. Integration with Build System

The custom CSS was imported into the main stylesheet:
- Added import to `app/javascript/dashboard/assets/scss/_woot.scss`

## Implementation Details

### CSS Approach

```scss
// Hide original text containing "Captain" and replace with "AI Assistant"
[class*="captain"]:not(.woot-content-wrap *):not(.conversation-view *) {
  position: relative;
  
  &::before {
    content: attr(data-content, "AI Assistant");
    position: absolute;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background: inherit;
    display: flex;
    align-items: center;
    justify-content: center;
  }
}

// Replace "Assistant" with "Topic" in specific contexts
.assistant-selector,
.assistant-dropdown,
.assistant-label,
.assistant-name {
  &::before {
    content: "Topic";
  }
}
```

### Localization Approach

Modified key entries in localization files:
```json
"CAPTAIN": "AI Assistant",
"CAPTAIN_ASSISTANTS": "Topics"
```

## Challenges Encountered

1. **Encoding Issues**: Several attempts to modify JavaScript files resulted in encoding issues, leading to a CSS-only approach.

2. **Dynamic Content**: Some content is dynamically generated, requiring careful CSS selector crafting to ensure we only target the intended elements.

3. **Enterprise Files**: Ensuring we didn't modify any enterprise-licensed files while still achieving complete rebranding.

## Results

The rebranding was successfully implemented, with "Captain" now appearing as "AI Assistant" and "Assistant" as "Topic" throughout the user interface without modifying any enterprise-licensed files.

## Future Considerations

1. **Upgrades**: When upgrading Chatwoot, ensure that the custom CSS and localization changes are preserved.

2. **New Features**: Any new features added to Chatwoot that reference "Captain" or "Assistant" may require additional CSS rules or localization entries.

3. **Performance**: The CSS overlay approach has minimal performance impact, but it's worth monitoring as the application scales. 