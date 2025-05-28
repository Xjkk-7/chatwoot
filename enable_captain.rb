# Enable Captain AI Assistant and Enterprise Features
puts "🚀 Enabling AI Assistant (Captain) Features..."

# Enable all enterprise features for all accounts
Account.find_each do |account|
  puts "Processing account: #{account.name}"
  
  # Enable captain_integration and other enterprise features
  account.enable_features!(
    'captain_integration',
    'audit_logs', 
    'sla',
    'custom_roles',
    'disable_branding',
    'help_center',
    'campaigns',
    'team_management',
    'reports',
    'automations',
    'macros',
    'integrations'
  )
  
  # Update account to enterprise plan
  account.update!(
    custom_attributes: account.custom_attributes.merge({
      'plan_name' => 'Enterprise',
      'subscription_status' => 'active',
      'enterprise_enabled' => true
    })
  )
  
  puts "✅ Enabled enterprise features for #{account.name}"
end

# Set installation to enterprise
InstallationConfig.find_or_create_by(name: 'INSTALLATION_PRICING_PLAN') do |config|
  config.value = 'enterprise'
  config.locked = true
end

InstallationConfig.find_or_create_by(name: 'CHATWOOT_ENTERPRISE_ENABLED') do |config|
  config.value = 'true'
  config.locked = true
end

puts "🎉 SUCCESS! AI Assistant should now be visible in your conversation sidebar!"
puts "🔄 Please restart your Heroku app: heroku restart -a your-app-name" 