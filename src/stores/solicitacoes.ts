import { defineStore } from 'pinia'
import { ref } from 'vue'
import type {
  SolicitacaoFerias,
  SolicitacaoFeriasRequest,
  TransicaoEventoRequest,
  StatusSolicitacao,
} from '@/types'
import { solicitacaoService } from '@/services/solicitacaoService'

// NOTA: a API não tem paginação nem endpoint /minhas — não há vínculo entre
// usuário autenticado e solicitação (não existe colaboradorId no schema real).
// A lista abaixo é única; filtragem por status pode usar listarPorStatus.
export const useSolicitacoesStore = defineStore('solicitacoes', () => {
  // -------------------------------------------------------
  // State
  // -------------------------------------------------------
  const lista = ref<SolicitacaoFerias[]>([])
  const atual = ref<SolicitacaoFerias | null>(null)
  const loading = ref(false)
  const loadingAcao = ref(false)
  const erro = ref<string | null>(null)

  // -------------------------------------------------------
  // Actions
  // -------------------------------------------------------
  async function buscarLista(status?: StatusSolicitacao): Promise<void> {
    loading.value = true
    erro.value = null
    try {
      lista.value = status
        ? await solicitacaoService.listarPorStatus(status)
        : await solicitacaoService.listar()
    } catch (e: unknown) {
      erro.value = 'Erro ao carregar solicitações.'
      throw e
    } finally {
      loading.value = false
    }
  }

  async function buscarPorId(id: string): Promise<void> {
    loading.value = true
    erro.value = null
    try {
      atual.value = await solicitacaoService.buscarPorId(id)
    } catch (e: unknown) {
      erro.value = 'Solicitação não encontrada.'
      throw e
    } finally {
      loading.value = false
    }
  }

  async function criar(payload: SolicitacaoFeriasRequest): Promise<SolicitacaoFerias> {
    loadingAcao.value = true
    erro.value = null
    try {
      const nova = await solicitacaoService.criar(payload)
      lista.value.unshift(nova)
      return nova
    } catch (e: unknown) {
      erro.value = 'Erro ao criar solicitação.'
      throw e
    } finally {
      loadingAcao.value = false
    }
  }

  async function dispararEvento(id: string, payload: TransicaoEventoRequest): Promise<void> {
    loadingAcao.value = true
    erro.value = null
    try {
      const atualizada = await solicitacaoService.dispararEvento(id, payload)
      atual.value = atualizada
      atualizarNaLista(atualizada)
    } catch (e: unknown) {
      erro.value = 'Erro ao processar ação na solicitação.'
      throw e
    } finally {
      loadingAcao.value = false
    }
  }

  function limparAtual(): void {
    atual.value = null
  }

  function limparErro(): void {
    erro.value = null
  }

  // -------------------------------------------------------
  // Helpers privados
  // -------------------------------------------------------
  function atualizarNaLista(atualizada: SolicitacaoFerias): void {
    const idx = lista.value.findIndex((s) => s.id === atualizada.id)
    if (idx !== -1) lista.value[idx] = atualizada
  }

  return {
    lista,
    atual,
    loading,
    loadingAcao,
    erro,
    buscarLista,
    buscarPorId,
    criar,
    dispararEvento,
    limparAtual,
    limparErro,
  }
})
