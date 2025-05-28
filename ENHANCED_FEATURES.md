# Enhanced Conversation Analytics Features

## 🚀 Overview

This Chatwoot deployment includes **advanced conversation analytics and AI-powered insights** that provide real-time analysis of customer conversations, helping support teams deliver better service and identify business opportunities.

## ✨ Enhanced Features Added

### 1. **Intelligent Conversation Analysis**
- **Real-time sentiment analysis** (positive, negative, neutral)
- **Automatic issue categorization** (billing, technical, feature requests, etc.)
- **Smart topic detection** and keyword extraction
- **Language detection** and complexity scoring

### 2. **Business Intelligence Dashboard**
- **Business Impact Scoring** - Identifies high-value customer interactions
- **Escalation Risk Assessment** - Predicts conversations that may escalate
- **Conversation Quality Metrics** - Measures support team performance
- **Customer Journey Mapping** - Tracks customer lifecycle stages

### 3. **Advanced Analytics Panels**
Located in the conversation sidebar under **"Analytics & Insights"**:

#### **Message Analytics**
- Total message count (user vs agent)
- Response time metrics (average, min, max)
- Engagement scoring and duration tracking

#### **Issue Analysis**
- Primary category identification
- Priority level assessment (high, medium, low)
- Multiple category detection
- Severity scoring

#### **Customer Journey Intelligence**
- Lifecycle stage detection (new, active, retention, etc.)
- Stage confidence scoring
- Journey progression indicators

#### **Business Impact Assessment**
- Impact level scoring (high, medium, low)
- Estimated customer value
- Revenue impact indicators
- Retention risk analysis

#### **Escalation Risk Monitoring**
- Risk level assessment (low, medium, high)
- Risk score calculation (-5 to +5 scale)
- Positive/negative indicator tracking
- Proactive escalation prevention

#### **Conversation Quality Scoring**
- Overall quality percentage (0-100%)
- Component breakdown (engagement, responsiveness, sentiment, resolution)
- Quality level classification (excellent, good, needs improvement)
- Performance improvement suggestions

#### **Agent Performance Metrics**
- Response time analysis
- Message quality assessment
- Professionalism scoring
- Resolution effectiveness tracking

### 4. **Smart Content Attributes**
- **Automatic tagging** based on conversation content
- **Dynamic categorization** that updates in real-time
- **Context-aware labeling** for better organization
- **Custom attribute generation** based on conversation patterns

## 🛠 Technical Implementation

### **Backend Components**

#### **Content Attributes Service**
```ruby
app/services/conversations/content_attributes_service.rb
```
- Core analytics engine
- Real-time conversation analysis
- Machine learning-based categorization
- Business intelligence calculations

#### **Analytics Controller**
```ruby
app/controllers/api/v1/accounts/conversations/analytics_controller.rb
```
- RESTful API endpoints for analytics data
- Real-time updates and refresh capabilities
- Secure data access and permissions

#### **Database Integration**
- Enhanced conversation model with analytics storage
- Migration for demo data creation
- Additional attributes for extended metadata

### **Frontend Components**

#### **Analytics Panel Component**
```vue
app/javascript/dashboard/components/widgets/conversation/ContentAttributesPanel.vue
```
- Vue.js component for analytics display
- Real-time data visualization
- Interactive insights and metrics
- Responsive design for all screen sizes

#### **Enhanced UI Integration**
- Seamless integration into existing conversation sidebar
- Consistent design language with Chatwoot's UI
- Progressive enhancement without breaking existing functionality

### **API Endpoints**

#### **Analytics API**
```
GET /api/v1/accounts/{id}/conversations/{id}/analytics
PUT /api/v1/accounts/{id}/conversations/{id}/analytics/refresh
```
- Retrieve conversation analytics data
- Refresh and recalculate analytics
- Real-time updates via WebSocket integration

### **Configuration Files**

#### **Routes**
```ruby
config/routes.rb
```
- Analytics API route definitions
- RESTful endpoint configuration

#### **Translations**
```json
app/javascript/dashboard/i18n/locale/en/conversation.json
```
- Internationalization support for analytics labels
- Multi-language compatibility

## 🚢 Deployment Guide

### **Prerequisites**
- Heroku account with billing enabled
- GitHub repository access
- Basic knowledge of Rails and Vue.js

### **Memory Optimization for Heroku**

The deployment includes several memory optimizations to ensure successful builds on Heroku:

#### **Package.json Optimizations**
```json
{
  "precompile": "NODE_OPTIONS='--max-old-space-size=4096' npx vite build",
  "heroku-postbuild": "pnpm install --production=false && pnpm precompile && BUILD_MODE=library pnpm build:sdk"
}
```

#### **Vite Configuration Optimizations**
```javascript
// vite.config.ts
build: {
  chunkSizeWarningLimit: 1000,
  minify: 'terser',
  rollupOptions: {
    maxParallelFileOps: 2,
    manualChunks: {
      vendor: ['vue', 'vue-router', 'vuex'],
      ui: ['@vueuse/core', '@vueuse/components'],
      charts: ['chart.js', 'vue-chartjs'],
    }
  }
}
```

