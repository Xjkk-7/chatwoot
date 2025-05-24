/**
 * Support Hub - Customizations for Chatwoot
 * This script replaces branding and adds the conversation insights panel
 */

(function() {
  console.log('Support Hub customizations loaded');
  
  // CSS styles for our customizations
  const customStyles = `
    .support-hub-logo {
      display: flex;
      align-items: center;
      justify-content: center;
      width: 32px;
      height: 32px;
      background-color: #1f93ff;
      border-radius: 4px;
    }
    
    .support-hub-logo-inner {
      width: 16px;
      height: 16px;
      background-color: white;
      border-radius: 2px;
    }
    
    .conversation-insights-panel {
      width: 320px;
      background-color: white;
      border-left: 1px solid #e6eaef;
      overflow-y: auto;
      height: 100%;
      padding: 16px;
    }
    
    .insights-section {
      margin-bottom: 24px;
    }
    
    .insights-section h3 {
      font-size: 14px;
      font-weight: 600;
      color: #536171;
      margin-bottom: 12px;
    }
    
    .insight-item {
      display: flex;
      align-items: center;
      margin-bottom: 8px;
    }
    
    .insight-badge {
      display: inline-block;
      padding: 4px 8px;
      border-radius: 12px;
      font-size: 12px;
      margin-right: 8px;
    }
    
    .sentiment-positive {
      background-color: #e3f9e5;
      color: #138a36;
    }
    
    .sentiment-negative {
      background-color: #ffecec;
      color: #d9304f;
    }
    
    .sentiment-neutral {
      background-color: #f0f2f5;
      color: #536171;
    }
    
    .topic-badge {
      background-color: #e6f0ff;
      color: #1f76cc;
    }
  `;
  
  // Add custom styles to the page
  const styleElement = document.createElement('style');
  styleElement.textContent = customStyles;
  document.head.appendChild(styleElement);
  
  // Text replacements
  const textReplacements = {
    'Chatwoot': 'Support Hub',
    'Captain': 'AI Assistant',
    'Assistant': 'Topic'
  };
  
  // Function to replace text in a node
  function replaceText(node) {
    if (node.nodeType === Node.TEXT_NODE) {
      let content = node.nodeValue;
      let changed = false;
      
      for (const [original, replacement] of Object.entries(textReplacements)) {
        if (content.includes(original)) {
          content = content.replace(new RegExp(original, 'g'), replacement);
          changed = true;
        }
      }
      
      if (changed) {
        node.nodeValue = content;
      }
    } else if (node.nodeType === Node.ELEMENT_NODE) {
      // Skip form elements
      if (node.tagName === 'INPUT' || node.tagName === 'TEXTAREA') {
        return;
      }
      
      // Process child nodes
      Array.from(node.childNodes).forEach(replaceText);
    }
  }
  
  // Replace logo with Support Hub logo
  function replaceLogo() {
    const logoElements = document.querySelectorAll('.logo');
    
    logoElements.forEach(logo => {
      // Clear existing content
      logo.innerHTML = '';
      
      // Create Support Hub logo
      const logoContainer = document.createElement('div');
      logoContainer.className = 'support-hub-logo';
      
      const logoInner = document.createElement('div');
      logoInner.className = 'support-hub-logo-inner';
      
      logoContainer.appendChild(logoInner);
      logo.appendChild(logoContainer);
    });
  }
  
  // Add conversation insights panel
  function addInsightsPanel() {
    // Only add panel on conversation pages
    if (!window.location.pathname.includes('/app/accounts') || 
        !window.location.pathname.includes('/conversations/')) {
      return;
    }
    
    const conversationArea = document.querySelector('.conversation-view');
    if (!conversationArea) return;
    
    // Create insights panel
    const insightsPanel = document.createElement('div');
    insightsPanel.className = 'conversation-insights-panel';
    
    insightsPanel.innerHTML = `
      <div class="insights-section">
        <h3>Conversation Insights</h3>
      </div>
      
      <div class="insights-section">
        <h3>Sentiment Analysis</h3>
        <div>Dominant: <span class="insight-badge sentiment-positive">Positive</span></div>
        <div style="margin-top: 8px; margin-bottom: 4px;">
          <div style="background-color: #e5e7eb; height: 8px; width: 100%; border-radius: 4px; overflow: hidden;">
            <div style="background-color: #10B981; height: 8px; width: 80%;"></div>
          </div>
        </div>
        <div style="display: flex; justify-content: space-between; font-size: 12px; color: #6b7280;">
          <div>Positive: 80%</div>
          <div>Negative: 10%</div>
          <div>Neutral: 10%</div>
        </div>
      </div>
      
      <div class="insights-section">
        <h3>Topic Classification</h3>
        <div>Primary Topic: <span class="insight-badge topic-badge">Billing</span></div>
        <div style="margin-top: 12px;">
          <span class="insight-badge topic-badge">Billing</span>
          <span class="insight-badge topic-badge">Technical Support</span>
          <span class="insight-badge topic-badge">Product Information</span>
        </div>
      </div>
      
      <div class="insights-section">
        <h3>Response Time Metrics</h3>
        <div style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 8px; margin-top: 8px;">
          <div style="background-color: #f9fafb; padding: 8px; border-radius: 4px;">
            <div style="font-size: 12px; color: #6b7280;">First Response</div>
            <div style="font-weight: 600;">2m 30s</div>
          </div>
          <div style="background-color: #f9fafb; padding: 8px; border-radius: 4px;">
            <div style="font-size: 12px; color: #6b7280;">Avg Response</div>
            <div style="font-weight: 600;">3m 15s</div>
          </div>
          <div style="background-color: #f9fafb; padding: 8px; border-radius: 4px;">
            <div style="font-size: 12px; color: #6b7280;">Resolution Time</div>
            <div style="font-weight: 600;">15m 45s</div>
          </div>
        </div>
      </div>
      
      <div class="insights-section">
        <h3>AI Response Suggestions</h3>
        <div style="margin-top: 8px;">
          <div style="margin-bottom: 4px; font-size: 12px; color: #6b7280;">Confidence: 92%</div>
          <div class="suggested-response">
            Thank you for reaching out about your billing concern. I can help with that.
          </div>
        </div>
        <div style="margin-top: 12px;">
          <div style="margin-bottom: 4px; font-size: 12px; color: #6b7280;">Confidence: 87%</div>
          <div class="suggested-response">
            I understand you have a question about your recent invoice. Let me assist you.
          </div>
        </div>
        <div style="margin-top: 12px;">
          <div style="margin-bottom: 4px; font-size: 12px; color: #6b7280;">Confidence: 78%</div>
          <div class="suggested-response">
            I'll look into your billing issue right away.
          </div>
        </div>
      </div>
      
      <div class="insights-section">
        <h3>Relevant Knowledge</h3>
        <div style="background-color: #f9fafb; padding: 12px; border-radius: 4px; font-size: 14px;">
          <div style="margin-bottom: 8px;"><strong>Billing Policy</strong></div>
          <p style="margin: 0;">Customers can request refunds within 30 days of purchase. Subscription billing occurs on the same day each month.</p>
        </div>
      </div>
    `;
    
    // Add panel to conversation area
    conversationArea.appendChild(insightsPanel);

    // Make suggested responses clickable
    const suggestions = insightsPanel.querySelectorAll('.suggested-response');
    const replyBox = document.querySelector('.ProseMirror[role="textbox"], [contenteditable="true"]');
    
    if (replyBox) {
      suggestions.forEach(suggestion => {
        suggestion.addEventListener('click', function() {
          if (replyBox.classList.contains('ProseMirror')) {
            // For ProseMirror editor
            const text = this.textContent.trim();
            if (replyBox.editor && replyBox.editor.view) {
              const transaction = replyBox.editor.view.state.tr.insertText(text);
              replyBox.editor.view.dispatch(transaction);
            } else {
              // Fallback if editor API not available
              replyBox.textContent = text;
            }
          } else {
            // For regular contenteditable
            replyBox.textContent = this.textContent.trim();
          }
          replyBox.focus();
        });
      });
    }
  }
  
  // Set up MutationObserver to handle dynamic content
  const observer = new MutationObserver(mutations => {
    mutations.forEach(mutation => {
      if (mutation.type === 'childList') {
        mutation.addedNodes.forEach(node => {
          replaceText(node);
        });
      }
    });
    
    // Check if logo needs replacement
    replaceLogo();
    
    // Check if insights panel should be added
    addInsightsPanel();
  });
  
  // Start observing the document body
  observer.observe(document.body, {
    childList: true,
    subtree: true
  });
  
  // Initial processing
  document.body && replaceText(document.body);
  replaceLogo();
  addInsightsPanel();
  
  // Process title
  if (document.title.includes('Chatwoot')) {
    document.title = document.title.replace('Chatwoot', 'Support Hub');
  }
})(); 