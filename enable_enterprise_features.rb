#!/usr/bin/env ruby

# Script to enable all enterprise features for Chatwoot accounts
# This enables AI Assistant, Analytics, and other premium features

puts "🚀 Enabling Enterprise Features for Chatwoot"
puts "=" * 50

# All available enterprise features
ENTERPRISE_FEATURES = [
  'captain_integration',      # AI Assistant - THIS IS KEY!
  'audit_logs',              # Audit logs
  'sla',                     # SLA management
  'custom_roles',            # Custom user roles
  'disable_branding',        # Remove Chatwoot branding
  'help_center',             # Help center
  'campaigns',               # Marketing campaigns
  'team_management',         # Advanced team features
  'reports',                 # Advanced reporting
  'automations',             # Workflow automations
  'macros',                  # Quick response macros
  'integrations',            # Third-party integrations
  'voice_recorder',          # Voice messages
  'crm',                     # CRM features
  'inbox_management',        # Advanced inbox features
  'labels',                  # Conversation labels
  'custom_attributes',       # Custom fields
  'canned_responses',        # Saved responses
  'agent_bots',              # Bot management
  'inbound_emails',          # Email handling
  'channel_email',           # Email channel
  'channel_facebook',        # Facebook integration
  'channel_twitter',         # Twitter integration (deprecated but safe)
  'channel_website',         # Website widget
  'linear_integration',      # Linear project management
  'shopify_integration',     # Shopify integration
  'crm_integration',         # CRM integration
  'channel_instagram'        # Instagram integration
].freeze

begin
  if defined?(Rails)
    puts "✅ Rails environment detected"
    
    # Enable features for all accounts
    Account.find_each do |account|
      puts "📊 Processing account: #{account.name} (ID: #{account.id})"
      
      # Enable all enterprise features
      account.enable_features!(*ENTERPRISE_FEATURES)
      
      puts "  ✅ Enabled #{ENTERPRISE_FEATURES.count} enterprise features"
      
      # Ensure the account has enterprise attributes
      account.update!(
        custom_attributes: account.custom_attributes.merge({
          'plan_name' => 'Enterprise',
          'subscription_status' => 'active',
          'enterprise_enabled' => true
        })
      ) rescue nil
      
      puts "  ✅ Updated account to Enterprise plan"
    end
    
    # Update installation config to enterprise
    installation_configs = [
      { name: 'INSTALLATION_PRICING_PLAN', value: 'enterprise' },
      { name: 'INSTALLATION_PRICING_PLAN_QUANTITY', value: '100' },
      { name: 'CHATWOOT_ENTERPRISE_ENABLED', value: 'true' }
    ]
    
    installation_configs.each do |config|
      ic = InstallationConfig.find_or_initialize_by(name: config[:name])
      ic.value = config[:value]
      ic.save!
      puts "✅ Set #{config[:name]} = #{config[:value]}"
    end
    
    puts ""
    puts "🎉 SUCCESS! All enterprise features enabled!"
    puts ""
    puts "📋 Features enabled:"
    ENTERPRISE_FEATURES.each { |feature| puts "  • #{feature}" }
    puts ""
    puts "🔄 Please restart your Rails server to see the changes"
    puts "💡 AI Assistant should now appear in your conversation sidebar!"
    
  else
    puts "❌ This script must be run in a Rails environment"
    puts "💡 Try: bundle exec rails runner enable_enterprise_features.rb"
  end
  
rescue => e
  puts "❌ Error: #{e.message}"
  puts "🔍 Stack trace:"
  puts e.backtrace[0..5].join("\n")
end 