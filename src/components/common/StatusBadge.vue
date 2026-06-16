<template>
  <VChip :color="cor" :size="size" variant="tonal" class="font-weight-medium">
    <VIcon start :icon="icone" />
    {{ label }}
  </VChip>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { StatusSolicitacao } from '@/types'
import { statusLabel, statusCor } from '@/utils/formatters'

const props = defineProps<{
  status: StatusSolicitacao
  size?: 'x-small' | 'small' | 'default' | 'large'
}>()

const label = computed(() => statusLabel(props.status))
const cor = computed(() => statusCor(props.status))

const icone = computed(() => {
  const icones: Record<StatusSolicitacao, string> = {
    [StatusSolicitacao.RASCUNHO]: 'mdi-pencil-outline',
    [StatusSolicitacao.ENVIADO]: 'mdi-send',
    [StatusSolicitacao.EM_ANALISE]: 'mdi-magnify',
    [StatusSolicitacao.APROVADO]: 'mdi-check-circle',
    [StatusSolicitacao.REJEITADO]: 'mdi-close-circle',
    [StatusSolicitacao.CONCLUIDO]: 'mdi-flag-checkered',
  }
  return icones[props.status] ?? 'mdi-help-circle'
})
</script>
