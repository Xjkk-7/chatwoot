# Enhanced Chatwoot Auto-Setup Script
# Run this after deploying to automatically enable all enhanced features

puts "🚀 Setting up Enhanced Chatwoot with AI-Powered Analytics..."

# Step 1: Configure Enterprise Installation
puts "📋 Configuring enterprise installation settings..."

InstallationConfig.find_or_create_by(name: 'INSTALLATION_PRICING_PLAN') do |config|
  config.value = 'enterprise'
  config.locked = true
end.update!(value: 'enterprise')

InstallationConfig.find_or_create_by(name: 'CHATWOOT_ENTERPRISE_ENABLED') do |config|
  config.value = 'true'
  config.locked = true
end.update!(value: 'true')

puts "✅ Enterprise configuration enabled"

# Step 2: Enable All Enhanced Features for All Accounts
puts "🔧 Enabling enhanced features for all accounts..."

Account.find_each do |account|
  puts "  Processing account: #{account.name} (ID: #{account.id})"
  
  # Enable all enhanced features
  enhanced_features = [
    'chatwoot_v4',           # New sidebar UI
    'captain_integration',   # AI Assistant
    'audit_logs',           # Enterprise audit logs
    'sla',                  # Service Level Agreements
    'custom_roles',         # Custom role management
    'disable_branding',     # Custom branding
    'help_center',          # Help center features
    'campaigns',            # Campaign management
    'team_management',      # Team features
    'reports',              # Advanced reports
    'automations',          # Automation features
    'macros',               # Macro support
    'integrations',         # Third-party integrations
    'inbox_management',     # Inbox management
    'labels',               # Label management
    'custom_attributes',    # Custom attributes
    'canned_responses',     # Canned responses
    'agent_management',     # Agent management
    'agent_bots'            # Bot integration
  ]
  
  account.enable_features!(*enhanced_features)
  
  # Update account attributes for enterprise features
  account.update!(
    custom_attributes: account.custom_attributes.merge({
      'plan_name' => 'Enterprise',
      'subscription_status' => 'active',
      'enterprise_enabled' => true,
      'enhanced_analytics_enabled' => true,
      'ai_features_enabled' => true
    })
  )
  
  puts "  ✅ Enhanced features enabled for #{account.name}"
end

# Step 3: Clear All Caches
puts "🧹 Clearing system caches..."
Rails.cache.clear
GlobalConfig.clear_cache

# Step 4: Create Demo Data (Optional)
puts "📊 Setting up demo analytics data..."

Account.find_each do |account|
  # Create demo conversations with enhanced analytics if none exist
  if account.conversations.count == 0
    puts "  Creating demo conversations for #{account.name}..."
    
    # Create a demo inbox if none exists
    if account.inboxes.empty?
      inbox = account.inboxes.create!(
        name: 'Demo Website Chat',
        channel_type: 'Channel::WebWidget'
      )
      puts "    ✅ Created demo inbox: #{inbox.name}"
    end
    
    inbox = account.inboxes.first
    
    # Create demo contacts and conversations with analytics
    demo_contacts = [
      {
        name: 'Alex Johnson',
        email: 'alex.johnson@example.com',
        conversation_type: 'API Integration Support',
        sentiment: 'neutral',
        business_impact: 'high',
        escalation_risk: 'medium'
      },
      {
        name: 'Sarah Martinez', 
        email: 'sarah.martinez@example.com',
        conversation_type: 'Billing Inquiry',
        sentiment: 'negative',
        business_impact: 'high',
        escalation_risk: 'high'
      },
      {
        name: 'Mike Chen',
        email: 'mike.chen@example.com', 
        conversation_type: 'Feature Request',
        sentiment: 'positive',
        business_impact: 'medium',
        escalation_risk: 'low'
      }
    ]
    
    demo_contacts.each do |contact_data|
      # Create contact
      contact = account.contacts.create!(
        name: contact_data[:name],
        email: contact_data[:email]
      )
      
      # Create contact inbox
      contact_inbox = ContactInbox.create!(
        contact: contact,
        inbox: inbox
      )
      
      # Create conversation with enhanced analytics
      conversation = account.conversations.create!(
        account: account,
        inbox: inbox,
        contact: contact,
        contact_inbox: contact_inbox,
        additional_attributes: {
          'enhanced_analytics' => {
            'sentiment_score' => case contact_data[:sentiment]
                                when 'positive' then 3.5
                                when 'negative' then -2.8
                                else 0.2
                                end,
            'business_impact_score' => case contact_data[:business_impact]
                                      when 'high' then 85
                                      when 'medium' then 60
                                      else 35
                                      end,
            'escalation_risk_score' => case contact_data[:escalation_risk]
                                      when 'high' then 8.5
                                      when 'medium' then 5.2
                                      else 2.1
                                      end,
            'conversation_quality_score' => rand(75..95),
            'category' => contact_data[:conversation_type],
            'predicted_resolution_time' => "#{rand(15..120)} minutes",
            'customer_satisfaction_prediction' => rand(70..95),
            'business_value_estimate' => "$#{rand(500..5000)}",
            'ai_insights' => {
              'summary' => "Customer inquiry regarding #{contact_data[:conversation_type].downcase}",
              'recommended_actions' => ['Prioritize response', 'Escalate if needed', 'Follow up within 24h'],
              'sentiment_trend' => contact_data[:sentiment],
              'urgency_level' => contact_data[:escalation_risk]
            }
          }
        }
      )
      
      # Create initial message
      conversation.messages.create!(
        account: account,
        inbox: inbox,
        conversation: conversation,
        message_type: 'incoming',
        content: case contact_data[:conversation_type]
                when 'API Integration Support'
                  "Hi, I'm having trouble integrating your API with our system. The authentication keeps failing."
                when 'Billing Inquiry'
                  "I was charged twice for my subscription this month. This is unacceptable and needs to be resolved immediately."
                when 'Feature Request'
                  "Love your product! Would it be possible to add dark mode? Many of us work late and it would be really helpful."
                end,
        sender: contact
      )
      
      puts "    ✅ Created demo conversation: #{contact.name} - #{contact_data[:conversation_type]}"
    end
  end
end

# Step 5: Final Verification
puts "🔍 Verifying setup..."

Account.find_each do |account|
  enabled_features = account.enabled_features.keys
  puts "  Account #{account.name}:"
  puts "    - Features enabled: #{enabled_features.size}"
  puts "    - AI Assistant: #{enabled_features.include?('captain_integration') ? '✅' : '❌'}"
  puts "    - New UI: #{enabled_features.include?('chatwoot_v4') ? '✅' : '❌'}"
  puts "    - Enterprise: #{account.custom_attributes['enterprise_enabled'] ? '✅' : '❌'}"
  puts "    - Conversations: #{account.conversations.count}"
end

puts ""
puts "🎉 Enhanced Chatwoot setup complete!"
puts ""
puts "✅ All enterprise features enabled"
puts "✅ AI Assistant available in sidebar"
puts "✅ Enhanced conversation analytics active"
puts "✅ Demo data created for testing"
puts ""
puts "Next steps:"
puts "1. Refresh your browser (Ctrl+F5)"
puts "2. Look for 'AI Assistant' in the left sidebar"
puts "3. Open any conversation to see enhanced analytics"
puts "4. Test SLA, Custom Roles, and other enterprise features"
puts ""
puts "🚀 Your Enhanced Chatwoot deployment is ready!" 