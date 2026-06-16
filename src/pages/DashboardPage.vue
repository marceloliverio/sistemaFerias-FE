<template>
  <div>
    <div class="d-flex align-center justify-space-between mb-6">
      <div>
        <h1 class="text-h5 font-weight-bold">Dashboard</h1>
        <p class="text-body-2 text-medium-emphasis">
          Bem-vindo, {{ authStore.nomeUsuario }}
        </p>
      </div>
      <VBtn
        color="primary"
        prepend-icon="mdi-plus"
        :to="{ name: 'nova-solicitacao' }"
      >
        Nova Solicitação
      </VBtn>
    </div>

    <!-- Cards de resumo -->
    <VRow class="mb-6">
      <VCol
        v-for="card in cardsResumo"
        :key="card.label"
        cols="12"
        sm="6"
        lg="3"
      >
        <VCard>
          <VCardText class="pa-4">
            <div class="d-flex align-center justify-space-between">
              <div>
                <p class="text-caption text-medium-emphasis mb-1">{{ card.label }}</p>
                <p class="text-h4 font-weight-bold">{{ card.valor }}</p>
              </div>
              <VAvatar :color="card.cor" variant="tonal" size="48">
                <VIcon :icon="card.icone" />
              </VAvatar>
            </div>
          </VCardText>
        </VCard>
      </VCol>
    </VRow>

    <!-- Ultimas solicitacoes -->
    <VRow>
      <VCol cols="12" md="8">
        <VCard>
          <VCardTitle class="pa-4 pb-0 d-flex align-center justify-space-between">
            <span>Minhas Solicitações Recentes</span>
            <VBtn variant="text" size="small" :to="{ name: 'minhas-solicitacoes' }">
              Ver todas
            </VBtn>
          </VCardTitle>
          <VCardText class="pa-4">
            <LoadingOverlay :loading="store.loading">
              <div v-if="solicitacoesRecentes.length" class="d-flex flex-column ga-3">
                <SolicitacaoCard
                  v-for="s in solicitacoesRecentes"
                  :key="s.id"
                  :solicitacao="s"
                />
              </div>
              <EmptyState
                v-else
                icon="mdi-calendar-blank"
                titulo="Nenhuma solicitação ainda"
                descricao="Crie sua primeira solicitação de férias"
                acao-label="Nova Solicitação"
                acao-icone="mdi-plus"
                @acao="$router.push({ name: 'nova-solicitacao' })"
              />
            </LoadingOverlay>
          </VCardText>
        </VCard>
      </VCol>

      <VCol cols="12" md="4">
        <VCard>
          <VCardTitle class="pa-4 pb-0">Fluxo de Estados</VCardTitle>
          <VCardText class="pa-4">
            <div class="d-flex flex-column ga-2">
              <div
                v-for="etapa in fluxoEstados"
                :key="etapa.status"
                class="d-flex align-center ga-3 pa-2 rounded-lg bg-grey-lighten-5"
              >
                <VAvatar :color="etapa.cor" variant="tonal" size="32">
                  <VIcon :icon="etapa.icone" size="16" />
                </VAvatar>
                <span class="text-body-2">{{ etapa.label }}</span>
              </div>
            </div>
          </VCardText>
        </VCard>
      </VCol>
    </VRow>
  </div>
</template>

<script setup lang="ts">
import { computed, onMounted } from 'vue'
import { useAuthStore } from '@/stores/auth'
import { useSolicitacoesStore } from '@/stores/solicitacoes'
import { StatusSolicitacao } from '@/types'
import { statusLabel, statusCor } from '@/utils/formatters'
import SolicitacaoCard from '@/components/solicitacao/SolicitacaoCard.vue'
import LoadingOverlay from '@/components/common/LoadingOverlay.vue'
import EmptyState from '@/components/common/EmptyState.vue'

const authStore = useAuthStore()
const store = useSolicitacoesStore()

const solicitacoesRecentes = computed(() => store.lista.slice(0, 3))

const cardsResumo = computed(() => {
  const minhas = store.lista
  return [
    {
      label: 'Total',
      valor: minhas.length,
      cor: 'primary',
      icone: 'mdi-calendar-multiselect',
    },
    {
      label: 'Aprovadas',
      valor: minhas.filter((s) => s.status === StatusSolicitacao.APROVADO).length,
      cor: 'success',
      icone: 'mdi-check-circle',
    },
    {
      label: 'Em Análise',
      valor: minhas.filter((s) =>
        [StatusSolicitacao.ENVIADO, StatusSolicitacao.EM_ANALISE].includes(s.status),
      ).length,
      cor: 'warning',
      icone: 'mdi-clock-outline',
    },
    {
      label: 'Concluídas',
      valor: minhas.filter((s) => s.status === StatusSolicitacao.CONCLUIDO).length,
      cor: 'teal',
      icone: 'mdi-flag-checkered',
    },
  ]
})

const ICONES_FLUXO: Record<string, string> = {
  [StatusSolicitacao.RASCUNHO]: 'mdi-pencil',
  [StatusSolicitacao.ENVIADO]: 'mdi-send',
  [StatusSolicitacao.EM_ANALISE]: 'mdi-magnify',
  [StatusSolicitacao.APROVADO]: 'mdi-check-circle',
  [StatusSolicitacao.CONCLUIDO]: 'mdi-flag-checkered',
}

const fluxoEstados = [
  StatusSolicitacao.RASCUNHO,
  StatusSolicitacao.ENVIADO,
  StatusSolicitacao.EM_ANALISE,
  StatusSolicitacao.APROVADO,
  StatusSolicitacao.CONCLUIDO,
].map((status) => ({
  status,
  label: statusLabel(status),
  cor: statusCor(status),
  icone: ICONES_FLUXO[status] ?? 'mdi-help-circle',
}))

onMounted(async () => {
  await store.buscarLista()
})
</script>