#### **Heroku Configuration**
```json
// app.json
{
  "formation": {
    "web": { "size": "standard-1x" },
    "worker": { "size": "standard-1x" }
  },
  "env": {
    "NODE_OPTIONS": {
      "value": "--max-old-space-size=4096"
    }
  }
}
```

### **Deployment Steps**

#### **1. One-Click Heroku Deploy**
```
https://heroku.com/deploy?template=https://github.com/Xjkk-7/chatwoot/tree/deployment/all-features
```

#### **2. Environment Configuration**
- Set `FRONTEND_URL` to your Heroku app URL
- Configure Redis and PostgreSQL add-ons
- Set up necessary environment variables

#### **3. Database Setup**
```bash
heroku run rails db:migrate -a your-app-name
heroku run rails db:seed -a your-app-name
```

#### **4. Create Demo Data (Optional)**
```bash
heroku run rails console -a your-app-name
# Run the demo conversation creation commands
```

### **Post-Deployment Verification**

1. **Access your deployed app**
2. **Create a test conversation** (via widget or console)
3. **Navigate to conversation view**
4. **Verify "Analytics & Insights" panel appears**
5. **Test real-time updates by replying to messages**

## 📊 Usage Guide

### **Viewing Analytics**
1. Navigate to **"All Conversations"**
2. Click on any conversation
3. Look for **"Analytics & Insights"** in the right sidebar
4. Expand sections to view detailed metrics

### **Understanding Metrics**

#### **Risk Levels**
- 🟢 **Low Risk** (-5 to -1): Satisfied customers, low escalation chance
- 🟡 **Medium Risk** (0 to 2): Neutral conversations, monitor closely  
- 🔴 **High Risk** (3 to 5): Potential escalations, immediate attention needed

#### **Business Impact**
- 💎 **High Impact**: Enterprise customers, high-value accounts
- 📈 **Medium Impact**: Growth customers, expansion opportunities
- 📋 **Low Impact**: Standard support, routine inquiries

#### **Quality Scores**
- 🌟 **Excellent** (90-100%): Outstanding service delivery
- ✅ **Good** (70-89%): Solid performance, minor improvements possible
- ⚠️ **Needs Improvement** (<70%): Requires attention and training

### **Creating Test Data**

To test all features, create diverse conversation types:

```ruby
# Technical Support Conversation
conversation.update!(additional_attributes: {
  sentiment: 'neutral',
  issue_analysis: { primary_category: 'integration_issue' },
  business_impact: { impact_level: 'high' },
  escalation_risk: { risk_level: 'medium' }
})

# Billing Dispute Conversation  
conversation.update!(additional_attributes: {
  sentiment: 'negative',
  issue_analysis: { primary_category: 'billing_dispute' },
  business_impact: { impact_level: 'high' },
  escalation_risk: { risk_level: 'high' }
})

# Feature Request Conversation
conversation.update!(additional_attributes: {
  sentiment: 'positive', 
  issue_analysis: { primary_category: 'feature_request' },
  business_impact: { impact_level: 'medium' },
  escalation_risk: { risk_level: 'low' }
})
```

## 🔧 Troubleshooting

### **Common Issues**

#### **Analytics Not Appearing**
- Verify conversation has messages
- Check if analytics data exists in `additional_attributes`
- Refresh browser and clear cache

#### **SDK Not Loading**
- Ensure SDK build completed during deployment
- Check `/packs/js/sdk.js` endpoint accessibility
- Verify build process included SDK compilation

#### **Memory Issues During Build**
- Confirm `NODE_OPTIONS` environment variable is set
- Verify dyno sizes are `standard-1x` or higher
- Check build logs for memory-related errors

### **Debug Commands**

```bash
# Check analytics data
heroku run rails console -a your-app-name
conversation = Conversation.first
puts conversation.additional_attributes

# Rebuild assets
heroku run rails assets:precompile -a your-app-name

# Check logs
heroku logs --tail -a your-app-name
```

## 🎯 Future Enhancements

### **Planned Features**
- Machine learning model training on conversation data
- Predictive analytics for customer churn
- Advanced reporting dashboard
- Integration with external analytics tools
- A/B testing capabilities for support strategies

### **Performance Optimizations**
- Background job processing for analytics
- Caching layer for frequently accessed metrics
- Database indexing optimizations
- Real-time WebSocket updates

## 🤝 Contributing

To contribute to the enhanced features:

1. Fork the repository
2. Create a feature branch
3. Implement changes with tests
4. Submit a pull request
5. Ensure all analytics features remain functional

## 📝 License

This enhanced version maintains the same license as the original Chatwoot project.

---

## 🎉 Success!

You now have a fully-featured Chatwoot deployment with advanced conversation analytics, providing unprecedented insights into customer interactions and support team performance!

For questions or support, refer to the original Chatwoot documentation or create an issue in this repository. 