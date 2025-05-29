class CreateDemoConversation < ActiveRecord::Migration[7.0]
  def up
    return unless Rails.env.production? # Only run in production (Heroku)
    
    account = Account.first
    return unless account
    
    inbox = account.inboxes.first
    return unless inbox
    
    # Create demo contact
    contact = account.contacts.find_or_create_by(email: 'demo@techcorp.com') do |c|
      c.name = 'Alex Johnson'
      c.additional_attributes = {
        'company' => 'TechCorp Solutions',
        'title' => 'Product Manager'
      }
    end
    
    # Create demo conversation
    conversation = account.conversations.find_or_create_by(
      inbox: inbox,
      contact: contact
    ) do |conv|
      conv.status = 'open'
      conv.assignee = account.users.first
    end
    
    # Add demo messages if conversation is new
    if conversation.messages.empty?
      messages = [
        {
          content: "Hi! I'm having trouble with API authentication. Getting 401 errors consistently and it's affecting our production environment. This is quite urgent!",
          message_type: "incoming",
          sender: contact
        },
        {
          content: "Hello Alex! I understand this is urgent. Let me help you resolve the API authentication issue immediately. Can you confirm you're using the correct endpoint?",
          message_type: "outgoing", 
          sender: account.users.first
        },
        {
          content: "Yes, using https://api.platform.com/v1/ and key looks like sk_live_xxxxxxxx. Error says 'Invalid authentication credentials provided'.",
          message_type: "incoming",
          sender: contact
        }
      ]
      
      messages.each_with_index do |msg, index|
        conversation.messages.create!(
          content: msg[:content],
          message_type: msg[:message_type],
          account: account,
          inbox: inbox,
          sender: msg[:sender],
          created_at: (messages.length - index).minutes.ago
        )
      end
      
      # Add analytics data
      analytics_data = {
        message_count: { total: 3, user: 2, agent: 1 },
        sentiment: 'positive',
        topics: ['API Integration', 'Authentication', 'Technical Support'],
        issue_analysis: {
          categories: [{ category: 'integration_issue', priority: 'high' }],
          primary_category: 'integration_issue'
        },
        business_impact: {
          impact_level: 'high',
          impact_score: 18,
          estimated_value: 2500
        },
        escalation_risk: {
          risk_level: 'medium',
          risk_score: 1
        },
        conversation_quality: {
          overall_score: 85,
          quality_level: 'good'
        }
      }
      
      conversation.update!(content_attributes: analytics_data)
    end
    
    Rails.logger.info "✅ Demo conversation created with analytics!"
  end
  
  def down
    # Remove demo data
    contact = Contact.find_by(email: 'demo@techcorp.com')
    contact&.conversations&.destroy_all
    contact&.destroy
  end
end 