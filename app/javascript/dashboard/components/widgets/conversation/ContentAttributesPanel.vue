<script setup>
import { computed, onMounted } from 'vue';
import { useI18n } from 'vue-i18n';
import { useStore, useStoreGetters } from 'dashboard/composables/store';
import { useRoute } from 'vue-router';
import NextButton from 'dashboard/components-next/button/Button.vue';

const { t } = useI18n();
const store = useStore();
const getters = useStoreGetters();
const route = useRoute();

const conversationId = computed(() => {
  return route.params.conversationId || getters.getSelectedChat.value.id;
});

const currentChat = computed(() => getters.getSelectedChat.value);

// Extract content attributes
const contentAttributes = computed(() => {
  if (!currentChat.value || !currentChat.value.content_attributes) {
    return null;
  }

  return currentChat.value.content_attributes;
});

// Initialize content attributes if not present
onMounted(async () => {
  if (currentChat.value && conversationId.value) {
    if (!contentAttributes.value || Object.keys(contentAttributes.value).length === 0) {
      // Auto-generating conversation analytics for conversation
      await refreshAttributes();
    }
    // Conversation analytics already available
  }
});

// Demo analytics data for when no real analytics are available
const demoAnalytics = computed(() => ({
  message_count: {
    total: 5,
    user: 3,
    agent: 2,
  },
  response_times: {
    average: 480, // 8 minutes
    min: 120, // 2 minutes
    max: 900, // 15 minutes
    total: 1440, // 24 minutes total
  },
  sentiment: 'positive',
  topics: ['Customer Support', 'Product Question', 'General Inquiry'],
  language: 'english',
  complexity: 0.6,
  engagement_metrics: {
    duration_seconds: 3600, // 1 hour
    avg_time_between_messages: 720, // 12 minutes
    user_messages: 3,
    agent_messages: 2,
    engagement_score: 0.75,
  },
  conversation_summary:
    'Customer support conversation with product questions and helpful guidance provided',
  key_phrases: [
    'customer support',
    'product question',
    'helpful guidance',
    'resolved',
  ],
  resolution_status: 'resolved',

  // Enhanced business analytics
  issue_analysis: {
    categories: [
      { category: 'general_support', priority: 'medium', severity: 'low' },
    ],
    primary_category: 'general_support',
    priority: 'medium',
    category_count: 1,
  },

  escalation_risk: {
    risk_level: 'low',
    risk_score: -1,
    high_risk_indicators: 0,
    medium_risk_indicators: 0,
    positive_indicators: 2,
    slow_response_penalty: 0,
  },

  business_impact: {
    impact_level: 'medium',
    impact_score: 10,
    impact_indicators: { support: 1, engagement: 1 },
    estimated_value: 1500,
  },

  conversation_quality: {
    overall_score: 82,
    quality_level: 'good',
    components: {
      engagement: 20,
      responsiveness: 21,
      sentiment: 20,
      resolution: 21,
    },
    improvement_suggestions: ['Continue providing helpful support'],
  },
}));

// Use demo analytics if no real analytics are available
const displayAnalytics = computed(() => {
  if (
    contentAttributes.value &&
    Object.keys(contentAttributes.value).length > 0
  ) {
    return contentAttributes.value;
  }
  return demoAnalytics.value;
});

// Update computed properties to use displayAnalytics
const messageCount = computed(
  () => displayAnalytics.value?.message_count || null
);
const responseTimes = computed(
  () => displayAnalytics.value?.response_times || null
);
const sentiment = computed(() => displayAnalytics.value?.sentiment || null);
const topics = computed(() => displayAnalytics.value?.topics || []);
const language = computed(() => displayAnalytics.value?.language || null);
const complexity = computed(() => displayAnalytics.value?.complexity || null);
const engagementMetrics = computed(
  () => displayAnalytics.value?.engagement_metrics || null
);
const conversationSummary = computed(
  () => displayAnalytics.value?.conversation_summary || null
);
const keyPhrases = computed(() => displayAnalytics.value?.key_phrases || []);
const resolutionStatus = computed(
  () => displayAnalytics.value?.resolution_status || null
);

