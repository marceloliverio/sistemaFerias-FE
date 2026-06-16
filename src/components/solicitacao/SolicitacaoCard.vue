<template>
  <VCard
    :to="{ name: 'solicitacao-detalhe', params: { id: solicitacao.id } }"
    hover
    class="solicitacao-card"
  >
    <VCardText class="pa-4">
      <div class="d-flex align-start justify-space-between mb-3">
        <div>
          <p class="text-subtitle-1 font-weight-semibold mb-0">
            {{ solicitacao.funcionarioNome }}
          </p>
          <p class="text-caption text-medium-emphasis">
            {{ formatarData(solicitacao.dataInicio) }} a {{ formatarData(solicitacao.dataFim) }}
            ({{ calcularDias(solicitacao.dataInicio, solicitacao.dataFim) }} dias)
          </p>
        </div>
        <StatusBadge :status="solicitacao.status" size="small" />
      </div>

      <div v-if="solicitacao.observacao" class="mb-2">
        <p class="text-body-2 text-medium-emphasis text-truncate">
          <VIcon icon="mdi-comment-outline" size="14" class="mr-1" />
          {{ solicitacao.observacao }}
        </p>
      </div>

      <div class="d-flex align-center justify-space-between mt-2">
        <p class="text-caption text-disabled">
          Criado em {{ formatarData(solicitacao.createdAt) }}
        </p>
        <VIcon icon="mdi-chevron-right" color="grey-lighten-1" />
      </div>
    </VCardText>
  </VCard>
</template>

<script setup lang="ts">
import type { SolicitacaoFerias } from '@/types'
import StatusBadge from '@/components/common/StatusBadge.vue'
import { formatarData, calcularDias } from '@/utils/formatters'

defineProps<{
  solicitacao: SolicitacaoFerias
}>()
</script>

<style scoped>
.solicitacao-card {
  transition: transform 0.15s ease;
}
.solicitacao-card:hover {
  transform: translateY(-2px);
}
</style>
