# Assistant to Topic Rebranding

This PR implements rebranding of "Assistant" to "Topic" in specific contexts throughout the platform, complementing the Captain to AI Assistant rebranding.

## Overview

This change focuses specifically on rebranding instances where "Assistant" appears in the context of AI assistants/topics, changing them to "Topic" for better clarity and user understanding.

## Implementation Approach

- **Targeted CSS Selectors**: Specific selectors for assistant-related UI elements
- **Context-Aware Changes**: Only changes "Assistant" in appropriate contexts
- **Localization Updates**: Modified relevant translation keys
- **CSS Overlay Method**: Uses the same non-invasive approach as the Captain rebranding

## Changes Made

- Extended the custom CSS overlay to handle "Assistant" → "Topic" replacements
- Added targeted CSS selectors for assistant UI components:
  - `.assistant-selector`
  - `.assistant-dropdown`
  - `.assistant-label`
  - `.assistant-name`
- Updated localization entries for assistant-related features

## Files Modified

- `app/javascript/dashboard/assets/scss/custom/ai-assistant-rebranding.scss`
- Relevant localization files in `app/javascript/dashboard/i18n/locale/en/`

## CSS Implementation

```scss
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

## Testing

- Verified "Assistant" appears as "Topic" in appropriate contexts
- Confirmed other uses of "Assistant" remain unchanged
- Tested UI consistency across different views
- Validated that the changes don't interfere with other assistant-related functionality

## Impact

- Improved terminology clarity for users
- Consistent with the overall rebranding strategy
- No breaking changes to existing functionality
- Maintains compatibility with enterprise features 