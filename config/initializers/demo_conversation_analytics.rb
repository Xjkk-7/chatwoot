# Demo Conversation Analytics Initializer
# This will create demo conversation data with analytics on app startup

Rails.application.config.after_initialize do
  # Only run in development/demo mode and if there are existing accounts
  if Rails.env.development? && Account.exists?
    begin
      # Load and run the demo conversation seeder
      load Rails.root.join('db/seeds/demo_conversation_analytics.rb')
      Rails.logger.info "Demo conversation analytics data initialized successfully"
    rescue => e
      Rails.logger.warn "Failed to initialize demo conversation analytics: #{e.message}"
    end
  end
end 