-- SQL Script to Add Conversation Analytics Data
-- This adds contentAttributes with analytics to existing conversations

-- Start transaction
BEGIN;

-- Create sample conversation analytics data for existing conversations
UPDATE conversations 
SET additional_attributes = COALESCE(additional_attributes, '{}'::jsonb) || 
  '{
    "content_attributes": {
      "message_count": 8,
      "response_time_stats": {
        "average_response_time": 285,
        "first_response_time": 120,
        "total_conversation_time": 1800
      },
      "sentiment_analysis": {
        "overall_sentiment": "neutral",
        "sentiment_score": 0.1,
        "confidence": 0.8
      },
      "topics_extracted": ["api", "integration", "timeout", "ecommerce"],
      "language_detected": {
        "primary_language": "en",
        "confidence": 0.95
      },
      "complexity_score": 7,
      "engagement_metrics": {
        "customer_engagement": "high",
        "agent_engagement": "high",
        "interaction_quality": "good"
      },
      "conversation_summary": "Customer experiencing API integration timeout errors affecting e-commerce operations. Agent provided troubleshooting assistance.",
      "key_phrases": ["API integration", "timeout errors", "e-commerce platform", "troubleshooting"],
      "resolution_status": {
        "is_resolved": false,
        "resolution_time": null,
        "resolution_confidence": 0.3
      },
      "issue_analysis": {
        "primary_category": "integration_issue",
        "secondary_categories": ["urgent_bug", "technical_support"],
        "priority": "high",
        "severity_score": 8,
        "business_impact": "high",
        "customer_type": "enterprise",
        "issue_complexity": "medium"
      },
      "customer_journey": {
        "primary_stage": "active_user",
        "secondary_stages": ["expansion", "support"],
        "confidence_score": 3,
        "journey_progression": "stable",
        "churn_risk": "low",
        "engagement_level": "high"
      },
      "product_detection": {
        "mentioned_products": [
          {"product": "api", "relevance_score": 4, "context": "integration"},
          {"product": "dashboard", "relevance_score": 2, "context": "platform"}
        ],
        "primary_product": "api",
        "product_satisfaction": "needs_improvement",
        "feature_requests": ["better timeout handling", "improved error messages"]
      },
      "escalation_risk": {
        "risk_level": "medium",
        "risk_score": 2,
        "risk_factors": ["technical complexity", "business impact"],
        "positive_indicators": ["collaborative customer", "clear communication"],
        "recommended_action": "continue current approach"
      },
      "agent_performance": {
        "response_quality": "good",
        "professionalism_score": 4,
        "technical_accuracy": "high",
        "empathy_score": 3,
        "resolution_attempts": 2,
        "follow_up_needed": true,
        "message_length_avg": 85,
        "agents_involved": 1
      },
      "channel_effectiveness": {
        "channel_fitness": "good",
        "channel_recommendation": "email",
        "response_efficiency": "medium",
        "customer_preference_match": "high"
      },
      "conversation_quality": {
        "overall_score": 88,
        "quality_level": "excellent",
        "components": {
          "engagement": 85,
          "responsiveness": 90,
          "sentiment": 88,
          "resolution": 87
        },
        "improvement_suggestions": [
          "Provide more specific timeline estimates",
          "Include documentation links for self-service"
        ],
        "strengths": ["Clear communication", "Professional tone", "Technical accuracy"]
      },
      "business_impact": {
        "impact_level": "high",
        "estimated_value": 2500,
        "revenue_indicators": ["enterprise_customer", "integration_blocking"],
        "business_priority": "urgent",
        "potential_upsell": true,
        "retention_risk": "low"
      }
    }
  }'::jsonb
WHERE id % 4 = 1; -- Update every 4th conversation with integration issue