// Enhanced freestyle features
const issueAnalysis = computed(
  () => displayAnalytics.value?.issue_analysis || null
);
const escalationRisk = computed(
  () => displayAnalytics.value?.escalation_risk || null
);
const businessImpact = computed(
  () => displayAnalytics.value?.business_impact || null
);
const conversationQuality = computed(
  () => displayAnalytics.value?.conversation_quality || null
);

// Function to format sentiment for display
const formatSentiment = (sentimentValue) => {
  if (!sentimentValue) return '-';
  
  const sentimentMap = {
    very_positive: { label: t('CONVERSATION.CONTENT_ATTRIBUTES.SENTIMENT.VERY_POSITIVE'), color: 'text-green-800' },
    positive: { label: t('CONVERSATION.CONTENT_ATTRIBUTES.SENTIMENT.POSITIVE'), color: 'text-green-600' },
    neutral: { label: t('CONVERSATION.CONTENT_ATTRIBUTES.SENTIMENT.NEUTRAL'), color: 'text-slate-600' },
    negative: { label: t('CONVERSATION.CONTENT_ATTRIBUTES.SENTIMENT.NEGATIVE'), color: 'text-ruby-600' },
    very_negative: { label: t('CONVERSATION.CONTENT_ATTRIBUTES.SENTIMENT.VERY_NEGATIVE'), color: 'text-ruby-800' }
  };
  
  return sentimentMap[sentimentValue] || { label: sentimentValue, color: 'text-slate-600' };
};

// Format language for display
const formatLanguage = lang => {
  if (!lang) return '-';

  const languageMap = {
    english: t('CONVERSATION.CONTENT_ATTRIBUTES.LANGUAGE.ENGLISH'),
    spanish: t('CONVERSATION.CONTENT_ATTRIBUTES.LANGUAGE.SPANISH'),
    french: t('CONVERSATION.CONTENT_ATTRIBUTES.LANGUAGE.FRENCH'),
    german: t('CONVERSATION.CONTENT_ATTRIBUTES.LANGUAGE.GERMAN'),
    chinese: t('CONVERSATION.CONTENT_ATTRIBUTES.LANGUAGE.CHINESE'),
    japanese: t('CONVERSATION.CONTENT_ATTRIBUTES.LANGUAGE.JAPANESE'),
    unknown: t('CONVERSATION.CONTENT_ATTRIBUTES.LANGUAGE.UNKNOWN'),
  };

  return languageMap[lang] || lang;
};

// Format resolution status
const formatResolutionStatus = status => {
  if (!status) return '-';

  const statusMap = {
    resolved: {
      label: t('CONVERSATION.CONTENT_ATTRIBUTES.RESOLUTION.RESOLVED'),
      color: 'text-green-800',
    },
    likely_resolved: {
      label: t('CONVERSATION.CONTENT_ATTRIBUTES.RESOLUTION.LIKELY_RESOLVED'),
      color: 'text-green-600',
    },
    unknown: {
      label: t('CONVERSATION.CONTENT_ATTRIBUTES.RESOLUTION.UNKNOWN'),
      color: 'text-slate-600',
    },
    likely_unresolved: {
      label: t('CONVERSATION.CONTENT_ATTRIBUTES.RESOLUTION.LIKELY_UNRESOLVED'),
      color: 'text-ruby-600',
    },
    unresolved: {
      label: t('CONVERSATION.CONTENT_ATTRIBUTES.RESOLUTION.UNRESOLVED'),
      color: 'text-ruby-800',
    },
  };

  return statusMap[status] || { label: status, color: 'text-slate-600' };
};

// Function to format seconds into readable duration
const formatDuration = seconds => {
  if (!seconds) return '-';

  const hours = Math.floor(seconds / 3600);
  const minutes = Math.floor((seconds % 3600) / 60);
  const remainingSeconds = seconds % 60;

  if (hours > 0) {
    return `${hours}h ${minutes}m ${remainingSeconds}s`;
  }
  if (minutes > 0) {
    return `${minutes}m ${remainingSeconds}s`;
  }

  return `${remainingSeconds}s`;
};

