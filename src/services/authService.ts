import http from './http'
import type { LoginRequest, LoginResponse } from '@/types'

// NOTA p/ Backend Agent: nao existem /auth/me, /auth/logout ou /auth/refresh
// na API real. Login retorna apenas { token, tipo, expiracaoMs }.
export const authService = {
  async login(payload: LoginRequest): Promise<LoginResponse> {
    const { data } = await http.post<LoginResponse>('/auth/login', payload)
    return data
  },
}