-- Add different analytics for billing conversations
UPDATE conversations 
SET additional_attributes = COALESCE(additional_attributes, '{}'::jsonb) || 
  '{
    "content_attributes": {
      "message_count": 4,
      "response_time_stats": {
        "average_response_time": 180,
        "first_response_time": 90,
        "total_conversation_time": 600
      },
      "sentiment_analysis": {
        "overall_sentiment": "neutral",
        "sentiment_score": -0.2,
        "confidence": 0.7
      },
      "topics_extracted": ["billing", "subscription", "charges"],
      "language_detected": {
        "primary_language": "en",
        "confidence": 0.92
      },
      "complexity_score": 4,
      "engagement_metrics": {
        "customer_engagement": "medium",
        "agent_engagement": "high",
        "interaction_quality": "good"
      },
      "conversation_summary": "Customer inquiry about subscription billing charges. Quick resolution provided.",
      "key_phrases": ["billing question", "subscription charges", "account review"],
      "resolution_status": {
        "is_resolved": true,
        "resolution_time": 600,
        "resolution_confidence": 0.9
      },
      "issue_analysis": {
        "primary_category": "billing_dispute",
        "secondary_categories": ["account_management"],
        "priority": "medium",
        "severity_score": 4,
        "business_impact": "medium",
        "customer_type": "standard",
        "issue_complexity": "low"
      },
      "customer_journey": {
        "primary_stage": "active_user",
        "secondary_stages": ["renewal"],
        "confidence_score": 2,
        "journey_progression": "stable",
        "churn_risk": "low",
        "engagement_level": "medium"
      },
      "escalation_risk": {
        "risk_level": "low",
        "risk_score": -1,
        "risk_factors": [],
        "positive_indicators": ["quick resolution", "satisfied customer"],
        "recommended_action": "standard follow-up"
      },
      "conversation_quality": {
        "overall_score": 92,
        "quality_level": "excellent",
        "components": {
          "engagement": 88,
          "responsiveness": 95,
          "sentiment": 90,
          "resolution": 95
        }
      },
      "business_impact": {
        "impact_level": "low",
        "estimated_value": 500,
        "revenue_indicators": ["billing_inquiry"],
        "business_priority": "normal",
        "potential_upsell": false,
        "retention_risk": "none"
      }
    }
  }'::jsonb
WHERE id % 4 = 2; -- Update every 4th conversation (offset by 2) with billing issue

-- Add analytics for onboarding conversations
UPDATE conversations 
SET additional_attributes = COALESCE(additional_attributes, '{}'::jsonb) || 
  '{
    "content_attributes": {
      "message_count": 6,
      "response_time_stats": {
        "average_response_time": 240,
        "first_response_time": 150,
        "total_conversation_time": 1200
      },
      "sentiment_analysis": {
        "overall_sentiment": "positive",
        "sentiment_score": 0.4,
        "confidence": 0.85
      },
      "topics_extracted": ["setup", "automation", "configuration"],
      "language_detected": {
        "primary_language": "en",
        "confidence": 0.96
      },
      "complexity_score": 5,
      "issue_analysis": {
        "primary_category": "onboarding_help",
        "secondary_categories": ["feature_request"],
        "priority": "medium",
        "severity_score": 3,
        "business_impact": "medium",
        "customer_type": "new",
        "issue_complexity": "medium"
      },
      "customer_journey": {
        "primary_stage": "onboarding",
        "secondary_stages": ["trial", "activation"],
        "confidence_score": 4,
        "journey_progression": "positive",
        "churn_risk": "low",
        "engagement_level": "high"
      },
      "conversation_quality": {
        "overall_score": 85,
        "quality_level": "good",
        "components": {
          "engagement": 90,
          "responsiveness": 85,
          "sentiment": 88,
          "resolution": 78
        }
      },
      "business_impact": {
        "impact_level": "medium",
        "estimated_value": 1200,
        "revenue_indicators": ["new_customer", "onboarding"],
        "business_priority": "normal",
        "potential_upsell": true,
        "retention_risk": "low"
      }
    }
  }'::jsonb
WHERE id % 4 = 3; -- Update every 4th conversation (offset by 3) with onboarding

-- Add basic analytics for remaining conversations
UPDATE conversations 
SET additional_attributes = COALESCE(additional_attributes, '{}'::jsonb) || 
  '{
    "content_attributes": {
      "message_count": 3,
      "sentiment_analysis": {
        "overall_sentiment": "neutral",
        "sentiment_score": 0.0,
        "confidence": 0.6
      },
      "conversation_quality": {
        "overall_score": 75,
        "quality_level": "good"
      },
      "business_impact": {
        "impact_level": "low",
        "estimated_value": 300
      }
    }
  }'::jsonb
WHERE id % 4 = 0 AND (additional_attributes->'content_attributes') IS NULL;

-- Verify the changes
SELECT 
  id,
  status,
  inbox_id,
  additional_attributes->'content_attributes'->'issue_analysis'->>'primary_category' as issue_category,
  additional_attributes->'content_attributes'->'business_impact'->>'impact_level' as business_impact,
  additional_attributes->'content_attributes'->'conversation_quality'->>'overall_score' as quality_score,
  additional_attributes->'content_attributes'->'escalation_risk'->>'risk_level' as escalation_risk
FROM conversations 
WHERE (additional_attributes->'content_attributes') IS NOT NULL
LIMIT 10;

-- Count conversations with analytics
SELECT 
  COUNT(*) as total_conversations,
  COUNT(CASE WHEN (additional_attributes->'content_attributes') IS NOT NULL THEN 1 END) as conversations_with_analytics
FROM conversations;

-- Commit the transaction
COMMIT;

-- Success message
SELECT 'SUCCESS: Conversation analytics data has been added!' as status; 