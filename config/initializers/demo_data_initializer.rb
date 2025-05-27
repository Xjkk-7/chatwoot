# Demo Data Initializer
# This initializer automatically creates demo conversation analytics data
# when the application starts in development mode or when DEMO_MODE is enabled

Rails.application.config.after_initialize do
  # Only run in development mode or when explicitly enabled
  if Rails.env.development? || ENV['DEMO_MODE'] == 'true'
    # Delay execution to ensure all models are loaded
    Rails.application.executor.wrap do
      begin
        # Check if we already have demo conversation analytics
        demo_conversation = Conversation.joins(:contact)
                                      .where(contacts: { email: 'demo.customer@example.com' })
                                      .first

        unless demo_conversation&.additional_attributes&.key?('message_count')
          Rails.logger.info "🔧 Creating demo conversation analytics data..."
          
          # Load and run the demo seeder
          require Rails.root.join('db/seeds/demo_conversation_analytics.rb')
          
          Rails.logger.info "✅ Demo conversation analytics data created successfully!"
        else
          Rails.logger.info "📊 Demo conversation analytics data already exists"
        end
      rescue => e
        Rails.logger.warn "⚠️  Could not create demo conversation analytics: #{e.message}"
        # Don't fail application startup if demo data creation fails
      end
    end
  end
end 