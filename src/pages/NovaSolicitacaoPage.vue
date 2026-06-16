<template>
  <div>
    <div class="d-flex align-center mb-6 ga-3">
      <VBtn
        icon="mdi-arrow-left"
        variant="text"
        :to="{ name: 'minhas-solicitacoes' }"
      />
      <div>
        <h1 class="text-h5 font-weight-bold">Nova Solicitação</h1>
        <p class="text-body-2 text-medium-emphasis">Crie uma nova solicitação de férias</p>
      </div>
    </div>

    <VRow justify="center">
      <VCol cols="12" md="8" lg="6">
        <VCard>
          <VCardText class="pa-6">
            <SolicitacaoForm
              :loading="store.loadingAcao"
              label-salvar="Criar Solicitação"
              @submit="handleSubmit"
              @cancelar="$router.push({ name: 'minhas-solicitacoes' })"
            />
          </VCardText>
        </VCard>

        <VAlert
          v-if="store.erro"
          type="error"
          variant="tonal"
          class="mt-4"
          closable
          @click:close="store.limparErro()"
        >
          {{ store.erro }}
        </VAlert>
      </VCol>
    </VRow>
  </div>
</template>

<script setup lang="ts">
import { useSolicitacoesStore } from '@/stores/solicitacoes'
import { useSolicitacaoFerias } from '@/composables/useSolicitacaoFerias'
import SolicitacaoForm from '@/components/solicitacao/SolicitacaoForm.vue'
import type { SolicitacaoFeriasRequest } from '@/types'

const store = useSolicitacoesStore()
const { criarSolicitacao } = useSolicitacaoFerias()

async function handleSubmit(payload: SolicitacaoFeriasRequest): Promise<void> {
  await criarSolicitacao(payload)
}
</script>
