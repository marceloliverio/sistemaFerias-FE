<template>
  <VContainer fluid class="fill-height bg-background">
    <VRow justify="center" align="center" class="fill-height">
      <VCol cols="12" sm="8" md="5" lg="4">
        <div class="text-center mb-8">
          <VIcon icon="mdi-beach" size="64" color="primary" />
          <h1 class="text-h5 font-weight-bold mt-3">Sistema de Férias</h1>
          <p class="text-body-2 text-medium-emphasis mt-1">
            Faça login para continuar
          </p>
        </div>

        <VCard elevation="3">
          <VCardText class="pa-6">
            <VForm @submit.prevent="handleLogin">
              <VRow>
                <VCol cols="12">
                  <Field v-slot="{ field, errors }" name="email" rules="required|email">
                    <VTextField
                      v-bind="field"
                      v-model="form.email"
                      label="E-mail"
                      type="email"
                      prepend-inner-icon="mdi-email-outline"
                      :error-messages="errors"
                      autocomplete="email"
                    />
                  </Field>
                </VCol>

                <VCol cols="12">
                  <Field v-slot="{ field, errors }" name="senha" rules="required|minLength:6">
                    <VTextField
                      v-bind="field"
                      v-model="form.senha"
                      label="Senha"
                      :type="mostrarSenha ? 'text' : 'password'"
                      prepend-inner-icon="mdi-lock-outline"
                      :append-inner-icon="mostrarSenha ? 'mdi-eye-off' : 'mdi-eye'"
                      :error-messages="errors"
                      autocomplete="current-password"
                      @click:append-inner="mostrarSenha = !mostrarSenha"
                    />
                  </Field>
                </VCol>
              </VRow>

              <VAlert
                v-if="authStore.erro"
                type="error"
                variant="tonal"
                density="compact"
                class="mb-4"
                closable
                @click:close="authStore.limparErro()"
              >
                {{ authStore.erro }}
              </VAlert>

              <VBtn
                type="submit"
                color="primary"
                block
                size="large"
                :loading="authStore.loading"
                class="mt-2"
              >
                Entrar
              </VBtn>
            </VForm>
          </VCardText>
        </VCard>
      </VCol>
    </VRow>
  </VContainer>
</template>

<script setup lang="ts">
import { reactive, ref } from 'vue'
import { useForm, Field } from 'vee-validate'
import { useRouter, useRoute } from 'vue-router'
import { useAuthStore } from '@/stores/auth'

const authStore = useAuthStore()
const router = useRouter()
const route = useRoute()

const mostrarSenha = ref(false)

const form = reactive({
  email: '',
  senha: '',
})

const { handleSubmit } = useForm()

const handleLogin = handleSubmit(async () => {
  await authStore.login({ email: form.email, senha: form.senha })
  const redirect = (route.query.redirect as string) ?? '/dashboard'
  await router.push(redirect)
})
</script>
