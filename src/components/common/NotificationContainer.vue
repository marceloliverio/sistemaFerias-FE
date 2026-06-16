<template>
  <div class="notification-container">
    <VSnackbar
      v-for="notif in notificacoes"
      :key="notif.id"
      v-model="notif.visivel"
      :color="notif.tipo"
      :timeout="4000"
      location="top right"
      multi-line
    >
      {{ notif.mensagem }}
      <template #actions>
        <VBtn icon="mdi-close" variant="text" @click="remover(notif.id)" />
      </template>
    </VSnackbar>
  </div>
</template>

<script setup lang="ts">
import { useNotification } from '@/composables/useNotification'

const { notificacoes, remover } = useNotification()
</script>

<style scoped>
.notification-container {
  position: fixed;
  top: 0;
  right: 0;
  z-index: 9999;
}
</style>
