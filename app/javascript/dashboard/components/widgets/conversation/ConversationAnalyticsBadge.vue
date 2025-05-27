<script setup>
import { computed } from 'vue';
import { useI18n } from 'vue-i18n';

const { t } = useI18n();

const props = defineProps({
  conversation: {
    type: Object,
    required: true
  }
});

const contentAttributes = computed(() => {
  return props.conversation.content_attributes || props.conversation.additional_attributes || {};
});

const messageCount = computed(() => contentAttributes.value?.message_count || null);
const sentiment = computed(() => contentAttributes.value?.sentiment || null);
const resolutionStatus = computed(() => contentAttributes.value?.resolution_status || null);
const topics = computed(() => contentAttributes.value?.topics || []);

// Enhanced freestyle features
const issueAnalysis = computed(() => contentAttributes.value?.issue_analysis || null);
const escalationRisk = computed(() => contentAttributes.value?.escalation_risk || null);
const businessImpact = computed(() => contentAttributes.value?.business_impact || null);
const conversationQuality = computed(() => contentAttributes.value?.conversation_quality || null);

const hasAnalytics = computed(() => {
  return messageCount.value || sentiment.value || resolutionStatus.value || topics.value.length > 0 || 
         issueAnalysis.value || escalationRisk.value || businessImpact.value;
});

const formatSentiment = (sentiment) => {
  if (!sentiment) return null;
  
  const sentimentMap = {
    very_positive: { label: 'Very Positive', color: 'bg-emerald-100 text-emerald-800 dark:bg-emerald-900/30 dark:text-emerald-400' },
    positive: { label: 'Positive', color: 'bg-green-100 text-green-800 dark:bg-green-900/30 dark:text-green-400' },
    neutral: { label: 'Neutral', color: 'bg-slate-100 text-slate-800 dark:bg-slate-900/30 dark:text-slate-400' },
    negative: { label: 'Negative', color: 'bg-orange-100 text-orange-800 dark:bg-orange-900/30 dark:text-orange-400' },
    very_negative: { label: 'Very Negative', color: 'bg-red-100 text-red-800 dark:bg-red-900/30 dark:text-red-400' }
  };
  
  return sentimentMap[sentiment] || { label: sentiment, color: 'bg-slate-100 text-slate-800 dark:bg-slate-900/30 dark:text-slate-400' };
};

const formatResolutionStatus = (status) => {
  if (!status) return null;
  
  const statusMap = {
    resolved: { label: '✓ Resolved', color: 'bg-emerald-100 text-emerald-800 dark:bg-emerald-900/30 dark:text-emerald-400' },
    likely_resolved: { label: '~ Likely Resolved', color: 'bg-green-100 text-green-800 dark:bg-green-900/30 dark:text-green-400' },
    unknown: { label: '? Unknown', color: 'bg-slate-100 text-slate-800 dark:bg-slate-900/30 dark:text-slate-400' },
    likely_unresolved: { label: '~ Likely Open', color: 'bg-orange-100 text-orange-800 dark:bg-orange-900/30 dark:text-orange-400' },
    unresolved: { label: '✗ Unresolved', color: 'bg-red-100 text-red-800 dark:bg-red-900/30 dark:text-red-400' }
  };
  
  return statusMap[status] || { label: status, color: 'bg-slate-100 text-slate-800 dark:bg-slate-900/30 dark:text-slate-400' };
};

const formatEscalationRisk = (risk) => {
  if (!risk || !risk.risk_level) return null;
  
  const riskMap = {
    high: { label: '🚨 High Risk', color: 'bg-red-100 text-red-800 dark:bg-red-900/30 dark:text-red-400' },
    medium: { label: '⚠️ Medium Risk', color: 'bg-orange-100 text-orange-800 dark:bg-orange-900/30 dark:text-orange-400' },
    normal: { label: '✓ Normal', color: 'bg-blue-100 text-blue-800 dark:bg-blue-900/30 dark:text-blue-400' },
    low: { label: '💚 Low Risk', color: 'bg-green-100 text-green-800 dark:bg-green-900/30 dark:text-green-400' }
  };
  
  return riskMap[risk.risk_level] || { label: 'Unknown', color: 'bg-slate-100 text-slate-800 dark:bg-slate-900/30 dark:text-slate-400' };
};

const formatBusinessImpact = (impact) => {
  if (!impact || !impact.impact_level) return null;
  
  const impactMap = {
    very_high: { label: '💎 Very High Value', color: 'bg-purple-100 text-purple-800 dark:bg-purple-900/30 dark:text-purple-400' },
    high: { label: '⭐ High Value', color: 'bg-indigo-100 text-indigo-800 dark:bg-indigo-900/30 dark:text-indigo-400' },
    medium: { label: '📈 Medium Value', color: 'bg-blue-100 text-blue-800 dark:bg-blue-900/30 dark:text-blue-400' },
    low: { label: '📊 Standard', color: 'bg-slate-100 text-slate-800 dark:bg-slate-900/30 dark:text-slate-400' },
    negative: { label: '📉 Risk', color: 'bg-red-100 text-red-800 dark:bg-red-900/30 dark:text-red-400' }
  };
  
  return impactMap[impact.impact_level] || { label: 'Unknown', color: 'bg-slate-100 text-slate-800 dark:bg-slate-900/30 dark:text-slate-400' };
};

