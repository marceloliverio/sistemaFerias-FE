import http from './http'
import type {
  SolicitacaoFerias,
  SolicitacaoFeriasRequest,
  TransicaoEventoRequest,
  StatusSolicitacao,
} from '@/types'

// NOTA: API nao tem paginacao, /minhas, PUT nem DELETE — apenas os
// endpoints abaixo existem (confirmado via /v3/api-docs).
export const solicitacaoService = {
  async listar(): Promise<SolicitacaoFerias[]> {
    const { data } = await http.get<SolicitacaoFerias[]>('/v1/solicitacoes')
    return data
  },

  async listarPorStatus(status: StatusSolicitacao): Promise<SolicitacaoFerias[]> {
    const { data } = await http.get<SolicitacaoFerias[]>(`/v1/solicitacoes/status/${status}`)
    return data
  },

  async buscarPorId(id: string): Promise<SolicitacaoFerias> {
    const { data } = await http.get<SolicitacaoFerias>(`/v1/solicitacoes/${id}`)
    return data
  },

  async criar(payload: SolicitacaoFeriasRequest): Promise<SolicitacaoFerias> {
    const { data } = await http.post<SolicitacaoFerias>('/v1/solicitacoes', payload)
    return data
  },

  // -------------------------------------------------------
  // Transições de estado (State Machine)
  // -------------------------------------------------------
  async dispararEvento(id: string, payload: TransicaoEventoRequest): Promise<SolicitacaoFerias> {
    const { data } = await http.post<SolicitacaoFerias>(
      `/v1/solicitacoes/${id}/eventos`,
      payload,
    )
    return data
  },
}
