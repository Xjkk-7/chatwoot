#!/usr/bin/env ruby

# Simple test script to verify conversation analytics functionality
# Run with: ruby test_analytics.rb

puts "🧪 Testing Conversation Analytics Implementation"
puts "=" * 50

# Check if files exist
required_files = [
  'app/services/conversations/content_attributes_service.rb',
  'app/javascript/dashboard/components/widgets/conversation/ContentAttributesPanel.vue',
  'app/javascript/dashboard/components/widgets/conversation/ConversationAnalyticsBadge.vue',
  'db/seeds/demo_conversation_analytics.rb'
]

puts "\n📁 Checking required files:"
required_files.each do |file|
  if File.exist?(file)
    puts "✅ #{file} - EXISTS"
  else
    puts "❌ #{file} - MISSING"
  end
end

# Check routes
routes_file = 'config/routes.rb'
if File.exist?(routes_file)
  routes_content = File.read(routes_file)
  if routes_content.include?('content_attributes')
    puts "✅ content_attributes route - CONFIGURED"
  else
    puts "❌ content_attributes route - MISSING"
  end
end

# Check conversation model
model_file = 'app/models/conversation.rb'
if File.exist?(model_file)
  model_content = File.read(model_file)
  if model_content.include?('update_content_attributes')
    puts "✅ update_content_attributes method - EXISTS"
  else
    puts "❌ update_content_attributes method - MISSING"
  end
end

# Check view file
view_file = 'app/views/api/v1/conversations/partials/_conversation.json.jbuilder'
if File.exist?(view_file)
  view_content = File.read(view_file)
  if view_content.include?('content_attributes')
    puts "✅ content_attributes in JSON view - EXISTS"
  else
    puts "❌ content_attributes in JSON view - MISSING"
  end
end

# Check translation file
translation_file = 'app/javascript/dashboard/i18n/locale/en/conversation.json'
if File.exist?(translation_file)
  translation_content = File.read(translation_file)
  if translation_content.include?('CONTENT_ATTRIBUTES')
    puts "✅ CONTENT_ATTRIBUTES translations - EXISTS"
  else
    puts "❌ CONTENT_ATTRIBUTES translations - MISSING"
  end
end

puts "\n🎯 Summary:"
puts "- All required files should be present"
puts "- The ContentAttributesPanel should auto-generate analytics"
puts "- The analytics badge should appear in conversation cards"
puts "- The sidebar panel should be open by default"

puts "\n🔍 To see analytics in your deployed app:"
puts "1. Open any conversation with messages"
puts "2. Look for '🔍 Analytics & Insights' panel in the sidebar"
puts "3. Click refresh button if no data appears"
puts "4. Check browser console for debug messages"

puts "\n🚀 If issues persist:"
puts "1. Ensure your Heroku app has the latest deployment"
puts "2. Check browser network tab for API errors"
puts "3. Verify conversation has messages"
puts "4. Try hard refresh (Ctrl+F5)" 