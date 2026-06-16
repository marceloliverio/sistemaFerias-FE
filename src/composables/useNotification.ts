import { ref } from 'vue'

type TipoNotificacao = 'success' | 'error' | 'warning' | 'info'

interface Notificacao {
  id: number
  mensagem: string
  tipo: TipoNotificacao
  visivel: boolean
}

const notificacoes = ref<Notificacao[]>([])
let contadorId = 0

export function useNotification() {
  function notificar(mensagem: string, tipo: TipoNotificacao = 'info', duracao = 4000): void {
    const id = ++contadorId
    const notificacao: Notificacao = { id, mensagem, tipo, visivel: true }
    notificacoes.value.push(notificacao)

    setTimeout(() => {
      const idx = notificacoes.value.findIndex((n) => n.id === id)
      if (idx !== -1) notificacoes.value.splice(idx, 1)
    }, duracao)
  }

  function remover(id: number): void {
    const idx = notificacoes.value.findIndex((n) => n.id === id)
    if (idx !== -1) notificacoes.value.splice(idx, 1)
  }

  return { notificacoes, notificar, remover }
}
