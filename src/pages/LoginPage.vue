<template>
  <div class="login-page">
    <!-- Navy header -->
    <div class="login-header">
      <div class="login-logo-box">
        <VIcon icon="mdi-shield-account-outline" size="40" color="white" />
      </div>
      <h1 class="login-title">SISTEMA DE FÉRIAS</h1>
      <p class="login-subtitle">Solicitação e Gestão de Férias</p>
    </div>

    <!-- White card section -->
    <div class="login-card-section">
      <div class="login-card-inner">
        <h2 class="text-h6 font-weight-semibold mb-1" style="color: #1D1B20;">Acesso ao Sistema</h2>
        <p class="text-body-2 text-medium-emphasis mb-6">Informe suas credenciais para continuar</p>

        <VForm @submit.prevent="handleLogin">
          <VRow>
            <VCol cols="12" class="pb-2">
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

            <VCol cols="12" class="pb-2">
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
            rounded="pill"
            :loading="authStore.loading"
            class="mt-2"
          >
            Entrar
          </VBtn>
        </VForm>
      </div>
    </div>
  </div>
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

<style scoped>
.login-page {
  min-height: 100vh;
  background: #000E34;
  display: flex;
  flex-direction: column;
}

.login-header {
  flex: 2;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  padding: 32px;
  text-align: center;
}

.login-logo-box {
  width: 72px;
  height: 72px;
  background: #001754;
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 16px;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 20px;
}

.login-title {
  color: white;
  font-size: 22px;
  font-weight: 700;
  letter-spacing: 1.5px;
  margin-bottom: 6px;
}

.login-subtitle {
  color: rgba(255, 255, 255, 0.65);
  font-size: 13px;
  font-weight: 400;
  letter-spacing: 0.3px;
  margin: 0;
}

.login-card-section {
  flex: 3;
  background: #fcfcfc;
  border-radius: 24px 24px 0 0;
  display: flex;
  justify-content: center;
  overflow-y: auto;
  padding: 32px 24px 40px;
}

.login-card-inner {
  width: 100%;
  max-width: 400px;
}
</style>
