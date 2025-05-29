# Demo Conversation Analytics Seeder
# This creates a sample conversation with comprehensive analytics data
# to showcase the enhanced conversation analytics features

class DemoConversationAnalyticsSeeder
  def self.run
    # Find or create a demo account
    account = Account.find_by(name: 'Demo Account') || Account.first
    return unless account

    # Find or create a demo inbox
    inbox = account.inboxes.find_by(name: 'Demo Support') || 
            account.inboxes.first ||
            create_demo_inbox(account)

    # Find or create a demo contact
    contact = create_demo_contact(account)

    # Create a comprehensive demo conversation
    conversation = create_demo_conversation(account, inbox, contact)

    # Add realistic messages to the conversation
    add_demo_messages(conversation, contact, account)

    # Generate analytics for the conversation
    generate_conversation_analytics(conversation)

    puts "✅ Demo conversation with analytics created successfully!"
    puts "📊 Conversation ID: #{conversation.id}"
    puts "🎯 Account: #{account.name}"
    puts "📧 Contact: #{contact.name} (#{contact.email})"
  end

  private

  def self.create_demo_inbox(account)
    account.inboxes.create!(
      name: 'Demo Support',
      channel_type: 'Channel::WebWidget',
      account: account
    )
  end

  def self.create_demo_contact(account)
    account.contacts.find_or_create_by(email: 'demo.customer@example.com') do |contact|
      contact.name = 'Alex Johnson'
      contact.phone_number = '+1 (555) 123-4567'
      contact.additional_attributes = {
        'company' => 'TechCorp Solutions',
        'title' => 'Product Manager',
        'location' => 'San Francisco, CA'
      }
    end
  end

  def self.create_demo_conversation(account, inbox, contact)
    account.conversations.find_or_create_by(
      inbox: inbox,
      contact: contact,
      account: account
    ) do |conversation|
      conversation.display_id = rand(1000..9999)
      conversation.status = 'resolved'
      conversation.assignee = account.users.first
      conversation.created_at = 2.hours.ago
      conversation.updated_at = 30.minutes.ago
    end
  end

  def self.add_demo_messages(conversation, contact, account)
    # Clear existing messages for demo consistency
    conversation.messages.destroy_all

    agent = account.users.first
    
    # Customer initial message (2 hours ago)
    conversation.messages.create!(
      content: "Hi! I'm having trouble integrating your API with our customer support system. The authentication seems to be failing and I'm getting 401 errors consistently. This is quite urgent as it's affecting our production environment. Could you please help me resolve this issue quickly? We're a premium enterprise client and this is critical for our workflow.",
      account: account,
      inbox: conversation.inbox,
      conversation: conversation,
      message_type: 'incoming',
      contact: contact,
      sender: contact,
      created_at: 2.hours.ago
    )

    # Agent response (1 hour 45 minutes ago)
    conversation.messages.create!(
      content: "Hello Alex! Thank you for contacting us. I understand this is urgent and I'm here to help you resolve the API authentication issue immediately. As a premium enterprise client, I'll prioritize this and ensure we get your integration working quickly. Let me guide you through some troubleshooting steps. First, can you confirm you're using the correct API endpoint and your API key format?",
      account: account,
      inbox: conversation.inbox,
      conversation: conversation,
      message_type: 'outgoing',
      sender: agent,
      created_at: 1.hour.45.minutes.ago
    )

    # Customer response (1 hour 30 minutes ago)
    conversation.messages.create!(
      content: "Yes, I'm using https://api.yourplatform.com/v1/ and my API key looks like sk_live_xxxxxxxxxxxxxxxx. The error message I'm getting is 'Invalid authentication credentials provided'. I've double-checked the key multiple times.",
      account: account,
      inbox: conversation.inbox,
      conversation: conversation,
      message_type: 'incoming',
      contact: contact,
      sender: contact,
      created_at: 1.hour.30.minutes.ago
    )

    # Agent detailed response (1 hour 15 minutes ago)
    conversation.messages.create!(
      content: "Thank you for providing those details. The issue might be related to how you're passing the API key in the headers. Please ensure you're using 'Authorization: Bearer YOUR_API_KEY' in the header, not 'X-API-Key'. Also, make sure there are no extra spaces. Here's a sample curl command: curl -H 'Authorization: Bearer sk_live_xxxxxxxxxxxxxxxx' https://api.yourplatform.com/v1/status",
      account: account,
      inbox: conversation.inbox,
      conversation: conversation,
      message_type: 'outgoing',
      sender: agent,
      created_at: 1.hour.15.minutes.ago
    )

    # Customer success message (1 hour ago)
    conversation.messages.create!(
      content: "Perfect! That worked immediately. I was indeed using X-API-Key instead of Authorization Bearer. The integration is now working perfectly and all our tests are passing. Thank you so much for the quick and excellent support!",
      account: account,
      inbox: conversation.inbox,
      conversation: conversation,
      message_type: 'incoming',
      contact: contact,
      sender: contact,
      created_at: 1.hour.ago
    )

    # Agent closing message (45 minutes ago)
    conversation.messages.create!(
      content: "Excellent! I'm so glad we could resolve this quickly for you. The API authentication header format is a common issue, so you're definitely not alone in encountering this. If you have any other questions about the API integration or need further assistance, please don't hesitate to reach out. Have a great day!",
      account: account,
      inbox: conversation.inbox,
      conversation: conversation,
      message_type: 'outgoing',
      sender: agent,
      created_at: 45.minutes.ago
    )

    # Customer final thank you (30 minutes ago)
    conversation.messages.create!(
      content: "Thank you again! Your support team is amazing. I'll definitely reach out if we need any help in the future.",
      account: account,
      inbox: conversation.inbox,
      conversation: conversation,
      message_type: 'incoming',
      contact: contact,
      sender: contact,
      created_at: 30.minutes.ago
    )
  end

  def self.generate_conversation_analytics(conversation)
    # Create comprehensive analytics data with enhanced freestyle features
    analytics_data = {
      message_count: {
        total: 7,
        user: 4,
        agent: 3
      },
      response_times: {
        average: 450, # 7.5 minutes average
        min: 300,     # 5 minutes minimum
        max: 900,     # 15 minutes maximum
        total: 1800   # 30 minutes total
      },
      sentiment: 'positive',
      topics: ['API Integration', 'Authentication', 'Technical Support', 'Urgent Issue'],
      language: 'english',
      complexity: 0.65,
      engagement_metrics: {
        duration_seconds: 7200, # 2 hours
        avg_time_between_messages: 1028, # ~17 minutes
        user_messages: 4,
        agent_messages: 3,
        engagement_score: 0.85
      },
      conversation_summary: "API authentication troubleshooting conversation about Bearer token format issue, successfully resolved with customer satisfaction",
      key_phrases: ['API authentication', 'Bearer token', 'production environment', 'excellent support', 'urgent issue', 'integration'],
      resolution_status: 'resolved',
      
      # Enhanced freestyle features
      issue_analysis: {
        categories: [
          { category: 'integration_issue', priority: 'medium', severity: 'medium' },
          { category: 'urgent_bug', priority: 'high', severity: 'critical' }
        ],
        primary_category: 'integration_issue',
        priority: 'high',
        category_count: 2
      },
      
      customer_journey: {
        primary_stage: 'active_user',
        stage_indicators: { 'active_user' => 2, 'support' => 3 },
        confidence_score: 3
      },
      
      product_detection: [
        { product: 'api', mention_count: 4, relevance: 0.75 },
        { product: 'dashboard', mention_count: 1, relevance: 0.20 }
      ],
      
      escalation_risk: {
        risk_level: 'low',
        risk_score: -2,
        high_risk_indicators: 0,
        medium_risk_indicators: 1,
        positive_indicators: 4,
        slow_response_penalty: 0
      },
      
      agent_performance: {
        total_responses: 3,
        avg_response_time_seconds: 450,
        avg_message_length: 145,
        professionalism_score: 3,
        resolution_attempts: 2,
        first_response_time: 300,
        agents_involved: ['Support Agent']
      },
      
      channel_effectiveness: {
        channel_type: 'Channel::WebWidget',
        channel_fitness: 'good',
        conversation_complexity: 0.65,
        message_volume: 7,
        channel_recommendation: 'email'
      },
      
      conversation_quality: {
        overall_score: 88,
        quality_level: 'excellent',
        components: {
          engagement: 24,
          responsiveness: 25,
          sentiment: 20,
          resolution: 25
        },
        improvement_suggestions: ['Maintain current quality standards']
      },
      
      business_impact: {
        impact_level: 'high',
        impact_score: 18,
        impact_indicators: { 'high_value' => 1, 'expansion' => 0, 'retention' => 1 },
        estimated_value: 2500
      }
    }

    # Update the conversation with analytics data  
    conversation.update!(
      additional_attributes: analytics_data,
      content_attributes: analytics_data # Also store in content_attributes for immediate access
    )
    
    # Also call the actual analytics service to demonstrate it works
    begin
      service = Conversations::ContentAttributesService.new(conversation: conversation)
      service.analyze_and_update
      puts "📈 Analytics service executed successfully"
    rescue => e
      puts "⚠️  Analytics service error (using demo data): #{e.message}"
    end
  end
end

# Run the seeder
DemoConversationAnalyticsSeeder.run 