# Conversation Analytics Enhancement Documentation

## Overview

This document outlines the implementation of enhanced conversation analytics features in Chatwoot. The goal was to add meaningful data to conversation `contentAttributes` and display this information in a user-friendly UI component.

## Features Implemented

The enhancement adds the following analytics capabilities to conversations:

1. **Message Statistics**
   - Total message count
   - User/agent message distribution

2. **Response Time Analytics**
   - Average response time
   - Minimum and maximum response times
   - Total response time

3. **Sentiment Analysis**
   - Conversation sentiment detection (very positive to very negative)
   - Based on keyword analysis

4. **Topic Detection**
   - Automatic categorization of conversations
   - Identification of main conversation topics

5. **Language Detection**
   - Automatic detection of conversation language

6. **Complexity Scoring**
   - Conversation complexity assessment
   - Based on message length, vocabulary, and conversation flow

7. **Engagement Metrics**
   - Conversation duration
   - Time between messages
   - User engagement scoring

8. **Conversation Summary**
   - Automatic generation of brief conversation summaries

9. **Key Phrase Extraction**
   - Identification of important terms and phrases

10. **Resolution Status Detection**
    - Automatic assessment of whether a conversation was resolved

## Technical Implementation

### Backend Service

The core functionality is implemented in the `Conversations::ContentAttributesService` class:

```ruby
class Conversations::ContentAttributesService
  pattr_initialize [:conversation!]

  def analyze_and_update
    return unless conversation.messages.present?

    attributes = generate_content_attributes
    conversation.update_content_attributes(attributes)
  end

  private

  def generate_content_attributes
    {
      message_count: calculate_message_count,
      response_times: calculate_response_times,
      sentiment: analyze_sentiment,
      topics: extract_topics,
      language: detect_language,
      complexity: calculate_complexity,
      engagement_metrics: calculate_engagement_metrics,
      conversation_summary: generate_conversation_summary,
      key_phrases: extract_key_phrases,
      resolution_status: determine_resolution_status
    }
  end
  
  # Additional methods for each analytics feature...
end
```

### API Endpoint

Added a new endpoint to the conversations controller to trigger content attribute analysis:

```ruby
# app/controllers/api/v1/accounts/conversations_controller.rb

def content_attributes
  Conversations::ContentAttributesService.new(conversation: @conversation).analyze_and_update
  head :ok
end
```

### Frontend Component

Created a Vue component to display the analytics data:

```vue
<script setup>
// ContentAttributesPanel.vue
// Component logic for displaying conversation analytics
</script>

<template>
  <div class="content-attributes-panel">
    <!-- UI for displaying analytics data -->
  </div>
</template>
```

### Integration with Conversation Sidebar

Added the component to the conversation sidebar by updating the UI settings:

```javascript
// Default sidebar items configuration
export const DEFAULT_CONVERSATION_SIDEBAR_ITEMS_ORDER = Object.freeze([
  { name: 'conversation_actions' },
  { name: 'macros' },
  { name: 'conversation_info' },
  { name: 'content_attributes' }, // Added content attributes panel
  { name: 'contact_attributes' },
  { name: 'contact_notes' },
  { name: 'previous_conversation' },
  { name: 'conversation_participants' },
  { name: 'shopify_orders' },
]);
```

## Implementation Approach

### 1. Lightweight NLP

Rather than relying on external NLP services, we implemented lightweight text analysis algorithms:

- **Sentiment Analysis**: Keyword-based approach using positive/negative word lists
- **Topic Detection**: Topic keyword matching against predefined categories
- **Language Detection**: Character set and pattern recognition
- **Complexity Scoring**: Combination of message length, vocabulary diversity, and conversation turns

### 2. Performance Considerations

- Analysis is performed on-demand rather than automatically
- Results are cached in the conversation's content_attributes
- UI component only loads data when expanded

### 3. Internationalization

Added translation keys for all analytics-related text in the UI:

```json
"CONTENT_ATTRIBUTES": {
  "TITLE": "Conversation Analysis",
  "LOADING": "Loading conversation analysis...",
  "REFRESH": "Refresh Analysis",
  // Additional translation keys...
}
```

## Future Enhancements

1. **Integration with External NLP Services**
   - Connect to more sophisticated NLP APIs for improved accuracy

2. **Real-time Analytics**
   - Update analytics as new messages are added to the conversation

3. **Conversation Trends**
   - Aggregate analytics across multiple conversations to identify patterns

4. **Customizable Analytics**
   - Allow administrators to configure which analytics are displayed

5. **Export Capabilities**
   - Enable exporting of analytics data for reporting purposes

## Conclusion

This enhancement provides valuable insights into conversations without requiring external services. The implementation is lightweight, performant, and integrated seamlessly into the existing Chatwoot UI. 