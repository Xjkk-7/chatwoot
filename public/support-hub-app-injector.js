/**
 * Support Hub App Injector
 * This script ensures our customizations are loaded in the Chatwoot app
 */
(function() {
  // Function to inject our customizations
  function injectCustomizations() {
    if (document.querySelector('#support-hub-loaded')) return; // Already loaded
    
    // Mark as loaded to prevent duplicate injections
    const marker = document.createElement('div');
    marker.id = 'support-hub-loaded';
    marker.style.display = 'none';
    document.body.appendChild(marker);
    
    console.log('Injecting Support Hub customizations...');
    
    // Load CSS
    const styleElement = document.createElement('link');
    styleElement.rel = 'stylesheet';
    styleElement.href = '/support-hub-style.css';
    document.head.appendChild(styleElement);
    
    // Load main script
    const scriptElement = document.createElement('script');
    scriptElement.src = '/support-hub-inject.js';
    document.body.appendChild(scriptElement);
    
    console.log('Support Hub customizations injected');
  }
  
  // Check if we're in the app
  if (window.location.pathname.includes('/app')) {
    // Try to inject immediately
    if (document.body) {
      injectCustomizations();
    } else {
      // Or wait for the DOM to be ready
      document.addEventListener('DOMContentLoaded', injectCustomizations);
    }
    
    // Also set up a MutationObserver to inject when the app view changes
    const observer = new MutationObserver(function(mutations) {
      injectCustomizations();
    });
    
    // Start observing once the body exists
    function startObserving() {
      if (document.body) {
        observer.observe(document.body, { childList: true, subtree: true });
      } else {
        setTimeout(startObserving, 100);
      }
    }
    
    startObserving();
  }
})(); 