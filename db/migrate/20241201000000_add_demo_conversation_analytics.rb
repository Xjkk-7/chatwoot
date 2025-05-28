class AddDemoConversationAnalytics < ActiveRecord::Migration[7.0]
  def up
    # Add demo analytics data to existing conversations
    return unless Rails.env.production? || Rails.env.development?
    
    # Find the first few conversations to add demo analytics
    conversations = Conversation.includes(:account, :contact, :messages).limit(5)
    
    conversations.each_with_index do |conversation, index|
      next if conversation.messages.empty?
      
      # Generate different types of demo analytics for variety
      analytics_data = case index
      when 0
        generate_api_support_analytics(conversation)
      when 1
        generate_billing_inquiry_analytics(conversation)
      when 2
        generate_feature_request_analytics(conversation)
      when 3
        generate_bug_report_analytics(conversation)
      else
        generate_general_support_analytics(conversation)
      end
      
      # Update conversation with analytics data
      conversation.update_columns(
        additional_attributes: analytics_data,
        content_attributes: analytics_data,
        updated_at: Time.current
      )
      
      puts "✅ Added demo analytics to conversation #{conversation.id}"
    end
  end
  
  def down
    # Remove demo analytics data
    Conversation.where.not(content_attributes: nil).update_all(
      content_attributes: nil,
      additional_attributes: {}
    )
  end
  
  private
  
  def generate_api_support_analytics(conversation)
    message_count = conversation.messages.count
    user_messages = conversation.messages.incoming.count
    agent_messages = conversation.messages.outgoing.count
    
    {
      message_count: {
        total: message_count,
        user: user_messages,
        agent: agent_messages
      },
      response_times: {
        average: 420, # 7 minutes
        min: 180,     # 3 minutes
        max: 900,     # 15 minutes
        total: 1680   # 28 minutes total
      },
      sentiment: 'positive',
      topics: ['API Integration', 'Authentication', 'Technical Support', 'Documentation'],
      language: 'english',
      complexity: 0.75,
      engagement_metrics: {
        duration_seconds: 5400, # 1.5 hours
        avg_time_between_messages: 675, # ~11 minutes
        user_messages: user_messages,
        agent_messages: agent_messages,
        engagement_score: 0.88
      },
      conversation_summary: "Technical support conversation about API integration issues, resolved with detailed troubleshooting steps",
      key_phrases: ['API integration', 'authentication error', 'technical documentation', 'troubleshooting', 'resolved'],
      resolution_status: 'resolved',
      
      # Enhanced business analytics
      issue_analysis: {
        categories: [
          { category: 'integration_issue', priority: 'high', severity: 'medium' },
          { category: 'technical_support', priority: 'medium', severity: 'low' }
        ],
        primary_category: 'integration_issue',
        priority: 'high',
        category_count: 2
      },
      
      escalation_risk: {
        risk_level: 'low',
        risk_score: -1,
        high_risk_indicators: 0,
        medium_risk_indicators: 1,
        positive_indicators: 3,
        slow_response_penalty: 0
      },
      
      business_impact: {
        impact_level: 'high',
        impact_score: 16,
        impact_indicators: { 'high_value' => 1, 'technical' => 1, 'integration' => 1 },
        estimated_value: 3500
      },
      
      conversation_quality: {
        overall_score: 92,
        quality_level: 'excellent',
        components: {
          engagement: 25,
          responsiveness: 24,
          sentiment: 22,
          resolution: 25
        },
        improvement_suggestions: ['Continue excellent technical support']
      }
    }
  end
  
  def generate_billing_inquiry_analytics(conversation)
    message_count = conversation.messages.count
    user_messages = conversation.messages.incoming.count
    agent_messages = conversation.messages.outgoing.count
    
    {
      message_count: {
        total: message_count,
        user: user_messages,
        agent: agent_messages
      },
      response_times: {
        average: 300, # 5 minutes
        min: 120,     # 2 minutes
        max: 600,     # 10 minutes
        total: 900    # 15 minutes total
      },
      sentiment: 'neutral',
      topics: ['Billing', 'Payment', 'Account Management', 'Subscription'],
      language: 'english',
      complexity: 0.45,
      engagement_metrics: {
        duration_seconds: 2700, # 45 minutes
        avg_time_between_messages: 450, # ~7.5 minutes
        user_messages: user_messages,
        agent_messages: agent_messages,
        engagement_score: 0.72
      },
      conversation_summary: "Billing inquiry about subscription charges and payment methods, resolved with account clarification",
      key_phrases: ['billing question', 'subscription charges', 'payment method', 'account clarification'],
      resolution_status: 'resolved',
      
      issue_analysis: {
        categories: [
          { category: 'billing_inquiry', priority: 'medium', severity: 'low' }
        ],
        primary_category: 'billing_inquiry',
        priority: 'medium',
        category_count: 1
      },
      
      escalation_risk: {
        risk_level: 'low',
        risk_score: -2,
        high_risk_indicators: 0,
        medium_risk_indicators: 0,
        positive_indicators: 2,
        slow_response_penalty: 0
      },
      
      business_impact: {
        impact_level: 'medium',
        impact_score: 8,
        impact_indicators: { 'billing' => 1, 'retention' => 1 },
        estimated_value: 1200
      },
      
      conversation_quality: {
        overall_score: 78,
        quality_level: 'good',
        components: {
          engagement: 18,
          responsiveness: 22,
          sentiment: 16,
          resolution: 22
        },
        improvement_suggestions: ['Proactive billing communication']
      }
    }
  end
  
  def generate_feature_request_analytics(conversation)
    message_count = conversation.messages.count
    user_messages = conversation.messages.incoming.count
    agent_messages = conversation.messages.outgoing.count
    
    {
      message_count: {
        total: message_count,
        user: user_messages,
        agent: agent_messages
      },
      response_times: {
        average: 600, # 10 minutes
        min: 300,     # 5 minutes
        max: 1200,    # 20 minutes
        total: 1800   # 30 minutes total
      },
      sentiment: 'positive',
      topics: ['Feature Request', 'Product Enhancement', 'User Experience', 'Feedback'],
      language: 'english',
      complexity: 0.55,
      engagement_metrics: {
        duration_seconds: 3600, # 1 hour
        avg_time_between_messages: 600, # 10 minutes
        user_messages: user_messages,
        agent_messages: agent_messages,
        engagement_score: 0.82
      },
      conversation_summary: "Feature request discussion about product enhancements and user experience improvements",
      key_phrases: ['feature request', 'product enhancement', 'user experience', 'feedback', 'roadmap'],
      resolution_status: 'likely_resolved',
      
      issue_analysis: {
        categories: [
          { category: 'feature_request', priority: 'low', severity: 'low' },
          { category: 'product_feedback', priority: 'medium', severity: 'low' }
        ],
        primary_category: 'feature_request',
        priority: 'medium',
        category_count: 2
      },
      
      escalation_risk: {
        risk_level: 'low',
        risk_score: -3,
        high_risk_indicators: 0,
        medium_risk_indicators: 0,
        positive_indicators: 4,
        slow_response_penalty: 0
      },
      
      business_impact: {
        impact_level: 'medium',
        impact_score: 12,
        impact_indicators: { 'product_feedback' => 1, 'enhancement' => 1, 'engagement' => 1 },
        estimated_value: 2000
      },
      
      conversation_quality: {
        overall_score: 85,
        quality_level: 'excellent',
        components: {
          engagement: 23,
          responsiveness: 20,
          sentiment: 22,
          resolution: 20
        },
        improvement_suggestions: ['Continue gathering valuable feedback']
      }
    }
  end
  
  def generate_bug_report_analytics(conversation)
    message_count = conversation.messages.count
    user_messages = conversation.messages.incoming.count
    agent_messages = conversation.messages.outgoing.count
    
    {
      message_count: {
        total: message_count,
        user: user_messages,
        agent: agent_messages
      },
      response_times: {
        average: 240, # 4 minutes
        min: 60,      # 1 minute
        max: 480,     # 8 minutes
        total: 720    # 12 minutes total
      },
      sentiment: 'negative',
      topics: ['Bug Report', 'Technical Issue', 'Software Problem', 'Urgent Fix'],
      language: 'english',
      complexity: 0.85,
      engagement_metrics: {
        duration_seconds: 1800, # 30 minutes
        avg_time_between_messages: 240, # 4 minutes
        user_messages: user_messages,
        agent_messages: agent_messages,
        engagement_score: 0.95
      },
      conversation_summary: "Critical bug report with urgent technical issue requiring immediate attention and resolution",
      key_phrases: ['bug report', 'technical issue', 'urgent fix', 'software problem', 'critical'],
      resolution_status: 'resolved',
      
      issue_analysis: {
        categories: [
          { category: 'bug_report', priority: 'high', severity: 'high' },
          { category: 'urgent_issue', priority: 'critical', severity: 'critical' }
        ],
        primary_category: 'bug_report',
        priority: 'critical',
        category_count: 2
      },
      
      escalation_risk: {
        risk_level: 'medium',
        risk_score: 2,
        high_risk_indicators: 1,
        medium_risk_indicators: 2,
        positive_indicators: 2,
        slow_response_penalty: 0
      },
      
      business_impact: {
        impact_level: 'high',
        impact_score: 20,
        impact_indicators: { 'critical_bug' => 1, 'urgent' => 1, 'technical' => 1 },
        estimated_value: 5000
      },
      
      conversation_quality: {
        overall_score: 88,
        quality_level: 'excellent',
        components: {
          engagement: 25,
          responsiveness: 25,
          sentiment: 15,
          resolution: 23
        },
        improvement_suggestions: ['Excellent urgent response handling']
      }
    }
  end
  
  def generate_general_support_analytics(conversation)
    message_count = conversation.messages.count
    user_messages = conversation.messages.incoming.count
    agent_messages = conversation.messages.outgoing.count
    
    {
      message_count: {
        total: message_count,
        user: user_messages,
        agent: agent_messages
      },
      response_times: {
        average: 360, # 6 minutes
        min: 180,     # 3 minutes
        max: 720,     # 12 minutes
        total: 1080   # 18 minutes total
      },
      sentiment: 'positive',
      topics: ['General Support', 'How-to Question', 'User Guidance', 'Help'],
      language: 'english',
      complexity: 0.35,
      engagement_metrics: {
        duration_seconds: 2400, # 40 minutes
        avg_time_between_messages: 480, # 8 minutes
        user_messages: user_messages,
        agent_messages: agent_messages,
        engagement_score: 0.68
      },
      conversation_summary: "General support conversation providing user guidance and helpful information",
      key_phrases: ['general support', 'how-to question', 'user guidance', 'helpful information'],
      resolution_status: 'resolved',
      
      issue_analysis: {
        categories: [
          { category: 'general_support', priority: 'low', severity: 'low' }
        ],
        primary_category: 'general_support',
        priority: 'low',
        category_count: 1
      },
      
      escalation_risk: {
        risk_level: 'low',
        risk_score: -4,
        high_risk_indicators: 0,
        medium_risk_indicators: 0,
        positive_indicators: 3,
        slow_response_penalty: 0
      },
      
      business_impact: {
        impact_level: 'low',
        impact_score: 4,
        impact_indicators: { 'support' => 1 },
        estimated_value: 500
      },
      
      conversation_quality: {
        overall_score: 75,
        quality_level: 'good',
        components: {
          engagement: 17,
          responsiveness: 19,
          sentiment: 20,
          resolution: 19
        },
        improvement_suggestions: ['Standard support quality maintained']
      }
    }
  end
end 