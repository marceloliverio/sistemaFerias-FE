<template>
  <VTimeline density="compact" side="end">
    <VTimelineItem
      v-for="etapa in etapas"
      :key="etapa.status"
      :dot-color="etapa.ativa ? etapa.cor : 'grey-lighten-2'"
      :icon="etapa.ativa ? etapa.icone : 'mdi-clock-outline'"
      size="small"
    >
      <div class="d-flex align-center justify-space-between">
        <span
          :class="[
            'text-body-2',
            etapa.ativa ? 'font-weight-semibold' : 'text-disabled',
          ]"
        >
          {{ etapa.label }}
        </span>
        <VIcon
          v-if="etapa.statusAtual"
          icon="mdi-map-marker"
          color="primary"
          size="16"
        />
      </div>
    </VTimelineItem>
  </VTimeline>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { StatusSolicitacao } from '@/types'
import { statusLabel, statusCor } from '@/utils/formatters'

const props = defineProps<{
  statusAtual: StatusSolicitacao
}>()

const FLUXO_PRINCIPAL = [
  StatusSolicitacao.RASCUNHO,
  StatusSolicitacao.ENVIADO,
  StatusSolicitacao.EM_ANALISE,
  StatusSolicitacao.APROVADO,
  StatusSolicitacao.CONCLUIDO,
]

const ICONES: Record<StatusSolicitacao, string> = {
  [StatusSolicitacao.RASCUNHO]: 'mdi-pencil',
  [StatusSolicitacao.ENVIADO]: 'mdi-send',
  [StatusSolicitacao.EM_ANALISE]: 'mdi-magnify',
  [StatusSolicitacao.APROVADO]: 'mdi-check-circle',
  [StatusSolicitacao.REJEITADO]: 'mdi-close-circle',
  [StatusSolicitacao.CONCLUIDO]: 'mdi-flag-checkered',
}

const etapas = computed(() => {
  const fluxo =
    props.statusAtual === StatusSolicitacao.REJEITADO
      ? [...FLUXO_PRINCIPAL.slice(0, 3), StatusSolicitacao.REJEITADO]
      : FLUXO_PRINCIPAL

  const idxAtual = fluxo.indexOf(props.statusAtual)

  return fluxo.map((status, i) => ({
    status,
    label: statusLabel(status),
    cor: statusCor(status),
    icone: ICONES[status],
    ativa: i <= idxAtual,
    statusAtual: status === props.statusAtual,
  }))
})
</script>
