# 🚀 Enable Enterprise Features & Conversation Analytics

## Overview
This guide will enable **ALL enterprise features** including:
- ✨ **AI Assistant (Captain)** - Chat copilot in conversation sidebar
- 🔍 **Conversation Analytics** - Advanced insights and business intelligence
- 📊 **Enterprise Dashboard** - Premium reporting and analytics
- 🛡️ **Audit Logs** - Track all system activities
- 👥 **Custom Roles** - Advanced permission management
- 🎯 **SLA Management** - Service level agreements
- 🎨 **Disable Branding** - Remove Chatwoot branding

## 🎯 Step-by-Step Instructions

### Option 1: Direct Database Update (Recommended)

**If you have PostgreSQL access:**

1. **Connect to your PostgreSQL database**
   ```bash
   # If using Docker:
   docker exec -it chatwoot_postgres psql -U postgres -d chatwoot_production
   
   # If using Heroku:
   heroku pg:psql -a your-app-name
   
   # If using local PostgreSQL:
   psql -U postgres -d chatwoot_production
   ```

2. **Run the enterprise features script**
   ```sql
   \i enable_features.sql
   ```

3. **Add conversation analytics data**
   ```sql
   \i add_conversation_analytics.sql
   ```

4. **Exit PostgreSQL**
   ```sql
   \q
   ```

### Option 2: Copy-Paste SQL Commands

**If file execution doesn't work, copy and paste these commands:**

```sql
-- Enable Enterprise Features
BEGIN;

UPDATE accounts 
SET 
  feature_flags = 2147483647,
  custom_attributes = COALESCE(custom_attributes, '{}'::jsonb) || 
    '{"plan_name": "Enterprise", "subscription_status": "active", "enterprise_enabled": true}'::jsonb,
  enabled_features = COALESCE(enabled_features, '{}'::jsonb) || 
    '{"captain_integration": true, "audit_logs": true, "sla": true, "custom_roles": true}'::jsonb
WHERE id IS NOT NULL;

INSERT INTO installation_configs (name, value, locked, created_at, updated_at) 
VALUES 
  ('INSTALLATION_PRICING_PLAN', 'enterprise', true, NOW(), NOW()),
  ('CHATWOOT_ENTERPRISE_ENABLED', 'true', true, NOW(), NOW())
ON CONFLICT (name) DO UPDATE SET value = EXCLUDED.value, updated_at = NOW();

COMMIT;
```

### Option 3: Environment Variable Override

**Add to your environment variables:**

```bash
# Add to .env file or environment
INSTALLATION_PRICING_PLAN=enterprise
CHATWOOT_ENTERPRISE_ENABLED=true
CAPTAIN_OPEN_AI_API_KEY=your_openai_key_here
CAPTAIN_OPEN_AI_MODEL=gpt-3.5-turbo
```

## 🔄 After Running the Scripts

### 1. Restart Your Application
```bash
# If using Docker:
docker-compose restart

# If using Heroku:
heroku restart -a your-app-name

# If using local Rails server:
bundle exec rails server
```

### 2. Clear Browser Cache
- Hard refresh: `Ctrl+F5` (Windows) or `Cmd+Shift+R` (Mac)
- Or open in incognito/private window

### 3. Verify Features Are Enabled

**Check for these UI elements:**

1. **AI Assistant Tab** 📱
   - Open any conversation
   - Look for "AI Assistant" or "Copilot" tab in the sidebar
   - Should be next to "Contact" tab

2. **Analytics & Insights Panel** 🔍
   - In conversation sidebar, look for "🔍 Analytics & Insights" section
   - Should show issue categories, business impact, quality scores

3. **Analytics Badges** 📊
   - In conversation list, look for colored badges showing:
     - Issue types (🐛 Bug, 💰 Billing, etc.)
     - Business impact (⭐ High Value)
     - Quality scores (📈 88%)

4. **Enterprise Menu Items** ⚙️
   - Settings → Custom Roles
   - Settings → SLA
   - Settings → Audit Logs

## 🎨 What You Should See

### Conversation List
```
┌─────────────────────────────────────────┐
│ Customer Name                           │
│ Last message preview...                 │
│ 🔗 Integration • ⭐ High Value • 📈 88% │
└─────────────────────────────────────────┘
```

### Conversation Sidebar
```
┌─ Contact ─┬─ AI Assistant ─┐
│                            │
│ 🔍 Analytics & Insights    │
│ ┌────────────────────────┐ │
│ │ 🐛 Integration Issue   │ │
│ │ ⭐ High Business Value │ │
│ │ 📈 88% Quality Score   │ │
│ │ 🚨 Medium Risk         │ │
│ └────────────────────────┘ │
│                            │
│ 💼 Business Intelligence   │
│ • $2,500 estimated value   │
│ • Enterprise customer      │
│ • Active user stage        │
└────────────────────────────┘
```

### AI Assistant Chat
```
┌─────────────────────────────┐
│ 🤖 AI Assistant             │
│                             │
│ How can I help with this    │
│ conversation?               │
│                             │
│ ┌─────────────────────────┐ │
│ │ Type your message...    │ │
│ └─────────────────────────┘ │
└─────────────────────────────┘
```

## 🛠️ Troubleshooting

### AI Assistant Not Showing
1. **Check feature flag:**
   ```sql
   SELECT enabled_features->'captain_integration' FROM accounts;
   ```
   Should return `true`

2. **Verify installation config:**
   ```sql
   SELECT * FROM installation_configs WHERE name = 'INSTALLATION_PRICING_PLAN';
   ```
   Should return `enterprise`

### Analytics Not Showing
1. **Check conversation data:**
   ```sql
   SELECT additional_attributes->'content_attributes' FROM conversations LIMIT 1;
   ```
   Should return JSON with analytics data

2. **Check UI settings:**
   ```sql
   SELECT ui_settings FROM users WHERE id = 1;
   ```

### General Issues
1. **Clear browser cache completely**
2. **Check browser console for JavaScript errors**
3. **Verify database connection**
4. **Restart application server**

## 🎉 Success Indicators

✅ **You're successful when you see:**
- AI Assistant tab in conversation sidebar
- Analytics & Insights panel with detailed metrics  
- Colored badges in conversation list
- Enterprise menu items in Settings
- Quality scores and business impact data

## 📞 Next Steps

1. **Configure AI Assistant:**
   - Add OpenAI API key for full AI functionality
   - Create custom assistants for different topics

2. **Explore Analytics:**
   - Review conversation quality scores
   - Monitor business impact metrics
   - Use escalation risk indicators

3. **Set up Enterprise Features:**
   - Configure custom roles
   - Set up SLA policies
   - Review audit logs

## 🔧 Advanced Configuration

### OpenAI Integration (Optional)
```bash
CAPTAIN_OPEN_AI_API_KEY=sk-your-openai-key-here
CAPTAIN_OPEN_AI_MODEL=gpt-4
```

### Custom Branding
```bash
INSTALLATION_NAME="Your Company Support"
BRAND_NAME="Your Company"
DISABLE_BRANDING=true
```

---

**🎯 The goal is to transform your community Chatwoot into a full enterprise platform with AI Assistant and advanced conversation analytics!** 