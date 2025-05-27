-- SQL Script to Enable All Enterprise Features in Chatwoot
-- This directly updates the database to enable AI Assistant, Analytics, and other premium features

-- Start transaction
BEGIN;

-- Enable all enterprise features for all accounts
-- The feature_flags column is a bitmask where each bit represents a feature
-- Setting all bits to enable maximum features

UPDATE accounts 
SET 
  feature_flags = 2147483647,  -- Maximum 32-bit positive integer (all bits set)
  custom_attributes = COALESCE(custom_attributes, '{}'::jsonb) || 
    '{
      "plan_name": "Enterprise",
      "subscription_status": "active", 
      "enterprise_enabled": true,
      "pricing_plan": "enterprise"
    }'::jsonb,
  limits = COALESCE(limits, '{}'::jsonb) || 
    '{
      "agents": 1000,
      "inboxes": 100,
      "automations": 1000,
      "campaigns": 1000
    }'::jsonb
WHERE id IS NOT NULL;

-- Create or update installation configs to enterprise
INSERT INTO installation_configs (name, value, locked, created_at, updated_at) 
VALUES 
  ('INSTALLATION_PRICING_PLAN', 'enterprise', true, NOW(), NOW()),
  ('INSTALLATION_PRICING_PLAN_QUANTITY', '100', true, NOW(), NOW()),
  ('CHATWOOT_ENTERPRISE_ENABLED', 'true', true, NOW(), NOW()),
  ('CAPTAIN_OPEN_AI_API_KEY', '', false, NOW(), NOW()),
  ('CAPTAIN_OPEN_AI_MODEL', 'gpt-3.5-turbo', false, NOW(), NOW())
ON CONFLICT (name) DO UPDATE SET
  value = EXCLUDED.value,
  updated_at = NOW();

-- Enable specific features in enabled_features JSONB column if it exists
-- This ensures features like captain_integration, sla, audit_logs are enabled
UPDATE accounts 
SET enabled_features = COALESCE(enabled_features, '{}'::jsonb) || 
  '{
    "captain_integration": true,
    "audit_logs": true,
    "sla": true,
    "custom_roles": true,
    "disable_branding": true,
    "help_center": true,
    "campaigns": true,
    "team_management": true,
    "reports": true,
    "automations": true,
    "macros": true,
    "integrations": true,
    "voice_recorder": true,
    "crm": true,
    "inbox_management": true,
    "labels": true,
    "custom_attributes": true,
    "canned_responses": true,
    "agent_bots": true,
    "inbound_emails": true,
    "channel_email": true,
    "channel_facebook": true,
    "channel_twitter": true,
    "channel_website": true,
    "linear_integration": true,
    "shopify_integration": true,
    "crm_integration": true,
    "channel_instagram": true
  }'::jsonb
WHERE id IS NOT NULL;

-- Verify the changes
SELECT 
  id,
  name,
  feature_flags,
  custom_attributes->'plan_name' as plan_name,
  custom_attributes->'enterprise_enabled' as enterprise_enabled,
  jsonb_object_keys(enabled_features) as enabled_feature_keys
FROM accounts;

-- Show installation configs
SELECT name, value FROM installation_configs 
WHERE name IN ('INSTALLATION_PRICING_PLAN', 'CHATWOOT_ENTERPRISE_ENABLED');

-- Commit the transaction
COMMIT;

-- Success message
SELECT 'SUCCESS: All enterprise features have been enabled!' as status; 