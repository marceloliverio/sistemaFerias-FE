<template>
  <VDialog v-model="visivel" max-width="420" persistent>
    <VCard>
      <VCardTitle class="text-h6 pa-4">
        {{ opcoes.titulo ?? 'Confirmar ação' }}
      </VCardTitle>
      <VCardText class="px-4 pb-2">
        {{ opcoes.mensagem }}
      </VCardText>
      <VCardActions class="pa-4 pt-2 justify-end ga-2">
        <VBtn variant="outlined" @click="onCancelar">
          {{ opcoes.labelCancelar ?? 'Cancelar' }}
        </VBtn>
        <VBtn :color="opcoes.cor ?? 'primary'" @click="onConfirmar">
          {{ opcoes.labelConfirmar ?? 'Confirmar' }}
        </VBtn>
      </VCardActions>
    </VCard>
  </VDialog>
</template>

<script setup lang="ts">
import { useConfirmDialog } from '@/composables/useConfirmDialog'

const { visivel, opcoes, onConfirmar, onCancelar } = useConfirmDialog()
</script>
