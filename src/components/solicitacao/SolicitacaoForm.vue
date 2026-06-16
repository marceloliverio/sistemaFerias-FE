<template>
  <VForm @submit.prevent="handleSubmit">
    <VRow>
      <VCol cols="12" md="7">
        <Field
          v-slot="{ field, errors }"
          name="funcionarioNome"
          rules="required|maxLength:150"
        >
          <VTextField
            v-bind="field"
            v-model="form.funcionarioNome"
            label="Nome do Funcionário"
            :error-messages="errors"
            prepend-inner-icon="mdi-account-outline"
            clearable
          />
        </Field>
      </VCol>

      <VCol cols="12" md="5">
        <Field
          v-slot="{ field, errors }"
          name="funcionarioCpf"
          rules="required|cpfFormato"
        >
          <VTextField
            v-bind="field"
            v-model="form.funcionarioCpf"
            label="CPF"
            placeholder="123.456.789-00"
            :error-messages="errors"
            prepend-inner-icon="mdi-card-account-details-outline"
            clearable
            @update:model-value="(v: string) => (form.funcionarioCpf = mascararCpf(v))"
          />
        </Field>
      </VCol>

      <VCol cols="12" md="6">
        <Field
          v-slot="{ field, errors }"
          name="dataInicio"
          rules="required|dataFuturaOuHoje"
        >
          <VTextField
            v-bind="field"
            v-model="form.dataInicio"
            label="Data de Início"
            type="date"
            :error-messages="errors"
            prepend-inner-icon="mdi-calendar-start"
            clearable
          />
        </Field>
      </VCol>

      <VCol cols="12" md="6">
        <Field
          v-slot="{ field, errors }"
          name="dataFim"
          :rules="`required|dataFimAposInicio:${form.dataInicio}`"
        >
          <VTextField
            v-bind="field"
            v-model="form.dataFim"
            label="Data de Fim"
            type="date"
            :error-messages="errors"
            prepend-inner-icon="mdi-calendar-end"
            clearable
          />
        </Field>
      </VCol>

      <VCol cols="12">
        <VAlert
          v-if="diasCalculados > 0"
          type="info"
          variant="tonal"
          density="compact"
          class="mb-2"
        >
          Período de <strong>{{ diasCalculados }} dia(s)</strong>
        </VAlert>
      </VCol>

      <VCol cols="12">
        <Field
          v-slot="{ field, errors }"
          name="observacao"
          rules="maxLength:500"
        >
          <VTextarea
            v-bind="field"
            v-model="form.observacao"
            label="Observação (opcional)"
            rows="3"
            :error-messages="errors"
            prepend-inner-icon="mdi-comment-outline"
            counter="500"
          />
        </Field>
      </VCol>
    </VRow>

    <div class="d-flex justify-end ga-3 mt-2">
      <VBtn
        v-if="mostrarCancelar"
        variant="outlined"
        @click="emit('cancelar')"
      >
        Cancelar
      </VBtn>
      <VBtn
        type="submit"
        color="primary"
        :loading="loading"
        prepend-icon="mdi-content-save"
      >
        {{ labelSalvar }}
      </VBtn>
    </div>
  </VForm>
</template>

<script setup lang="ts">
import { reactive, computed } from 'vue'
import { useForm, Field } from 'vee-validate'
import type { SolicitacaoFeriasRequest } from '@/types'
import { calcularDias, mascararCpf } from '@/utils/formatters'

withDefaults(
  defineProps<{
    loading?: boolean
    labelSalvar?: string
    mostrarCancelar?: boolean
  }>(),
  {
    loading: false,
    labelSalvar: 'Salvar',
    mostrarCancelar: true,
  },
)

const emit = defineEmits<{
  submit: [payload: SolicitacaoFeriasRequest]
  cancelar: []
}>()

const form = reactive({
  funcionarioNome: '',
  funcionarioCpf: '',
  dataInicio: '',
  dataFim: '',
  observacao: '',
})

const diasCalculados = computed(() => {
  if (!form.dataInicio || !form.dataFim) return 0
  const dias = calcularDias(form.dataInicio, form.dataFim)
  return dias > 0 ? dias : 0
})

const { handleSubmit: handleVeeSubmit } = useForm()

const handleSubmit = handleVeeSubmit(() => {
  emit('submit', {
    funcionarioNome: form.funcionarioNome,
    funcionarioCpf: form.funcionarioCpf,
    dataInicio: form.dataInicio,
    dataFim: form.dataFim,
    observacao: form.observacao || undefined,
  })
})
</script>
