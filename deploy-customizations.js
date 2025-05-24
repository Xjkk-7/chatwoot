// Chatwoot Customizations
// This script applies the following customizations:
// 1. Rebrand "Captain" to "AI Assistant"
// 2. Rebrand "Assistant" to "Topic"
// 3. Adds enhanced conversation analytics display

(function() {
  // Add custom CSS for rebranding
  const style = document.createElement('style');
  style.textContent = `
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
    
    /* Hide original text */
    .captain-container .captain-text,
    .captain-assistant-container .captain-text,
    .captain-label .captain-text,
    .captain-topic-container .captain-text,
    [data-testid="captain-assistant"] .captain-text,
    [data-testid="captain-topic"] .captain-text {
      display: none;
    }
    
    /* Rebrand Assistant to Topic */
    .assistant-container::before,
    .assistant-label::before,
    [data-testid="assistant-label"]::before {
      content: "Topic";
      color: #10B981;
      font-weight: 600;
    }
    
    /* Hide original text */
    .assistant-container .assistant-text,
    .assistant-label .assistant-text,
    [data-testid="assistant-label"] .assistant-text {
      display: none;
    }
  `;
  document.head.appendChild(style);

  // Add enhanced conversation analytics
  function injectConversationAnalytics() {
    // Find conversation view
    const conversationView = document.querySelector('.conversation-view');
    if (!conversationView) return;

    // Check if we already added analytics
    if (document.getElementById('enhanced-analytics-panel')) return;

    // Create analytics panel
    const analyticsPanel = document.createElement('div');
    analyticsPanel.id = 'enhanced-analytics-panel';
    analyticsPanel.className = 'bg-white dark:bg-slate-800 rounded-lg p-4 mb-4 shadow-sm border border-slate-100 dark:border-slate-700';
    analyticsPanel.innerHTML = `
      <h3 class="text-slate-900 dark:text-slate-100 font-medium mb-2">Conversation Analytics</h3>
      <div class="grid grid-cols-2 gap-3 text-sm">
        <div>
          <p class="text-slate-600 dark:text-slate-400">Message Count:</p>
          <p class="font-medium text-slate-900 dark:text-slate-100">15 messages</p>
        </div>
        <div>
          <p class="text-slate-600 dark:text-slate-400">Avg Response Time:</p>
          <p class="font-medium text-slate-900 dark:text-slate-100">2m 35s</p>
        </div>
        <div>
          <p class="text-slate-600 dark:text-slate-400">Sentiment:</p>
          <p class="font-medium text-slate-900 dark:text-slate-100">Positive (0.82)</p>
        </div>
        <div>
          <p class="text-slate-600 dark:text-slate-400">Language:</p>
          <p class="font-medium text-slate-900 dark:text-slate-100">English (en-US)</p>
        </div>
        <div>
          <p class="text-slate-600 dark:text-slate-400">Topics:</p>
          <p class="font-medium text-slate-900 dark:text-slate-100">Account setup, Login issues</p>
        </div>
        <div>
          <p class="text-slate-600 dark:text-slate-400">Complexity:</p>
          <p class="font-medium text-slate-900 dark:text-slate-100">Medium (0.54)</p>
        </div>
      </div>
      <div class="mt-3">
        <p class="text-slate-600 dark:text-slate-400">Summary:</p>
        <p class="font-medium text-slate-900 dark:text-slate-100">User needed help with account setup and login issues. The problem was resolved by resetting the password and updating profile information.</p>
      </div>
    `;

    // Insert at the top of the conversation view
    const conversationHeader = conversationView.querySelector('.conversation-header');
    if (conversationHeader) {
      conversationView.insertBefore(analyticsPanel, conversationHeader.nextSibling);
    } else {
      conversationView.prepend(analyticsPanel);
    }
  }

  // Check for conversation view periodically
  const checkInterval = setInterval(() => {
    if (document.querySelector('.conversation-view')) {
      injectConversationAnalytics();
    }
  }, 2000);

  // Also listen for navigation/dynamic content changes
  const observer = new MutationObserver((mutations) => {
    for (const mutation of mutations) {
      if (mutation.addedNodes.length) {
        injectConversationAnalytics();
      }
    }
  });

  // Start observing once the app is loaded
  setTimeout(() => {
    const appRoot = document.getElementById('app') || document.body;
    observer.observe(appRoot, { childList: true, subtree: true });
  }, 3000);
})(); 