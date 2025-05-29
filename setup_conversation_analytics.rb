#!/usr/bin/env ruby

# Comprehensive setup script for Conversation Analytics
# This creates demo conversations with analytics data

puts "🔍 Setting up Conversation Analytics"
puts "=" * 50

begin
  if defined?(Rails)
    puts "✅ Rails environment detected"
    
    # First, let's create or update conversations with analytics
    Account.find_each do |account|
      puts "📊 Setting up analytics for account: #{account.name}"
      
      # Find or create demo conversations
      conversation = account.conversations.first
      
      if conversation.nil?
        # Create a demo conversation if none exists
        inbox = account.inboxes.first
        if inbox.nil?
          puts "⚠️  No inboxes found, creating a demo inbox..."
          inbox = account.inboxes.create!(
            name: 'Demo Website',
            channel: Channel::WebWidget.create!(
              website_url: 'https://demo.chatwoot.com',
              widget_color: '#1f93ff',
              website_name: 'Demo Website',
              account: account
            )
          )
        end
        
        contact = account.contacts.first || account.contacts.create!(
          name: 'Demo Customer',
          email: 'demo@customer.com'
        )
        
        conversation = account.conversations.create!(
          inbox: inbox,
          contact: contact,
          status: 'open',
          assignee: account.users.first
        )
        
        # Add some demo messages
        conversation.messages.create!(
          account: account,
          inbox: inbox,
          message_type: 'incoming',
          content: 'Hi, I need help with integrating the API for our e-commerce platform. We are getting timeout errors.',
          sender: contact
        )
        
        conversation.messages.create!(
          account: account,
          inbox: inbox,
          message_type: 'outgoing',
          content: 'Hello! I understand you are experiencing API integration issues. Let me help you troubleshoot the timeout errors.',
          sender: account.users.first
        )
        
        conversation.messages.create!(
          account: account,
          inbox: inbox,
          message_type: 'incoming',
          content: 'Yes, specifically when we try to sync product inventory. Our team is blocked and this is affecting our sales.',
          sender: contact
        )
        
        conversation.messages.create!(
          account: account,
          inbox: inbox,
          message_type: 'outgoing',
          content: 'I can see this is urgent. Let me escalate this to our API team and provide you with the latest timeout configuration settings.',
          sender: account.users.first
        )
        
        puts "  ✅ Created demo conversation with messages"
      end
      
      # Now generate analytics for this conversation
      puts "  🔍 Generating conversation analytics..."
      
      # Load and instantiate the content attributes service
      require Rails.root.join('app/services/conversations/content_attributes_service.rb')
      
      service = Conversations::ContentAttributesService.new(conversation)
      enhanced_attributes = service.generate_content_attributes
      
      # Update the conversation with enhanced analytics
      conversation.update_content_attributes(enhanced_attributes)
      
      puts "  ✅ Enhanced analytics generated:"
      puts "    • Issue Analysis: #{enhanced_attributes.dig('issue_analysis', 'primary_category')}"
      puts "    • Business Impact: #{enhanced_attributes.dig('business_impact', 'impact_level')}"
      puts "    • Quality Score: #{enhanced_attributes.dig('conversation_quality', 'overall_score')}%"
      puts "    • Escalation Risk: #{enhanced_attributes.dig('escalation_risk', 'risk_level')}"
      
      # Create additional demo conversations for variety
      3.times do |i|
        demo_conv = account.conversations.create!(
          inbox: conversation.inbox,
          contact: account.contacts.create!(
            name: "Customer #{i + 2}",
            email: "customer#{i + 2}@demo.com"
          ),
          status: ['open', 'resolved', 'pending'].sample,
          assignee: account.users.sample
        )
        
        # Generate different types of conversations
        case i
        when 0
          content = "I have a billing question about my subscription charges."
          category = 'billing_dispute'
        when 1
          content = "How do I set up automation rules for my team?"
          category = 'onboarding_help'
        when 2
          content = "There's a security concern with unauthorized access attempts."
          category = 'security_concern'
        end
        
        demo_conv.messages.create!(
          account: account,
          inbox: conversation.inbox,
          message_type: 'incoming',
          content: content,
          sender: demo_conv.contact
        )
        
        demo_conv.messages.create!(
          account: account,
          inbox: conversation.inbox,
          message_type: 'outgoing',
          content: "Thank you for contacting us. Let me help you with that right away.",
          sender: account.users.first
        )
        
        # Generate analytics for demo conversation
        demo_service = Conversations::ContentAttributesService.new(demo_conv)
        demo_attributes = demo_service.generate_content_attributes
        demo_conv.update_content_attributes(demo_attributes)
        
        puts "  ✅ Created demo conversation #{i + 2} with #{category} analytics"
      end
    end
    
    puts ""
    puts "🎉 Conversation Analytics Setup Complete!"
    puts ""
    puts "📍 Where to find the analytics:"
    puts "  1. 🔍 Analytics & Insights panel (top priority in conversation sidebar)"
    puts "  2. 📊 Analytics badges in conversation list"
    puts "  3. 💼 Business intelligence metrics"
    puts "  4. 🎯 Quality scores and improvement suggestions"
    puts ""
    puts "🚀 Features now available:"
    puts "  • Issue categorization (bugs, billing, security, etc.)"
    puts "  • Business impact scoring ($0-$5000+ value estimates)"
    puts "  • Escalation risk assessment (high/medium/low)"
    puts "  • Conversation quality scoring (0-100%)"
    puts "  • Customer journey mapping (awareness → churn risk)"
    puts "  • Agent performance indicators"
    puts "  • Channel effectiveness analysis"
    puts ""
    puts "🔄 Refresh your browser to see the new analytics!"
    
  else
    puts "❌ This script must be run in a Rails environment"
    puts "💡 Try: bundle exec rails runner setup_conversation_analytics.rb"
  end
  
rescue => e
  puts "❌ Error: #{e.message}"
  puts "🔍 Stack trace:"
  puts e.backtrace[0..5].join("\n")
end 