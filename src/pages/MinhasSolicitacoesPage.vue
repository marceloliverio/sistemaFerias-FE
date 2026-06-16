<template>
  <div>
    <div class="d-flex align-center justify-space-between mb-6">
      <div>
        <h1 class="text-h5 font-weight-bold">Solicitações</h1>
        <p class="text-body-2 text-medium-emphasis">Acompanhe as solicitações de férias</p>
      </div>
      <VBtn color="primary" prepend-icon="mdi-plus" :to="{ name: 'nova-solicitacao' }">
        Nova
      </VBtn>
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
              label="Filtrar por status"
              clearable
              prepend-inner-icon="mdi-filter-outline"
              hide-details
              @update:model-value="carregarDados"
            />
          </VCol>
          <VCol cols="12" sm="6" md="3">
            <VBtn variant="outlined" prepend-icon="mdi-refresh" @click="carregarDados">
              Atualizar
            </VBtn>
          </VCol>
        </VRow>
      </VCardText>
    </VCard>

    <!-- Lista -->
    <LoadingOverlay :loading="store.loading">
      <div v-if="store.lista.length" class="d-flex flex-column ga-3">
        <SolicitacaoCard
          v-for="s in store.lista"
          :key="s.id"
          :solicitacao="s"
        />
      </div>
      <EmptyState
        v-else
        icon="mdi-calendar-blank-outline"
        titulo="Nenhuma solicitação encontrada"
        :descricao="filtroStatus ? 'Tente remover o filtro de status' : 'Crie sua primeira solicitação de férias'"
        :acao-label="filtroStatus ? undefined : 'Nova Solicitação'"
        acao-icone="mdi-plus"
        @acao="$router.push({ name: 'nova-solicitacao' })"
      />
    </LoadingOverlay>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useSolicitacoesStore } from '@/stores/solicitacoes'
import { StatusSolicitacao } from '@/types'
import { statusLabel } from '@/utils/formatters'
import SolicitacaoCard from '@/components/solicitacao/SolicitacaoCard.vue'
import LoadingOverlay from '@/components/common/LoadingOverlay.vue'
import EmptyState from '@/components/common/EmptyState.vue'

const store = useSolicitacoesStore()
const filtroStatus = ref<StatusSolicitacao | null>(null)

const opcoesStatus = Object.values(StatusSolicitacao).map((s) => ({
  label: statusLabel(s),
  value: s,
}))

async function carregarDados(): Promise<void> {
  await store.buscarLista(filtroStatus.value ?? undefined)
}

onMounted(carregarDados)
</script>
