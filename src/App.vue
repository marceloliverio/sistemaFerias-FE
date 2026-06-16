<template>
  <VApp>
    <component :is="layout">
      <RouterView />
    </component>
    <NotificationContainer />
    <ConfirmDialogGlobal />
  </VApp>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { useRoute } from 'vue-router'
import DefaultLayout from '@/layouts/DefaultLayout.vue'
import BlankLayout from '@/layouts/BlankLayout.vue'
import NotificationContainer from '@/components/common/NotificationContainer.vue'
import ConfirmDialogGlobal from '@/components/common/ConfirmDialogGlobal.vue'

const route = useRoute()

const layout = computed(() =>
  route.meta.layout === 'blank' ? BlankLayout : DefaultLayout,
)
</script>
