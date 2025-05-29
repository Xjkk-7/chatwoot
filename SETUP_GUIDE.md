# 🚀 Complete Setup Guide: Enable Enhanced Chatwoot Features

This guide provides **step-by-step instructions** to enable all enhanced features after deploying this enhanced Chatwoot fork.

## 📋 What This Guide Enables

After following this guide, you'll have:
- ✅ **AI Assistant** (formerly "Captain") in the sidebar
- ✅ **Enhanced Conversation Analytics** with real-time insights
- ✅ **Enterprise Features** (SLA, Custom Roles, Audit Logs, etc.)
- ✅ **Strategic Rebranding** (Assistant → Topic, Captain → AI Assistant)
- ✅ **Business Intelligence Dashboard** in every conversation
- ✅ **Demo Data** for testing all features

---

## 🎯 Method 1: One-Command Setup (Recommended)

### **Step 1: Deploy the Application**
Use the one-click Heroku deploy:
```
https://heroku.com/deploy?template=https://github.com/Xjkk-7/chatwoot/tree/deployment/all-features
```

### **Step 2: Enable All Features**
After deployment completes, run this **single command**:

```bash
heroku run rails runner enable_enhanced_features.rb -a YOUR_APP_NAME
```

**Replace `YOUR_APP_NAME` with your actual Heroku app name**

### **Step 3: Restart and Verify**
```bash
# Restart the application
heroku restart -a YOUR_APP_NAME

# Open the application
heroku open -a YOUR_APP_NAME
```

### **Step 4: Verify Features Are Active**
1. **Hard refresh** your browser (Ctrl+F5 or Cmd+Shift+R)
2. **Check AI Assistant**: Look for "AI Assistant" in the left sidebar
3. **Check Analytics**: Open any conversation → See "Analytics & Insights" panel on the right
4. **Check Enterprise**: Go to Settings → You should see SLA, Custom Roles, Audit Logs

**🎉 That's it! All features should now be active.**

---

## 🔧 Method 2: Manual Setup (If Method 1 Fails)

### **Step 1: Access Rails Console**
```bash
heroku run rails console -a YOUR_APP_NAME
```

### **Step 2: Enable Enterprise Configuration**
```ruby
# Set enterprise configuration
InstallationConfig.find_or_create_by(name: 'INSTALLATION_PRICING_PLAN') do |config|
  config.value = 'enterprise'
  config.locked = true
end.update!(value: 'enterprise')

InstallationConfig.find_or_create_by(name: 'CHATWOOT_ENTERPRISE_ENABLED') do |config|
  config.value = 'true'
  config.locked = true
end.update!(value: 'true')

puts "✅ Enterprise configuration enabled"
```

### **Step 3: Enable Features for All Accounts**
```ruby
# Enable all enhanced features for every account
Account.find_each do |account|
  puts "Processing account: #{account.name}"
  
  # Enable comprehensive feature set
  enhanced_features = [
    'chatwoot_v4',           # New sidebar UI
    'captain_integration',   # AI Assistant
    'audit_logs',           # Enterprise audit logs
    'sla',                  # Service Level Agreements
    'custom_roles',         # Custom role management
    'disable_branding',     # Custom branding
    'help_center',          # Help center features
    'campaigns',            # Campaign management
    'team_management',      # Team features
    'reports',              # Advanced reports
    'automations',          # Automation features
    'macros',               # Macro support
    'integrations',         # Third-party integrations
    'inbox_management',     # Inbox management
    'labels',               # Label management
    'custom_attributes',    # Custom attributes
    'canned_responses',     # Canned responses
    'agent_management',     # Agent management
    'agent_bots'            # Bot integration
  ]
  
  account.enable_features!(*enhanced_features)
  
  # Update account for enterprise features
  account.update!(
    custom_attributes: account.custom_attributes.merge({
      'plan_name' => 'Enterprise',
      'subscription_status' => 'active',
      'enterprise_enabled' => true,
      'enhanced_analytics_enabled' => true,
      'ai_features_enabled' => true
    })
  )
  
  puts "✅ Features enabled for #{account.name}"
end
```

### **Step 4: Clear Caches**
```ruby
# Clear all system caches
Rails.cache.clear
GlobalConfig.clear_cache

puts "✅ Caches cleared"
```

### **Step 5: Exit Console and Restart**
```ruby
exit
```

```bash
heroku restart -a YOUR_APP_NAME
```

---

## 🧪 Method 3: Quick Environment Variable Setup

If both methods above fail, you can enable basic functionality using environment variables:

### **Step 1: Set Heroku Config Variables**
```bash
heroku config:set INSTALLATION_PRICING_PLAN=enterprise -a YOUR_APP_NAME
heroku config:set CHATWOOT_ENTERPRISE_ENABLED=true -a YOUR_APP_NAME
```

### **Step 2: Restart Application**
```bash
heroku restart -a YOUR_APP_NAME
```

**Note:** This method enables enterprise features but may not activate all analytics features.

---

## ✅ Verification Checklist

After running any of the methods above, verify these features are working:

