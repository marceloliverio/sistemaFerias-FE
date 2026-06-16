<template>
  <div>
    <!-- Header -->
    <div class="d-flex align-center mb-6 ga-3">
      <VBtn icon="mdi-arrow-left" variant="text" @click="$router.back()" />
      <div class="flex-grow-1">
        <div class="d-flex align-center ga-3">
          <h1 class="text-h5 font-weight-bold">Detalhe da Solicitação</h1>
          <StatusBadge v-if="store.atual" :status="store.atual.status" />
        </div>
        <p class="text-body-2 text-medium-emphasis">ID: {{ id }}</p>
      </div>
    </div>

    <LoadingOverlay :loading="store.loading">
      <template v-if="store.atual">
        <VRow>
          <!-- Informacoes principais -->
          <VCol cols="12" md="8">
            <VCard class="mb-4">
              <VCardTitle class="pa-4 pb-0">Informações</VCardTitle>
              <VCardText class="pa-4">
                <VRow>
                  <VCol cols="12" sm="6">
                    <p class="text-caption text-medium-emphasis">Funcionário</p>
                    <p class="text-body-1 font-weight-medium">
                      {{ store.atual.funcionarioNome }}
                    </p>
                  </VCol>
                  <VCol cols="12" sm="6">
                    <p class="text-caption text-medium-emphasis">CPF</p>
                    <p class="text-body-1 font-weight-medium">
                      {{ store.atual.funcionarioCpf }}
                    </p>
                  </VCol>
                  <VCol cols="12" sm="6">
                    <p class="text-caption text-medium-emphasis">Data de Início</p>
                    <p class="text-body-1 font-weight-medium">
                      {{ formatarData(store.atual.dataInicio) }}
                    </p>
                  </VCol>
                  <VCol cols="12" sm="6">
                    <p class="text-caption text-medium-emphasis">Data de Fim</p>
                    <p class="text-body-1 font-weight-medium">
                      {{ formatarData(store.atual.dataFim) }}
                    </p>
                  </VCol>
                  <VCol cols="12" sm="6">
                    <p class="text-caption text-medium-emphasis">Dias Solicitados</p>
                    <p class="text-body-1 font-weight-medium">
                      {{ calcularDias(store.atual.dataInicio, store.atual.dataFim) }} dias
                    </p>
                  </VCol>
                  <VCol cols="12" sm="6">
                    <p class="text-caption text-medium-emphasis">Criado em</p>
                    <p class="text-body-1 font-weight-medium">
                      {{ formatarDataHora(store.atual.createdAt) }}
                    </p>
                  </VCol>
                  <VCol v-if="store.atual.observacao" cols="12">
                    <p class="text-caption text-medium-emphasis">Observação</p>
                    <p class="text-body-1">{{ store.atual.observacao }}</p>
                  </VCol>
                </VRow>
              </VCardText>
            </VCard>

            <!-- Acoes (transicoes State Machine) -->
            <VCard>
              <VCardTitle class="pa-4 pb-0">Ações Disponíveis</VCardTitle>
              <VCardText class="pa-4">
                <TransicaoEventos
                  :solicitacao="store.atual"
                  :loading-evento="loadingEvento"
                  @disparar="handleDisparar"
                />
              </VCardText>
            </VCard>
          </VCol>

          <!-- Sidebar: timeline -->
          <VCol cols="12" md="4">
            <VCard>
              <VCardTitle class="pa-4 pb-0">Histórico</VCardTitle>
              <VCardText class="pa-4">
                <SolicitacaoTimeline :status-atual="store.atual.status" />
              </VCardText>
            </VCard>
          </VCol>
        </VRow>
      </template>

      <EmptyState
        v-else-if="!store.loading"
        icon="mdi-alert-circle-outline"
        titulo="Solicitação não encontrada"
        descricao="A solicitação pode ter sido excluída ou você não tem acesso."
        acao-label="Voltar"
        acao-icone="mdi-arrow-left"
        @acao="$router.back()"
      />
    </LoadingOverlay>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, onUnmounted } from 'vue'
import { useSolicitacoesStore } from '@/stores/solicitacoes'
import type { TransicaoEventoRequest } from '@/types'
import { formatarData, formatarDataHora, calcularDias } from '@/utils/formatters'
import StatusBadge from '@/components/common/StatusBadge.vue'
import LoadingOverlay from '@/components/common/LoadingOverlay.vue'
import EmptyState from '@/components/common/EmptyState.vue'
import TransicaoEventos from '@/components/solicitacao/TransicaoEventos.vue'
import SolicitacaoTimeline from '@/components/solicitacao/SolicitacaoTimeline.vue'

const props = defineProps<{ id: string }>()

const store = useSolicitacoesStore()

const loadingEvento = ref<string | null>(null)

async function handleDisparar(payload: TransicaoEventoRequest): Promise<void> {
  loadingEvento.value = payload.evento
  try {
    await store.dispararEvento(props.id, payload)
  } finally {
    loadingEvento.value = null
  }
}

onMounted(async () => {
  await store.buscarPorId(props.id)
})

onUnmounted(() => {
  store.limparAtual()
})
</script>
