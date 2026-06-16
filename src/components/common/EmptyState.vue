<template>
  <div class="d-flex flex-column align-center justify-center py-12 ga-4">
    <VIcon :icon="icon" size="64" color="grey-lighten-1" />
    <div class="text-center">
      <p class="text-h6 text-medium-emphasis">{{ titulo }}</p>
      <p v-if="descricao" class="text-body-2 text-disabled mt-1">{{ descricao }}</p>
    </div>
    <VBtn v-if="acaoLabel" :prepend-icon="acaoIcone" color="primary" @click="emit('acao')">
      {{ acaoLabel }}
    </VBtn>
  </div>
</template>

<script setup lang="ts">
defineProps<{
  icon?: string
  titulo: string
  descricao?: string
  acaoLabel?: string
  acaoIcone?: string
}>()

const emit = defineEmits<{
  acao: []
}>()
</script>
