<template>
  <div v-if="loading" class="loading-overlay d-flex align-center justify-center">
    <VProgressCircular indeterminate color="primary" size="48" />
  </div>
  <slot v-else />
</template>

<script setup lang="ts">
defineProps<{
  loading: boolean
}>()
</script>

<style scoped>
.loading-overlay {
  min-height: 200px;
  width: 100%;
}
</style>
