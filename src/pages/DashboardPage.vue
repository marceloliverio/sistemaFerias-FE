<template>
  <div>
    <!-- Welcome banner -->
    <div
      class="rounded-lg pa-5 mb-6"
      style="background: linear-gradient(135deg, #000E34 0%, #001754 100%);"
    >
      <div class="d-flex align-center justify-space-between flex-wrap ga-3">
        <div>
          <p
            class="text-caption text-uppercase font-weight-bold mb-1"
            style="color: rgba(255,255,255,0.65); letter-spacing: 0.8px;"
          >
            Bem-vindo
          </p>
          <h2 class="text-h5 font-weight-bold text-white">{{ authStore.nomeUsuario }}</h2>
          <p class="text-body-2 mt-1" style="color: rgba(255,255,255,0.75)">
            Gerencie suas solicitações de férias
          </p>
        </div>
        <VBtn
          color="white"
          variant="elevated"
          prepend-icon="mdi-plus"
          rounded="pill"
          :to="{ name: 'nova-solicitacao' }"
          style="color: #000E34;"
        >
          Nova Solicitação
        </VBtn>
      </div>
    </div>

    <!-- Cards de resumo -->
    <div class="section-header mb-4">
      <div class="section-bar" />
      <span class="text-body-1 font-weight-bold text-uppercase" style="letter-spacing: 0.8px;">Resumo</span>
    </div>

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

    <!-- Últimas solicitações -->
    <VRow>
      <VCol cols="12" md="8">
        <div class="section-header mb-4">
          <div class="section-bar" />
          <span class="text-body-1 font-weight-bold text-uppercase" style="letter-spacing: 0.8px;">Solicitações Recentes</span>
          <VSpacer />
          <VBtn
            variant="text"
            size="small"
            color="primary"
            :to="{ name: 'minhas-solicitacoes' }"
          >
            Ver todas
          </VBtn>
        </div>

        <VCard>
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
        <div class="section-header mb-4">
          <div class="section-bar" />
          <span class="text-body-1 font-weight-bold text-uppercase" style="letter-spacing: 0.8px;">Fluxo de Estados</span>
        </div>

        <VCard>
          <VCardText class="pa-4">
            <div class="d-flex flex-column ga-2">
              <div
                v-for="etapa in fluxoEstados"
                :key="etapa.status"
                class="d-flex align-center ga-3 pa-2 rounded-lg"
                style="background: rgba(0,0,0,0.03);"
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

<style scoped>
.section-header {
  display: flex;
  align-items: center;
  gap: 10px;
}

.section-bar {
  width: 3px;
  height: 18px;
  background: #000E34;
  border-radius: 2px;
  flex-shrink: 0;
}
</style>
