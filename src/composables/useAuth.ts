import { useRouter } from 'vue-router'
import { useAuthStore } from '@/stores/auth'
import type { LoginRequest } from '@/types'

export function useAuth() {
  const authStore = useAuthStore()
  const router = useRouter()

  async function login(payload: LoginRequest): Promise<void> {
    await authStore.login(payload)
    await router.push({ name: 'dashboard' })
  }

  async function logout(): Promise<void> {
    authStore.logout()
    await router.push({ name: 'login' })
  }

  return {
    usuario: authStore.usuario,
    loading: authStore.loading,
    erro: authStore.erro,
    estaAutenticado: authStore.estaAutenticado,
    nomeUsuario: authStore.nomeUsuario,
    isRH: authStore.isRH,
    isGestor: authStore.isGestor,
    isAdmin: authStore.isAdmin,
    isColaborador: authStore.isColaborador,
    podeGerenciar: authStore.podeGerenciar,
    login,
    logout,
    limparErro: authStore.limparErro,
  }
}