// Format complexity score (0-1) as a percentage and difficulty level
const formatComplexity = score => {
  if (score === null || score === undefined) return '-';

  const percentage = Math.round(score * 100);
  let level;

  if (score < 0.2) {
    level = t('CONVERSATION.CONTENT_ATTRIBUTES.COMPLEXITY.VERY_SIMPLE');
  } else if (score < 0.4) {
    level = t('CONVERSATION.CONTENT_ATTRIBUTES.COMPLEXITY.SIMPLE');
  } else if (score < 0.6) {
    level = t('CONVERSATION.CONTENT_ATTRIBUTES.COMPLEXITY.MEDIUM');
  } else if (score < 0.8) {
    level = t('CONVERSATION.CONTENT_ATTRIBUTES.COMPLEXITY.COMPLEX');
  } else {
    level = t('CONVERSATION.CONTENT_ATTRIBUTES.COMPLEXITY.VERY_COMPLEX');
  }

  return `${level} (${percentage}%)`;
};

// Function to force recalculation of content attributes
const refreshAttributes = () => {
  if (!conversationId.value) return;
  
  // Dispatch action to recalculate content attributes
  store.dispatch('conversations/updateContentAttributes', {
    conversationId: conversationId.value
  });
};
</script>

<template>
  <div
    class="content-attributes-panel rounded-lg bg-white dark:bg-n-solid-1 p-3"
  >
    <!-- Header with refresh button -->
    <div class="flex justify-between items-center mb-4">
      <div class="flex items-center gap-2">
        <div
          class="w-8 h-8 bg-gradient-to-br from-blue-500 to-indigo-600 rounded-lg flex items-center justify-center"
        >
          <svg
            class="w-4 h-4 text-white"
            fill="none"
            stroke="currentColor"
            viewBox="0 0 24 24"
          >
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"
            />
          </svg>
        </div>
        <h3
          class="text-base font-semibold bg-gradient-to-r from-blue-600 to-indigo-600 bg-clip-text text-transparent"
        >
          {{ $t('CONVERSATION.CONTENT_ATTRIBUTES.TITLE') }}
        </h3>
      </div>
      <NextButton
        v-tooltip="$t('CONVERSATION.CONTENT_ATTRIBUTES.REFRESH')"
        xs
        ghost
        icon="i-lucide-refresh-cw"
        class="hover:bg-blue-50 dark:hover:bg-blue-900/20"
        @click="refreshAttributes"
      />
    </div>

    <!-- Loading state -->
    <div v-if="!displayAnalytics" class="p-3 text-center text-slate-600">
      {{ $t('CONVERSATION.CONTENT_ATTRIBUTES.LOADING') }}
    </div>

    <!-- Content when attributes are available -->
    <div v-else class="space-y-6">
      <!-- Demo indicator -->
      <div v-if="!contentAttributes || Object.keys(contentAttributes).length === 0" class="demo-indicator p-2 bg-gradient-to-r from-blue-50 to-indigo-50 dark:from-blue-900/20 dark:to-indigo-900/20 border border-blue-200 dark:border-blue-800 rounded-lg">
        <div class="flex items-center gap-2">
          <svg class="w-4 h-4 text-blue-600 dark:text-blue-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
          </svg>
          <span class="text-xs font-medium text-blue-700 dark:text-blue-300">{{ $t('CONVERSATION.CONTENT_ATTRIBUTES.DEMO_DATA') }}</span>
        </div>
      </div>

      <!-- Conversation Summary -->
      <div v-if="conversationSummary" class="summary-section">
        <h4 class="text-sm font-medium mb-1">
          {{ $t('CONVERSATION.CONTENT_ATTRIBUTES.SUMMARY') }}
        </h4>
        <p class="text-sm text-slate-600 dark:text-slate-300">
          {{ conversationSummary }}
        </p>
      </div>

      <!-- Topics and Key Phrases -->
      <div class="flex flex-wrap gap-2">
        <!-- Topics tags -->
        <div v-if="topics && topics.length > 0" class="topics-section w-full">
          <h4 class="text-sm font-medium mb-1">
            {{ $t('CONVERSATION.CONTENT_ATTRIBUTES.TOPICS') }}
          </h4>
          <div class="flex flex-wrap gap-1">
            <span
              v-for="(topic, index) in topics"
              :key="`topic-${index}`"
              class="inline-block bg-n-slate-2 dark:bg-n-solid-2 px-2 py-1 rounded-md text-xs"
            >
              {{ topic }}
            </span>
          </div>
        </div>

        <!-- Key phrases -->
        <div
          v-if="keyPhrases && keyPhrases.length > 0"
          class="key-phrases-section w-full"
        >
          <h4 class="text-sm font-medium mb-1">
            {{ $t('CONVERSATION.CONTENT_ATTRIBUTES.KEY_PHRASES') }}
          </h4>
          <div class="flex flex-wrap gap-1">
            <span
              v-for="(phrase, index) in keyPhrases"
              :key="`phrase-${index}`"
              class="inline-block bg-n-sky-2 dark:bg-n-indigo-1 dark:text-indigo-900 px-2 py-1 rounded-md text-xs"
            >
              {{ phrase }}
            </span>
          </div>
        </div>
      </div>

      <!-- Stats Dashboard -->
      <div class="stats-dashboard grid grid-cols-2 gap-3">
        <!-- Message count -->
        <div
          v-if="messageCount"
          class="stat-card p-3 bg-gradient-to-br from-blue-50 to-indigo-50 dark:from-blue-900/20 dark:to-indigo-900/20 border border-blue-200 dark:border-blue-800 rounded-lg shadow-sm"
        >
          <div class="flex items-center gap-2 mb-2">
            <svg
              class="w-4 h-4 text-blue-600 dark:text-blue-400"
              fill="none"
              stroke="currentColor"
              viewBox="0 0 24 24"
            >
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M8 12h.01M12 12h.01M16 12h.01M21 12c0 4.418-4.03 8-9 8a9.863 9.863 0 01-4.255-.949L3 20l1.395-3.72C3.512 15.042 3 13.574 3 12c0-4.418 4.03-8 9-8s9 3.582 9 8z"
              />
            </svg>
            <h5 class="text-xs font-medium text-blue-700 dark:text-blue-300">
              {{ $t('CONVERSATION.CONTENT_ATTRIBUTES.MESSAGE_COUNT') }}
            </h5>
          </div>
          <div class="flex justify-between items-center">
            <span class="text-2xl font-bold text-blue-800 dark:text-blue-200">{{
              messageCount.total
            }}</span>
            <div class="text-xs text-blue-600 dark:text-blue-400 space-y-1">
              <div class="flex items-center gap-1">
                <div class="w-2 h-2 bg-green-500 rounded-full" />
                <span>{{ $t('CONVERSATION.CONTENT_ATTRIBUTES.USER') }}:
                  {{ messageCount.user }}</span>
              </div>
              <div class="flex items-center gap-1">
                <div class="w-2 h-2 bg-blue-500 rounded-full" />
                <span>{{ $t('CONVERSATION.CONTENT_ATTRIBUTES.AGENT') }}:
                  {{ messageCount.agent }}</span>
              </div>
            </div>
          </div>
        </div>

        <!-- Avg Response Time -->
        <div
          v-if="responseTimes && responseTimes.average"
          class="stat-card p-2 bg-n-slate-1 dark:bg-n-solid-2 rounded-md"
        >
          <h5 class="text-xs text-slate-500 dark:text-slate-400">
            {{ $t('CONVERSATION.CONTENT_ATTRIBUTES.AVG_RESPONSE_TIME') }}
          </h5>
          <div class="flex items-center">
            <span class="text-lg font-medium">{{
              formatDuration(responseTimes.average)
            }}</span>
          </div>
        </div>

        <!-- Sentiment -->
        <div
          v-if="sentiment"
          class="stat-card p-2 bg-n-slate-1 dark:bg-n-solid-2 rounded-md"
        >
          <h5 class="text-xs text-slate-500 dark:text-slate-400">
            {{ $t('CONVERSATION.CONTENT_ATTRIBUTES.SENTIMENT') }}
          </h5>
          <div class="flex items-center">
            <span
              class="text-lg font-medium"
              :class="formatSentiment(sentiment).color"
            >
              {{ formatSentiment(sentiment).label }}
            </span>
          </div>
        </div>

        <!-- Complexity -->
        <div
          v-if="complexity !== null"
          class="stat-card p-2 bg-n-slate-1 dark:bg-n-solid-2 rounded-md"
        >
          <h5 class="text-xs text-slate-500 dark:text-slate-400">
            {{ $t('CONVERSATION.CONTENT_ATTRIBUTES.COMPLEXITY') }}
          </h5>
          <div class="flex items-center">
            <span class="text-lg font-medium">{{
              formatComplexity(complexity)
            }}</span>
          </div>
        </div>

        <!-- Language -->
        <div
          v-if="language"
          class="stat-card p-2 bg-n-slate-1 dark:bg-n-solid-2 rounded-md"
        >
          <h5 class="text-xs text-slate-500 dark:text-slate-400">
            {{ $t('CONVERSATION.CONTENT_ATTRIBUTES.LANGUAGE') }}
          </h5>
          <div class="flex items-center">
            <span class="text-lg font-medium">{{
              formatLanguage(language)
            }}</span>
          </div>
        </div>

        <!-- Resolution Status -->
        <div
          v-if="resolutionStatus"
          class="stat-card p-2 bg-n-slate-1 dark:bg-n-solid-2 rounded-md"
        >
          <h5 class="text-xs text-slate-500 dark:text-slate-400">
            {{ $t('CONVERSATION.CONTENT_ATTRIBUTES.RESOLUTION_STATUS') }}
          </h5>
          <div class="flex items-center">
            <span
              class="text-lg font-medium"
              :class="formatResolutionStatus(resolutionStatus).color"
            >
              {{ formatResolutionStatus(resolutionStatus).label }}
            </span>
          </div>
        </div>
      </div>

      <!-- Enhanced Business Analytics -->
      <div
        v-if="businessImpact || escalationRisk || conversationQuality"
        class="business-analytics-section"
      >
        <h4 class="text-sm font-medium mb-3 flex items-center gap-2">
          <div
            class="w-4 h-4 bg-gradient-to-br from-purple-500 to-pink-500 rounded flex items-center justify-center"
          >
            <svg
              class="w-3 h-3 text-white"
              fill="none"
              stroke="currentColor"
              viewBox="0 0 24 24"
            >
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M13 7h8m0 0v8m0-8l-8 8-4-4-6 6"
              />
            </svg>
          </div>
          Business Intelligence
        </h4>

        <div class="grid grid-cols-1 gap-3">
          <!-- Business Impact -->
          <div
            v-if="businessImpact"
            class="p-3 bg-gradient-to-br from-purple-50 to-pink-50 dark:from-purple-900/20 dark:to-pink-900/20 border border-purple-200 dark:border-purple-800 rounded-lg"
          >
            <div class="flex justify-between items-center mb-2">
              <h5
                class="text-xs font-medium text-purple-700 dark:text-purple-300"
              >
                Business Impact
              </h5>
              <span
                class="text-lg font-bold text-purple-800 dark:text-purple-200"
                >${{
                  businessImpact.estimated_value?.toLocaleString() || 'N/A'
                }}</span>
            </div>
            <div class="flex items-center gap-2">
              <span
                class="px-2 py-1 bg-purple-100 dark:bg-purple-900/30 text-purple-800 dark:text-purple-300 rounded text-xs font-medium"
              >
                {{
                  businessImpact.impact_level
                    ?.replace('_', ' ')
                    ?.toUpperCase() || 'UNKNOWN'
                }}
              </span>
              <span class="text-xs text-purple-600 dark:text-purple-400">Impact Score: {{ businessImpact.impact_score || 0 }}</span>
            </div>
          </div>

          <!-- Escalation Risk -->
          <div
            v-if="escalationRisk"
            class="p-3 rounded-lg"
            :class="{
              'bg-gradient-to-br from-red-50 to-orange-50 dark:from-red-900/20 dark:to-orange-900/20 border border-red-200 dark:border-red-800':
                escalationRisk.risk_level === 'high',
              'bg-gradient-to-br from-yellow-50 to-orange-50 dark:from-yellow-900/20 dark:to-orange-900/20 border border-yellow-200 dark:border-yellow-800':
                escalationRisk.risk_level === 'medium',
              'bg-gradient-to-br from-green-50 to-emerald-50 dark:from-green-900/20 dark:to-emerald-900/20 border border-green-200 dark:border-green-800':
                escalationRisk.risk_level === 'low' ||
                escalationRisk.risk_level === 'normal',
            }"
          >
            <div class="flex justify-between items-center mb-2">
              <h5
                class="text-xs font-medium"
                :class="{
                  'text-red-700 dark:text-red-300':
                    escalationRisk.risk_level === 'high',
                  'text-yellow-700 dark:text-yellow-300':
                    escalationRisk.risk_level === 'medium',
                  'text-green-700 dark:text-green-300':
                    escalationRisk.risk_level === 'low' ||
                    escalationRisk.risk_level === 'normal',
                }"
              >
                Escalation Risk
              </h5>
              <span
                class="text-lg font-bold"
                :class="{
                  'text-red-800 dark:text-red-200':
                    escalationRisk.risk_level === 'high',
                  'text-yellow-800 dark:text-yellow-200':
                    escalationRisk.risk_level === 'medium',
                  'text-green-800 dark:text-green-200':
                    escalationRisk.risk_level === 'low' ||
                    escalationRisk.risk_level === 'normal',
                }"
                >{{
                  escalationRisk.risk_level?.toUpperCase() || 'UNKNOWN'
                }}</span>
            </div>
            <div
              class="text-xs space-y-1"
              :class="{
                'text-red-600 dark:text-red-400':
                  escalationRisk.risk_level === 'high',
                'text-yellow-600 dark:text-yellow-400':
                  escalationRisk.risk_level === 'medium',
                'text-green-600 dark:text-green-400':
                  escalationRisk.risk_level === 'low' ||
                  escalationRisk.risk_level === 'normal',
              }"
            >
              <div>Risk Score: {{ escalationRisk.risk_score || 0 }}</div>
              <div>
                Positive Indicators:
                {{ escalationRisk.positive_indicators || 0 }}
              </div>
            </div>
          </div>

          <!-- Conversation Quality -->
          <div
            v-if="conversationQuality"
            class="p-3 bg-gradient-to-br from-emerald-50 to-teal-50 dark:from-emerald-900/20 dark:to-teal-900/20 border border-emerald-200 dark:border-emerald-800 rounded-lg"
          >
            <div class="flex justify-between items-center mb-2">
              <h5
                class="text-xs font-medium text-emerald-700 dark:text-emerald-300"
              >
                Conversation Quality
              </h5>
              <span
                class="text-lg font-bold text-emerald-800 dark:text-emerald-200"
                >{{ conversationQuality.overall_score || 0 }}%</span>
            </div>
            <div class="flex items-center gap-2">
              <span
                class="px-2 py-1 bg-emerald-100 dark:bg-emerald-900/30 text-emerald-800 dark:text-emerald-300 rounded text-xs font-medium"
              >
                {{
                  conversationQuality.quality_level
                    ?.replace('_', ' ')
                    ?.toUpperCase() || 'UNKNOWN'
                }}
              </span>
              <div class="flex gap-1">
                <div
                  v-for="i in 5"
                  :key="i"
                  class="w-2 h-2 rounded-full"
                  :class="{
                    'bg-emerald-500':
                      i <=
                      Math.round((conversationQuality.overall_score || 0) / 20),
                    'bg-emerald-200 dark:bg-emerald-700':
                      i >
                      Math.round((conversationQuality.overall_score || 0) / 20),
                  }"
                />
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Issue Analysis & Customer Journey -->
      <div
        v-if="issueAnalysis || customerJourney"
        class="advanced-analytics-section"
      >
        <h4 class="text-sm font-medium mb-3 flex items-center gap-2">
          <div
            class="w-4 h-4 bg-gradient-to-br from-indigo-500 to-blue-500 rounded flex items-center justify-center"
          >
            <svg
              class="w-3 h-3 text-white"
              fill="none"
              stroke="currentColor"
              viewBox="0 0 24 24"
            >
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M9.663 17h4.673M12 3v1m6.364 1.636l-.707.707M21 12h-1M4 12H3m3.343-5.657l-.707-.707m2.828 9.9a5 5 0 117.072 0l-.548.547A3.374 3.374 0 0014 18.469V19a2 2 0 11-4 0v-.531c0-.895-.356-1.754-.988-2.386l-.548-.547z"
              />
            </svg>
          </div>
          Advanced Analytics
        </h4>

        <div class="grid grid-cols-1 gap-3">
          <!-- Issue Category -->
          <div
            v-if="issueAnalysis"
            class="p-3 bg-gradient-to-br from-indigo-50 to-blue-50 dark:from-indigo-900/20 dark:to-blue-900/20 border border-indigo-200 dark:border-indigo-800 rounded-lg"
          >
            <h5
              class="text-xs font-medium text-indigo-700 dark:text-indigo-300 mb-2"
            >
              Issue Analysis
            </h5>
            <div class="space-y-2">
              <div class="flex justify-between items-center">
                <span class="text-sm text-indigo-800 dark:text-indigo-200">{{
                  issueAnalysis.primary_category
                    ?.replace('_', ' ')
                    ?.toUpperCase() || 'GENERAL'
                }}</span>
                <span
                  class="px-2 py-1 bg-indigo-100 dark:bg-indigo-900/30 text-indigo-800 dark:text-indigo-300 rounded text-xs"
                >
                  {{ issueAnalysis.priority?.toUpperCase() || 'LOW' }} PRIORITY
                </span>
              </div>
              <div class="text-xs text-indigo-600 dark:text-indigo-400">
                Categories Detected: {{ issueAnalysis.category_count || 0 }}
              </div>
            </div>
          </div>

          <!-- Customer Journey -->
          <div
            v-if="customerJourney"
            class="p-3 bg-gradient-to-br from-teal-50 to-cyan-50 dark:from-teal-900/20 dark:to-cyan-900/20 border border-teal-200 dark:border-teal-800 rounded-lg"
          >
            <h5
              class="text-xs font-medium text-teal-700 dark:text-teal-300 mb-2"
            >
              Customer Journey Stage
            </h5>
            <div class="space-y-2">
              <div class="flex justify-between items-center">
                <span class="text-sm text-teal-800 dark:text-teal-200">{{
                  customerJourney.primary_stage
                    ?.replace('_', ' ')
                    ?.toUpperCase() || 'UNKNOWN'
                }}</span>
                <span
                  class="px-2 py-1 bg-teal-100 dark:bg-teal-900/30 text-teal-800 dark:text-teal-300 rounded text-xs"
                >
                  {{ customerJourney.confidence_score || 0 }} confidence
                </span>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Engagement Metrics -->
      <div v-if="engagementMetrics" class="engagement-section">
        <h4 class="text-sm font-medium mb-1">
          {{ $t('CONVERSATION.CONTENT_ATTRIBUTES.ENGAGEMENT') }}
        </h4>
        <div class="grid grid-cols-2 gap-2">
          <div class="p-2 bg-n-slate-1 dark:bg-n-solid-2 rounded-md">
            <span class="text-xs text-slate-500 dark:text-slate-400">{{
              $t('CONVERSATION.CONTENT_ATTRIBUTES.DURATION')
            }}</span>
            <div class="text-base font-medium">
              {{ formatDuration(engagementMetrics.duration_seconds) }}
            </div>
          </div>
          <div class="p-2 bg-n-slate-1 dark:bg-n-solid-2 rounded-md">
            <span class="text-xs text-slate-500 dark:text-slate-400">{{
              $t('CONVERSATION.CONTENT_ATTRIBUTES.ENGAGEMENT_SCORE')
            }}</span>
            <div class="text-base font-medium">
              {{ (engagementMetrics.engagement_score * 100).toFixed(0) }}%
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.content-attributes-panel {
  max-height: 100%;
  overflow-y: auto;
}
</style>