### **🤖 AI Assistant (Sidebar)**
- [ ] "AI Assistant" appears in left sidebar navigation
- [ ] Clicking it shows AI assistant interface
- [ ] No longer shows "Captain" anywhere

### **📊 Enhanced Analytics (Conversation View)**
- [ ] Open any conversation
- [ ] "Analytics & Insights" panel appears in right sidebar
- [ ] Shows sentiment analysis, business impact, risk assessment
- [ ] Analytics update when you reply to conversations

### **🏢 Enterprise Features (Settings)**
- [ ] Go to Settings → Account Settings
- [ ] "SLA" option appears in settings menu
- [ ] "Custom Roles" option appears
- [ ] "Audit Logs" option appears
- [ ] "Reports" shows enhanced analytics

### **🎨 Rebranding Changes**
- [ ] "Assistant" changed to "Topic" in conversation categories
- [ ] "Captain" changed to "AI Assistant" throughout the app
- [ ] Custom logo appears (if configured)

---

## 🐛 Troubleshooting

### **Problem: AI Assistant Not Showing**
```bash
# Check if feature is enabled
heroku run rails runner "puts Account.first.enabled_features['captain_integration']" -a YOUR_APP_NAME
```
**Expected output:** `true`

**Solution if false:**
```bash
heroku run rails runner "Account.first.enable_features!('captain_integration')" -a YOUR_APP_NAME
```

### **Problem: Analytics Panel Missing**
1. Hard refresh browser (Ctrl+F5)
2. Check if you're in a conversation (not inbox list)
3. Look for "Analytics & Insights" in right sidebar

### **Problem: Enterprise Features Locked**
```bash
# Check enterprise configuration
heroku run rails runner "puts InstallationConfig.find_by(name: 'INSTALLATION_PRICING_PLAN')&.value" -a YOUR_APP_NAME
```
**Expected output:** `enterprise`

**Solution if different:**
```bash
heroku run rails runner "InstallationConfig.find_or_create_by(name: 'INSTALLATION_PRICING_PLAN').update!(value: 'enterprise')" -a YOUR_APP_NAME
```

### **Problem: Changes Not Appearing**
1. **Hard refresh** browser (Ctrl+F5 or Cmd+Shift+R)
2. **Clear browser cache** completely
3. **Try incognito/private browsing** mode
4. **Restart Heroku app**: `heroku restart -a YOUR_APP_NAME`

---

## 🎯 Testing Your Setup

### **1. Create Test Conversations**
```bash
heroku run rails runner test_analytics.rb -a YOUR_APP_NAME
```
This creates demo conversations with analytics data.

### **2. Manual Testing**
1. **Go to "All Conversations"**
2. **Click any conversation**
3. **Verify analytics panel** shows:
   - Sentiment score (-5 to +5)
   - Business impact (High/Medium/Low)
   - Risk assessment
   - Quality scoring
4. **Reply to the conversation**
5. **Watch analytics update** in real-time

### **3. Feature Testing**
- **AI Assistant**: Click "AI Assistant" in sidebar
- **Settings**: Check for SLA, Custom Roles, Audit Logs
- **Reports**: Verify enhanced analytics in reports section

---

## 📈 What Each Feature Does

### **🔍 Enhanced Conversation Analytics**
- **Sentiment Analysis**: Automatically detects positive/negative/neutral conversations
- **Business Impact Scoring**: Identifies high-value customer interactions (0-100%)
- **Escalation Risk**: Predicts conversations likely to escalate (-5 to +5 scale)
- **Quality Metrics**: Measures conversation quality and agent performance
- **Real-time Updates**: Analytics refresh automatically when agents reply

### **🤖 AI Assistant Integration**
- **Smart Suggestions**: Provides response recommendations
- **Conversation Insights**: Offers real-time analysis and recommendations
- **Workflow Automation**: Helps agents handle conversations more efficiently

### **🏢 Enterprise Features**
- **SLA Management**: Set and track service level agreements
- **Custom Roles**: Define granular permissions for team members
- **Audit Logs**: Track all system activities for compliance
- **Advanced Reports**: Comprehensive analytics and performance metrics

---

## 🎉 Success!

If you can verify all items in the checklist above, congratulations! You now have a fully enhanced Chatwoot instance with:

- **AI-powered conversation analytics**
- **Business intelligence insights**
- **Enterprise-grade features**
- **Strategic rebranding for better UX**
- **Real-time performance monitoring**

Your customer support team now has access to advanced tools that will help them:
- Identify high-priority conversations automatically
- Prevent escalations before they happen
- Measure and improve service quality
- Make data-driven decisions about customer service

---

## 📞 Support

If you encounter any issues:

1. **Check the troubleshooting section** above
2. **Review the logs**: `heroku logs --tail -a YOUR_APP_NAME`
3. **Verify environment**: All scripts are designed to be safe and can be run multiple times
4. **Documentation**: See `ENHANCED_FEATURES.md` for technical implementation details

**Remember**: All setup scripts are idempotent - you can run them multiple times safely if something doesn't work the first time. 