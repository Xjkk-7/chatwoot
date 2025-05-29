class Conversations::ContentAttributesService
  pattr_initialize [:conversation!]

  def analyze_and_update
    return unless conversation.messages.present?

    attributes = generate_content_attributes
    conversation.update_content_attributes(attributes)
  end

  private

  def generate_content_attributes
    {
      message_count: calculate_message_count,
      response_times: calculate_response_times,
      sentiment: analyze_sentiment,
      topics: extract_topics,
      language: detect_language,
      complexity: calculate_complexity,
      engagement_metrics: calculate_engagement_metrics,
      conversation_summary: generate_conversation_summary,
      key_phrases: extract_key_phrases,
      resolution_status: determine_resolution_status,
      # Enhanced freestyle features
      issue_analysis: analyze_issue_categories,
      customer_journey: analyze_customer_journey_stage,
      product_detection: detect_mentioned_products,
      escalation_risk: assess_escalation_risk,
      agent_performance: calculate_agent_performance_indicators,
      channel_effectiveness: analyze_channel_effectiveness,
      conversation_quality: assess_conversation_quality,
      business_impact: calculate_business_impact_metrics
    }
  end

  def calculate_message_count
    {
      total: conversation.messages.count,
      user: conversation.messages.incoming.count,
      agent: conversation.messages.outgoing.count
    }
  end

  def calculate_response_times
    response_times = []
    
    incoming_messages = conversation.messages.incoming.order(created_at: :asc)
    outgoing_messages = conversation.messages.outgoing.order(created_at: :asc)
    
    incoming_messages.each do |incoming|
      # Find the next outgoing message after this incoming message
      next_response = outgoing_messages.where('created_at > ?', incoming.created_at).first
      
      if next_response
        response_time = (next_response.created_at - incoming.created_at).to_i
        response_times << response_time
      end
    end
    
    return {
      average: response_times.empty? ? nil : (response_times.sum / response_times.size),
      min: response_times.min,
      max: response_times.max,
      total: response_times.sum
    }
  end

  def analyze_sentiment
    # This is a simple placeholder sentiment analysis
    # In a real implementation, you would use a proper NLP service
    
    positive_words = %w[good great excellent amazing awesome thank thanks happy appreciate resolved solved fixed]
    negative_words = %w[bad poor terrible awful unhappy angry issue problem bug wrong broken]
    
    content = conversation.messages.pluck(:content).join(' ').downcase
    
    positive_count = 0
    negative_count = 0
    
    positive_words.each do |word|
      positive_count += content.scan(/\b#{word}\b/).size
    end
    
    negative_words.each do |word|
      negative_count += content.scan(/\b#{word}\b/).size
    end
    
    sentiment_score = positive_count - negative_count
    
    if sentiment_score > 2
      'very_positive'
    elsif sentiment_score > 0
      'positive'
    elsif sentiment_score < -2
      'very_negative'
    elsif sentiment_score < 0
      'negative'
    else
      'neutral'
    end
  end

  def extract_topics
    # This is a simple placeholder topic extraction
    # In a real implementation, you would use a proper NLP service
    
    topic_keywords = {
      'billing': %w[bill payment invoice charge subscription cost price refund],
      'technical_support': %w[error bug issue problem broken fix crash not_working],
      'product_question': %w[how work feature functionality use using guide],
      'feedback': %w[suggest suggestion recommend improvement better],
      'account': %w[login password sign_in account profile register],
      'shipping': %w[delivery ship shipping track package order arrival]
    }
    
    content = conversation.messages.pluck(:content).join(' ').downcase
    detected_topics = []
    
    topic_keywords.each do |topic, keywords|
      keywords.each do |keyword|
        if content.include?(keyword)
          detected_topics << topic.to_s
          break
        end
      end
    end
    
    detected_topics.uniq
  end

  def detect_language
    # Simple language detection based on the first message
    # In a real implementation, you would use a proper language detection service
    
    first_message = conversation.messages.first&.content
    return 'unknown' unless first_message
    
    case first_message
    when /[áéíóúñ¿¡]/
      'spanish'
    when /[àâçéèêëîïôùûü]/
      'french'
    when /[äöüß]/
      'german'
    when /[你好谢谢再见]/
      'chinese'
    when /[こんにちはありがとうさようなら]/
      'japanese'
    else
      'english'
    end
  end

  def calculate_complexity
    # Enhanced complexity calculation based on message length, vocabulary, and conversation flow
    message_texts = conversation.messages.pluck(:content)
    return 0 if message_texts.empty?
    
    # Calculate average message length
    avg_length = message_texts.sum(&:length) / message_texts.size
    
    # Calculate unique vocabulary size
    unique_words = message_texts.join(' ').downcase.scan(/\b[a-z]+\b/).uniq.size
    
    # Calculate conversation back-and-forth complexity
    conversation_turns = [conversation.messages.incoming.count, conversation.messages.outgoing.count].min
    
    # Normalize to a 0-1 scale for each metric
    length_score = [avg_length / 150.0, 1.0].min
    vocab_score = [unique_words / 150.0, 1.0].min
    turns_score = [conversation_turns / 10.0, 1.0].min
    
    # Combine scores with weights
    complexity_score = (length_score * 0.3) + (vocab_score * 0.4) + (turns_score * 0.3)
    
    # Return a value between 0-1
    complexity_score.round(2)
  end

  def calculate_engagement_metrics
    # Calculate engagement metrics based on conversation patterns
    messages = conversation.messages
    
    # Time from first to last message
    first_message = messages.order(created_at: :asc).first
    last_message = messages.order(created_at: :asc).last
    
    duration = last_message.created_at - first_message.created_at
    
    # Calculate average time between messages
    message_times = messages.order(created_at: :asc).pluck(:created_at)
    time_between_messages = []
    
    (1...message_times.size).each do |i|
      time_between_messages << (message_times[i] - message_times[i-1]).to_i
    end
    
    avg_time_between = time_between_messages.empty? ? 0 : time_between_messages.sum / time_between_messages.size
    
    # Calculate user engagement score based on response patterns
    user_messages = messages.incoming.count
    agent_messages = messages.outgoing.count
    
    engagement_score = if user_messages > 0 && agent_messages > 0
                         [user_messages.to_f / agent_messages, 1.0].min * 0.5 + 0.5
                       else
                         0.0
                       end
    
    {
      duration_seconds: duration.to_i,
      avg_time_between_messages: avg_time_between,
      user_messages: user_messages,
      agent_messages: agent_messages,
      engagement_score: engagement_score.round(2)
    }
  end

  def generate_conversation_summary
    # Generate a simple summary based on first and last messages
    first_message = conversation.messages.order(created_at: :asc).first&.content
    last_message = conversation.messages.order(created_at: :asc).last&.content
    
    return "No messages" unless first_message
    
    topics = extract_topics
    topic_text = topics.any? ? "about #{topics.join(', ')}" : ""
    
    "Conversation #{topic_text} starting with '#{first_message.to_s.truncate(50)}'"
  end

  def extract_key_phrases
    # Simple key phrase extraction
    # In a real implementation, you would use a proper NLP service
    
    all_content = conversation.messages.pluck(:content).join(' ')
    words = all_content.downcase.scan(/\b[a-z]{4,}\b/).tally
    
    # Filter out common words
    common_words = %w[this that with have from what when where there their they your would about should could which]
    
    words.delete_if { |word, _| common_words.include?(word) }
    
    # Return top 5 most frequent words as key phrases
    words.sort_by { |_, count| -count }.first(5).map { |word, _| word }
  end

  def determine_resolution_status
    # Determine if the conversation appears resolved based on content
    last_messages = conversation.messages.order(created_at: :desc).limit(3)
    
    # Check if conversation is formally resolved
    return 'resolved' if conversation.resolved?
    
    # Check for resolution indicators in the last few messages
    resolution_phrases = ['thank you', 'thanks', 'resolved', 'fixed', 'solved', 'works now', 'working now', 'great']
    
    last_messages.each do |message|
      content = message.content.to_s.downcase
      if message.incoming? && resolution_phrases.any? { |phrase| content.include?(phrase) }
        return 'likely_resolved'
      end
    end
    
    # Check for unresolved indicators
    unresolved_phrases = ['still not working', 'still broken', 'not fixed', 'same issue', 'same problem']
    
    last_messages.each do |message|
      content = message.content.to_s.downcase
      if message.incoming? && unresolved_phrases.any? { |phrase| content.include?(phrase) }
        return 'likely_unresolved'
      end
    end
    
    'unknown'
  end

  # === ENHANCED FREESTYLE FEATURES ===

  def analyze_issue_categories
    # Advanced issue categorization with priority detection
    content = conversation.messages.pluck(:content).join(' ').downcase
    
    issue_categories = {
      'urgent_bug' => {
        keywords: %w[urgent critical crash site_down server_down database_error emergency],
        priority: 'high',
        severity: 'critical'
      },
      'billing_dispute' => {
        keywords: %w[charge charged wrong_amount refund billing_error overcharged dispute],
        priority: 'medium',
        severity: 'high'
      },
      'security_concern' => {
        keywords: %w[hacked security breach unauthorized access suspicious activity],
        priority: 'high',
        severity: 'critical'
      },
      'integration_issue' => {
        keywords: %w[api integration webhook connection sync error 401 403 500],
        priority: 'medium',
        severity: 'medium'
      },
      'feature_request' => {
        keywords: %w[feature add new functionality enhancement improvement suggestion],
        priority: 'low',
        severity: 'low'
      },
      'onboarding_help' => {
        keywords: %w[setup getting_started tutorial guide first_time new_user],
        priority: 'medium',
        severity: 'low'
      }
    }
    
    detected_categories = []
    highest_priority = 'low'
    
    issue_categories.each do |category, data|
      if data[:keywords].any? { |keyword| content.include?(keyword.tr('_', ' ')) }
        detected_categories << {
          category: category,
          priority: data[:priority],
          severity: data[:severity]
        }
        
        # Track highest priority
        if priority_level(data[:priority]) > priority_level(highest_priority)
          highest_priority = data[:priority]
        end
      end
    end
    
    {
      categories: detected_categories,
      primary_category: detected_categories.first&.dig(:category) || 'general_inquiry',
      priority: highest_priority,
      category_count: detected_categories.size
    }
  end

  def analyze_customer_journey_stage
    # Analyze where the customer is in their journey
    content = conversation.messages.pluck(:content).join(' ').downcase
    
    journey_stages = {
      'awareness' => %w[heard about learning interested considering evaluation],
      'trial' => %w[trial testing trying demo free version signup],
      'onboarding' => %w[setup getting_started first_time new_account welcome],
      'active_user' => %w[using daily workflow feature love works great],
      'expansion' => %w[upgrade premium more_features additional team scale],
      'renewal' => %w[renew renewal subscription expire contract extend],
      'churn_risk' => %w[cancel canceling disappointed frustrated switching competitor],
      'support' => %w[help issue problem broken error fix troubleshoot]
    }
    
    stage_scores = {}
    journey_stages.each do |stage, keywords|
      score = keywords.count { |keyword| content.include?(keyword.tr('_', ' ')) }
      stage_scores[stage] = score if score > 0
    end
    
    primary_stage = stage_scores.max_by { |_, score| score }&.first || 'unknown'
    
    {
      primary_stage: primary_stage,
      stage_indicators: stage_scores,
      confidence_score: stage_scores.values.max || 0
    }
  end

  def detect_mentioned_products
    # Detect which products/features are being discussed
    content = conversation.messages.pluck(:content).join(' ').downcase
    
    # This would typically be customized per business
    product_features = {
      'dashboard' => %w[dashboard analytics reports metrics charts],
      'api' => %w[api rest graphql webhook integration developer],
      'mobile_app' => %w[mobile app ios android phone tablet],
      'billing' => %w[billing payment subscription invoice pricing],
      'team_features' => %w[team collaboration permissions roles sharing],
      'automation' => %w[automation workflow trigger action rule],
      'notifications' => %w[notification email sms push alert],
      'security' => %w[security authentication authorization sso two_factor]
    }
    
    mentioned_products = []
    product_features.each do |product, keywords|
      mentions = keywords.count { |keyword| content.include?(keyword.tr('_', ' ')) }
      if mentions > 0
        mentioned_products << {
          product: product,
          mention_count: mentions,
          relevance: (mentions.to_f / keywords.size).round(2)
        }
      end
    end
    
    mentioned_products.sort_by { |p| -p[:mention_count] }
  end

  def assess_escalation_risk
    # Assess the risk that this conversation needs escalation
    content = conversation.messages.pluck(:content).join(' ').downcase
    last_messages = conversation.messages.order(created_at: :desc).limit(3).pluck(:content).join(' ').downcase
    
    # High risk indicators
    high_risk_phrases = [
      'speak to manager', 'escalate', 'supervisor', 'complaint', 'legal action',
      'cancel subscription', 'terrible service', 'unacceptable', 'disappointed',
      'waste of time', 'useless', 'worst', 'horrible'
    ]
    
    # Medium risk indicators  
    medium_risk_phrases = [
      'not satisfied', 'frustrated', 'annoyed', 'third time', 'still not working',
      'same issue', 'not resolved', 'getting worse', 'urgent'
    ]
    
    # Positive indicators (lower risk)
    positive_phrases = [
      'thank you', 'helpful', 'great', 'resolved', 'working now', 'appreciate',
      'excellent', 'quick response'
    ]
    
    high_risk_score = high_risk_phrases.count { |phrase| content.include?(phrase) } * 3
    medium_risk_score = medium_risk_phrases.count { |phrase| content.include?(phrase) } * 2
    positive_score = positive_phrases.count { |phrase| last_messages.include?(phrase) }
    
    # Calculate response time impact
    response_times = calculate_response_times
    slow_response_penalty = if response_times[:average] && response_times[:average] > 3600 # 1 hour
                             2
                           elsif response_times[:average] && response_times[:average] > 1800 # 30 minutes
                             1
                           else
                             0
                           end
    
    total_risk_score = high_risk_score + medium_risk_score + slow_response_penalty - positive_score
    
    risk_level = if total_risk_score >= 5
                   'high'
                 elsif total_risk_score >= 2
                   'medium'
                 elsif total_risk_score <= -2
                   'low'
                 else
                   'normal'
                 end
    
    {
      risk_level: risk_level,
      risk_score: total_risk_score,
      high_risk_indicators: high_risk_score / 3,
      medium_risk_indicators: medium_risk_score / 2,
      positive_indicators: positive_score,
      slow_response_penalty: slow_response_penalty
    }
  end

  def calculate_agent_performance_indicators
    # Calculate performance indicators for the agent(s) involved
    agent_messages = conversation.messages.outgoing.includes(:sender)
    
    return {} if agent_messages.empty?
    
    # Response time analysis
    response_times = calculate_response_times
    
    # Message quality indicators
    total_agent_chars = agent_messages.sum { |m| m.content&.length || 0 }
    avg_message_length = total_agent_chars / agent_messages.count
    
    # Professional language detection
    professional_phrases = [
      'thank you for', 'i understand', 'let me help', 'i apologize',
      'please find', 'i will', 'happy to help', 'looking into'
    ]
    
    content = agent_messages.pluck(:content).join(' ').downcase
    professionalism_score = professional_phrases.count { |phrase| content.include?(phrase) }
    
    # Resolution effectiveness
    resolved_indicators = ['resolved', 'fixed', 'working', 'solved']
    resolution_attempts = resolved_indicators.count { |word| content.include?(word) }
    
    {
      total_responses: agent_messages.count,
      avg_response_time_seconds: response_times[:average],
      avg_message_length: avg_message_length,
      professionalism_score: professionalism_score,
      resolution_attempts: resolution_attempts,
      first_response_time: response_times[:min],
      agents_involved: agent_messages.map(&:sender).compact.uniq.map(&:name)
    }
  end

  def analyze_channel_effectiveness
    # Analyze how effective this channel/inbox is for this type of conversation
    inbox = conversation.inbox
    
    # Channel-specific metrics
    channel_type = inbox.channel_type
    
    # Calculate channel appropriateness based on conversation characteristics
    complexity_score = calculate_complexity
    message_count = conversation.messages.count
    
    # Some conversations are better suited for certain channels
    channel_fitness = case channel_type
                      when 'Channel::WebWidget'
                        complexity_score < 0.5 ? 'excellent' : 'good'
                      when 'Channel::Email'
                        complexity_score > 0.3 ? 'excellent' : 'good'
                      when 'Channel::TwitterProfile'
                        message_count < 5 ? 'good' : 'poor'
                      else
                        'good'
                      end
    
    {
      channel_type: channel_type,
      channel_fitness: channel_fitness,
      conversation_complexity: complexity_score,
      message_volume: message_count,
      channel_recommendation: recommend_alternative_channel(complexity_score, message_count)
    }
  end

  def assess_conversation_quality
    # Assess overall conversation quality
    messages = conversation.messages
    
    # Quality indicators
    back_and_forth = [messages.incoming.count, messages.outgoing.count].min
    avg_response_time = calculate_response_times[:average] || 0
    sentiment = analyze_sentiment
    resolution_status = determine_resolution_status
    
    # Calculate quality score
    quality_components = {
      engagement: back_and_forth >= 3 ? 25 : (back_and_forth * 8),
      responsiveness: avg_response_time < 1800 ? 25 : (avg_response_time < 3600 ? 15 : 5),
      sentiment: sentiment_to_score(sentiment),
      resolution: resolution_to_score(resolution_status)
    }
    
    total_quality_score = quality_components.values.sum
    
    quality_level = if total_quality_score >= 80
                      'excellent'
                    elsif total_quality_score >= 60
                      'good'
                    elsif total_quality_score >= 40
                      'fair'
                    else
                      'needs_improvement'
                    end
    
    {
      overall_score: total_quality_score,
      quality_level: quality_level,
      components: quality_components,
      improvement_suggestions: generate_improvement_suggestions(quality_components)
    }
  end

  def calculate_business_impact_metrics
    # Calculate potential business impact of this conversation
    content = conversation.messages.pluck(:content).join(' ').downcase
    
    # Revenue impact indicators
    revenue_keywords = {
      'high_value' => %w[enterprise premium large_account big_client major_customer],
      'expansion' => %w[upgrade additional seats more_users scale_up expand],
      'retention' => %w[renew renewal contract_renewal stay_with subscribe_again],
      'churn_risk' => %w[cancel switch_to competitor disappointed leaving quit]
    }
    
    impact_indicators = {}
    revenue_keywords.each do |impact_type, keywords|
      score = keywords.count { |keyword| content.include?(keyword.tr('_', ' ')) }
      impact_indicators[impact_type] = score if score > 0
    end
    
    # Calculate estimated business impact
    business_impact_score = (impact_indicators['high_value'] || 0) * 10 +
                           (impact_indicators['expansion'] || 0) * 8 +
                           (impact_indicators['retention'] || 0) * 6 -
                           (impact_indicators['churn_risk'] || 0) * 12
    
    impact_level = if business_impact_score >= 20
                     'very_high'
                   elsif business_impact_score >= 10
                     'high'
                   elsif business_impact_score >= 0
                     'medium'
                   elsif business_impact_score >= -10
                     'low'
                   else
                     'negative'
                   end
    
    {
      impact_level: impact_level,
      impact_score: business_impact_score,
      impact_indicators: impact_indicators,
      estimated_value: estimate_conversation_value(impact_level, impact_indicators)
    }
  end

  private

  def priority_level(priority)
    case priority
    when 'high' then 3
    when 'medium' then 2
    when 'low' then 1
    else 0
    end
  end

  def recommend_alternative_channel(complexity, message_count)
    if complexity > 0.7 || message_count > 10
      'phone_call'
    elsif complexity > 0.5
      'email'
    elsif message_count < 3
      'web_widget'
    else
      'current_channel'
    end
  end

  def sentiment_to_score(sentiment)
    case sentiment
    when 'very_positive' then 25
    when 'positive' then 20
    when 'neutral' then 15
    when 'negative' then 5
    when 'very_negative' then 0
    else 10
    end
  end

  def resolution_to_score(resolution)
    case resolution
    when 'resolved' then 25
    when 'likely_resolved' then 20
    when 'unknown' then 10
    when 'likely_unresolved' then 5
    when 'unresolved' then 0
    else 10
    end
  end

  def generate_improvement_suggestions(quality_components)
    suggestions = []
    
    suggestions << 'Improve response time' if quality_components[:responsiveness] < 15
    suggestions << 'Increase customer engagement' if quality_components[:engagement] < 15
    suggestions << 'Focus on sentiment improvement' if quality_components[:sentiment] < 15
    suggestions << 'Work on resolution effectiveness' if quality_components[:resolution] < 15
    
    suggestions.any? ? suggestions : ['Maintain current quality standards']
  end

  def estimate_conversation_value(impact_level, indicators)
    base_values = {
      'very_high' => 5000,
      'high' => 2000,
      'medium' => 500,
      'low' => 100,
      'negative' => -1000
    }
    
    base_value = base_values[impact_level] || 0
    
    # Adjust based on specific indicators
    if indicators['expansion'] && indicators['expansion'] > 0
      base_value += indicators['expansion'] * 500
    end
    
    if indicators['churn_risk'] && indicators['churn_risk'] > 0
      base_value -= indicators['churn_risk'] * 1000
    end
    
    base_value
  end
end 