import { useRouter } from 'vue-router'
import { useSolicitacoesStore } from '@/stores/solicitacoes'
import { useNotification } from '@/composables/useNotification'
import type { SolicitacaoFeriasRequest, StatusSolicitacao } from '@/types'
import { EventoSolicitacao } from '@/types'

export function useSolicitacaoFerias() {
  const store = useSolicitacoesStore()
  const router = useRouter()
  const { notificar } = useNotification()

  // -------------------------------------------------------
  // Consulta / criação
  // -------------------------------------------------------
  async function carregarLista(status?: StatusSolicitacao): Promise<void> {
    await store.buscarLista(status)
  }

  async function carregarDetalhe(id: string): Promise<void> {
    await store.buscarPorId(id)
  }

  async function criarSolicitacao(payload: SolicitacaoFeriasRequest): Promise<void> {
    const nova = await store.criar(payload)
    notificar('Solicitação criada com sucesso!', 'success')
    await router.push({ name: 'solicitacao-detalhe', params: { id: nova.id } })
  }

  // -------------------------------------------------------
  // Transições State Machine
  // -------------------------------------------------------
  async function enviar(id: string): Promise<void> {
    await store.dispararEvento(id, { evento: EventoSolicitacao.ENVIAR })
    notificar('Solicitação enviada para análise!', 'success')
  }

  async function analisar(id: string): Promise<void> {
    await store.dispararEvento(id, { evento: EventoSolicitacao.ANALISAR })
    notificar('Análise iniciada!', 'info')
  }

  async function aprovar(id: string, observacao?: string): Promise<void> {
    await store.dispararEvento(id, { evento: EventoSolicitacao.APROVAR, observacao })
    notificar('Solicitação aprovada!', 'success')
  }

  async function rejeitar(id: string, observacao: string): Promise<void> {
    await store.dispararEvento(id, { evento: EventoSolicitacao.REJEITAR, observacao })
    notificar('Solicitação rejeitada.', 'warning')
  }

  async function concluir(id: string): Promise<void> {
    await store.dispararEvento(id, { evento: EventoSolicitacao.CONCLUIR })
    notificar('Solicitação concluída!', 'success')
  }

  return {
    lista: store.lista,
    atual: store.atual,
    loading: store.loading,
    loadingAcao: store.loadingAcao,
    erro: store.erro,
    carregarLista,
    carregarDetalhe,
    criarSolicitacao,
    enviar,
    analisar,
    aprovar,
    rejeitar,
    concluir,
    limparAtual: store.limparAtual,
    limparErro: store.limparErro,
  }
}
