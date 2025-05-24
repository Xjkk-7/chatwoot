/**
 * Support Hub Loader
 * 
 * This script injects the Support Hub customizations into the Chatwoot interface.
 * It's automatically loaded by the custom dashboard_scripts configuration.
 */

(function() {
  console.log('Loading Support Hub customizations...');
  
  // Load CSS
  const styleElement = document.createElement('link');
  styleElement.rel = 'stylesheet';
  styleElement.href = '/support-hub-style.css';
  document.head.appendChild(styleElement);
  
  // Load main script
  const scriptElement = document.createElement('script');
  scriptElement.src = '/support-hub-inject.js';
  document.body.appendChild(scriptElement);
  
  console.log('Support Hub customizations loaded');
})(); 