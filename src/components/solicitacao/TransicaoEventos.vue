<template>
  <div>
    <div class="d-flex flex-wrap ga-2">
      <VBtn
        v-for="transicao in transicoes"
        :key="transicao.evento"
        :color="transicao.cor"
        :prepend-icon="transicao.icone"
        :loading="loadingEvento === transicao.evento"
        :disabled="!!loadingEvento"
        @click="handleEvento(transicao)"
      >
        {{ transicao.label }}
      </VBtn>
    </div>

    <!-- Dialog para observação obrigatória (ex: motivo de rejeição) -->
    <VDialog v-model="dialogObservacao" max-width="480" persistent>
      <VCard>
        <VCardTitle class="text-h6 pa-4">Informe uma observação</VCardTitle>
        <VCardText class="px-4 pb-2">
          <VForm @submit.prevent="confirmarComObservacao">
            <Field
              v-slot="{ field, errors }"
              name="observacao"
              rules="required|minLength:10|maxLength:500"
            >
              <VTextarea
                v-bind="field"
                v-model="observacao"
                label="Observação"
                rows="4"
                :error-messages="errors"
                counter="500"
                autofocus
              />
            </Field>
          </VForm>
        </VCardText>
        <VCardActions class="pa-4 pt-0 justify-end ga-2">
          <VBtn variant="outlined" @click="dialogObservacao = false">Cancelar</VBtn>
          <VBtn color="error" :loading="!!loadingEvento" @click="confirmarComObservacao">
            Confirmar
          </VBtn>
        </VCardActions>
      </VCard>
    </VDialog>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import { Field, useForm } from 'vee-validate'
import type { SolicitacaoFerias, TransicaoPermitida, TransicaoEventoRequest } from '@/types'
import { TRANSICOES_POR_STATUS } from '@/types'

const props = defineProps<{
  solicitacao: SolicitacaoFerias
  loadingEvento?: string | null
}>()

const emit = defineEmits<{
  disparar: [payload: TransicaoEventoRequest]
}>()

const dialogObservacao = ref(false)
const observacao = ref('')
const eventoPendente = ref<TransicaoPermitida | null>(null)

const transicoes = computed((): TransicaoPermitida[] => {
  return TRANSICOES_POR_STATUS[props.solicitacao.status] ?? []
})

const { handleSubmit: handleVeeSubmit } = useForm()

function handleEvento(transicao: TransicaoPermitida): void {
  if (transicao.requerObservacao) {
    eventoPendente.value = transicao
    dialogObservacao.value = true
    return
  }
  emit('disparar', { evento: transicao.evento })
}

const confirmarComObservacao = handleVeeSubmit(() => {
  if (!eventoPendente.value) return
  emit('disparar', {
    evento: eventoPendente.value.evento,
    observacao: observacao.value,
  })
  dialogObservacao.value = false
  observacao.value = ''
  eventoPendente.value = null
})
</script>
