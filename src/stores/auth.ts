import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import type { Usuario, LoginRequest } from '@/types'
import { RoleUsuario } from '@/types'
import { authService } from '@/services/authService'

// Decodifica o payload do JWT sem validar assinatura (apenas leitura local).
// O token real só contém `sub` (email) — não há nome nem role no payload.
function decodificarEmailDoToken(token: string): string | null {
  try {
    const payloadBase64 = token.split('.')[1]
    const payload = JSON.parse(atob(payloadBase64.replace(/-/g, '+').replace(/_/g, '/')))
    return typeof payload.sub === 'string' ? payload.sub : null
  } catch {
    return null
  }
}

// NOTA p/ Backend Agent: a API não expõe endpoint de usuário autenticado
// nem role (RH/Gestor/Admin/Colaborador). O usuário abaixo é montado
// localmente a partir do email contido no JWT, com role fixa mockada
// (RoleUsuario.ADMIN) só para manter a UI baseada em role funcionando.
// Quando existir um endpoint real de perfil, substituir esta função.
function criarUsuarioMockado(token: string): Usuario {
  const email = decodificarEmailDoToken(token) ?? 'usuario@desconhecido'
  const nome = email.split('@')[0]
  return {
    id: email,
    nome,
    email,
    role: RoleUsuario.ADMIN,
  }
}

export const useAuthStore = defineStore('auth', () => {
  // -------------------------------------------------------
  // State
  // -------------------------------------------------------
  const token = ref<string | null>(localStorage.getItem('auth_token'))
  const usuario = ref<Usuario | null>(
    JSON.parse(localStorage.getItem('auth_user') ?? 'null'),
  )
  const loading = ref(false)
  const erro = ref<string | null>(null)

  // -------------------------------------------------------
  // Getters
  // -------------------------------------------------------
  const estaAutenticado = computed(() => !!token.value)
  const nomeUsuario = computed(() => usuario.value?.nome ?? '')
  const isRH = computed(() => usuario.value?.role === RoleUsuario.RH)
  const isGestor = computed(() => usuario.value?.role === RoleUsuario.GESTOR)
  const isAdmin = computed(() => usuario.value?.role === RoleUsuario.ADMIN)
  const isColaborador = computed(() => usuario.value?.role === RoleUsuario.COLABORADOR)
  const podeGerenciar = computed(() =>
    [RoleUsuario.RH, RoleUsuario.GESTOR, RoleUsuario.ADMIN].includes(
      usuario.value?.role ?? RoleUsuario.COLABORADOR,
    ),
  )

  // -------------------------------------------------------
  // Actions
  // -------------------------------------------------------
  async function login(payload: LoginRequest): Promise<void> {
    loading.value = true
    erro.value = null
    try {
      const response = await authService.login(payload)
      const usuarioMockado = criarUsuarioMockado(response.token)
      token.value = response.token
      usuario.value = usuarioMockado
      localStorage.setItem('auth_token', response.token)
      localStorage.setItem('auth_user', JSON.stringify(usuarioMockado))
    } catch (e: unknown) {
      erro.value = 'Credenciais inválidas. Verifique seu e-mail e senha.'
      throw e
    } finally {
      loading.value = false
    }
  }

  function logout(): void {
    token.value = null
    usuario.value = null
    localStorage.removeItem('auth_token')
    localStorage.removeItem('auth_user')
  }

  function limparErro(): void {
    erro.value = null
  }

  return {
    token,
    usuario,
    loading,
    erro,
    estaAutenticado,
    nomeUsuario,
    isRH,
    isGestor,
    isAdmin,
    isColaborador,
    podeGerenciar,
    login,
    logout,
    limparErro,
  }
})