const formatIssueCategory = (analysis) => {
  if (!analysis || !analysis.primary_category) return null;
  
  const categoryMap = {
    urgent_bug: { label: '🐛 Urgent Bug', color: 'bg-red-100 text-red-800 dark:bg-red-900/30 dark:text-red-400' },
    integration_issue: { label: '🔗 Integration', color: 'bg-blue-100 text-blue-800 dark:bg-blue-900/30 dark:text-blue-400' },
    billing_dispute: { label: '💳 Billing', color: 'bg-yellow-100 text-yellow-800 dark:bg-yellow-900/30 dark:text-yellow-400' },
    security_concern: { label: '🔒 Security', color: 'bg-red-100 text-red-800 dark:bg-red-900/30 dark:text-red-400' },
    feature_request: { label: '✨ Feature Request', color: 'bg-green-100 text-green-800 dark:bg-green-900/30 dark:text-green-400' },
    onboarding_help: { label: '🚀 Onboarding', color: 'bg-indigo-100 text-indigo-800 dark:bg-indigo-900/30 dark:text-indigo-400' },
    general_inquiry: { label: '💬 General', color: 'bg-slate-100 text-slate-800 dark:bg-slate-900/30 dark:text-slate-400' }
  };
  
  return categoryMap[analysis.primary_category] || { label: analysis.primary_category, color: 'bg-slate-100 text-slate-800 dark:bg-slate-900/30 dark:text-slate-400' };
};
</script>

<template>
  <div v-if="hasAnalytics" class="analytics-badges mt-2 space-y-1">
    <!-- Analytics indicator -->
    <div class="flex items-center gap-1 mb-2">
      <svg class="w-3 h-3 text-blue-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"/>
      </svg>
      <span class="text-xs font-medium text-blue-600 dark:text-blue-400">Enhanced Analytics</span>
    </div>
    
    <!-- Primary analytics row -->
    <div class="flex flex-wrap gap-1 mb-1">
      <!-- Issue Category -->
      <div v-if="issueAnalysis" class="inline-flex items-center px-2 py-1 rounded text-xs" :class="formatIssueCategory(issueAnalysis).color">
        <span>{{ formatIssueCategory(issueAnalysis).label }}</span>
      </div>
      
      <!-- Business Impact -->
      <div v-if="businessImpact" class="inline-flex items-center px-2 py-1 rounded text-xs" :class="formatBusinessImpact(businessImpact).color">
        <span>{{ formatBusinessImpact(businessImpact).label }}</span>
      </div>
      
      <!-- Escalation Risk -->
      <div v-if="escalationRisk && escalationRisk.risk_level !== 'normal'" class="inline-flex items-center px-2 py-1 rounded text-xs" :class="formatEscalationRisk(escalationRisk).color">
        <span>{{ formatEscalationRisk(escalationRisk).label }}</span>
      </div>
    </div>

    <!-- Secondary analytics row -->
    <div class="flex flex-wrap gap-1">
      <!-- Message count -->
      <div v-if="messageCount" class="inline-flex items-center gap-1 px-2 py-1 bg-blue-50 dark:bg-blue-900/20 rounded text-xs text-blue-700 dark:text-blue-300">
        <svg class="w-3 h-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 12h.01M12 12h.01M16 12h.01M21 12c0 4.418-4.03 8-9 8a9.863 9.863 0 01-4.255-.949L3 20l1.395-3.72C3.512 15.042 3 13.574 3 12c0-4.418 4.03-8 9-8s9 3.582 9 8z"/>
        </svg>
        <span>{{ messageCount.total }} msgs</span>
      </div>
      
      <!-- Sentiment -->
      <div v-if="sentiment" class="inline-flex items-center px-2 py-1 rounded text-xs" :class="formatSentiment(sentiment).color">
        <span>{{ formatSentiment(sentiment).label }}</span>
      </div>
      
      <!-- Resolution status -->
      <div v-if="resolutionStatus" class="inline-flex items-center px-2 py-1 rounded text-xs" :class="formatResolutionStatus(resolutionStatus).color">
        <span>{{ formatResolutionStatus(resolutionStatus).label }}</span>
      </div>
      
      <!-- Conversation Quality -->
      <div v-if="conversationQuality && conversationQuality.quality_level === 'excellent'" class="inline-flex items-center px-2 py-1 bg-emerald-50 dark:bg-emerald-900/20 rounded text-xs text-emerald-700 dark:text-emerald-300">
        <span>⭐ {{ conversationQuality.overall_score }}% Quality</span>
      </div>
    </div>
    
    <!-- Topics -->
    <div v-if="topics.length > 0" class="flex flex-wrap gap-1 mt-1">
      <div
        v-for="(topic, index) in topics.slice(0, 2)"
        :key="`topic-${index}`"
        class="inline-block px-1.5 py-0.5 bg-indigo-50 dark:bg-indigo-900/20 text-indigo-600 dark:text-indigo-400 rounded text-xs"
      >
        {{ topic }}
      </div>
      <div
        v-if="topics.length > 2"
        class="inline-block px-1.5 py-0.5 bg-slate-100 dark:bg-slate-900/20 text-slate-600 dark:text-slate-400 rounded text-xs"
      >
        +{{ topics.length - 2 }} more
      </div>
    </div>
  </div>
</template>

<style scoped>
.analytics-badges {
  font-size: 0.75rem;
}
</style> 