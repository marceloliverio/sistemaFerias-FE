<template>
  <div>
    <div class="d-flex align-center justify-space-between mb-6">
      <div>
        <h1 class="text-h5 font-weight-bold">Gerenciar Solicitações</h1>
        <p class="text-body-2 text-medium-emphasis">
          Visualize e gerencie todas as solicitações
        </p>
      </div>
    </div>

    <!-- Filtros -->
    <VCard class="mb-4">
      <VCardText class="pa-4">
        <VRow align="center">
          <VCol cols="12" sm="6" md="4">
            <VSelect
              v-model="filtroStatus"
              :items="opcoesStatus"
              item-title="label"
              item-value="value"
              label="Status"
              clearable
              prepend-inner-icon="mdi-filter-outline"
              hide-details
              @update:model-value="carregarDados"
            />
          </VCol>
          <VCol cols="auto">
            <VBtn variant="outlined" prepend-icon="mdi-refresh" @click="carregarDados">
              Atualizar
            </VBtn>
          </VCol>
        </VRow>
      </VCardText>
    </VCard>

    <!-- Tabela -->
    <VCard>
      <LoadingOverlay :loading="store.loading">
        <VDataTable
          :headers="headers"
          :items="store.lista"
          hover
        >
          <template #item.status="{ item }">
            <StatusBadge :status="item.status" size="small" />
          </template>

          <template #item.dataInicio="{ item }">
            {{ formatarData(item.dataInicio) }}
          </template>

          <template #item.dataFim="{ item }">
            {{ formatarData(item.dataFim) }}
          </template>

          <template #item.dias="{ item }">
            {{ calcularDias(item.dataInicio, item.dataFim) }}
          </template>

          <template #item.createdAt="{ item }">
            {{ formatarData(item.createdAt) }}
          </template>

          <template #item.acoes="{ item }">
            <VBtn
              icon="mdi-eye"
              variant="text"
              size="small"
              :to="{ name: 'solicitacao-detalhe', params: { id: item.id } }"
            />
          </template>

          <template #no-data>
            <EmptyState
              icon="mdi-inbox-outline"
              titulo="Nenhuma solicitação encontrada"
              descricao="Tente ajustar os filtros"
            />
          </template>
        </VDataTable>
      </LoadingOverlay>
    </VCard>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useSolicitacoesStore } from '@/stores/solicitacoes'
import { StatusSolicitacao } from '@/types'
import { statusLabel, formatarData, calcularDias } from '@/utils/formatters'
import StatusBadge from '@/components/common/StatusBadge.vue'
import LoadingOverlay from '@/components/common/LoadingOverlay.vue'
import EmptyState from '@/components/common/EmptyState.vue'

const store = useSolicitacoesStore()
const filtroStatus = ref<StatusSolicitacao | null>(null)

const opcoesStatus = Object.values(StatusSolicitacao).map((s) => ({
  label: statusLabel(s),
  value: s,
}))

const headers = [
  { title: 'Funcionário', key: 'funcionarioNome' },
  { title: 'CPF', key: 'funcionarioCpf', sortable: false },
  { title: 'Início', key: 'dataInicio' },
  { title: 'Fim', key: 'dataFim' },
  { title: 'Dias', key: 'dias', sortable: false },
  { title: 'Status', key: 'status' },
  { title: 'Criado em', key: 'createdAt' },
  { title: 'Ações', key: 'acoes', sortable: false },
]

async function carregarDados(): Promise<void> {
  await store.buscarLista(filtroStatus.value ?? undefined)
}

onMounted(carregarDados)
</script>
