import { StatusSolicitacao } from '@/types'

export function formatarData(dateStr: string): string {
  if (!dateStr) return '-'
  const [year, month, day] = dateStr.split('T')[0].split('-')
  return `${day}/${month}/${year}`
}

export function formatarDataHora(dateStr: string): string {
  if (!dateStr) return '-'
  const date = new Date(dateStr)
  return date.toLocaleString('pt-BR')
}

export function statusLabel(status: StatusSolicitacao): string {
  const labels: Record<StatusSolicitacao, string> = {
    [StatusSolicitacao.RASCUNHO]: 'Rascunho',
    [StatusSolicitacao.ENVIADO]: 'Enviado',
    [StatusSolicitacao.EM_ANALISE]: 'Em Análise',
    [StatusSolicitacao.APROVADO]: 'Aprovado',
    [StatusSolicitacao.REJEITADO]: 'Rejeitado',
    [StatusSolicitacao.CONCLUIDO]: 'Concluído',
  }
  return labels[status] ?? status
}

export function statusCor(status: StatusSolicitacao): string {
  const cores: Record<StatusSolicitacao, string> = {
    [StatusSolicitacao.RASCUNHO]: 'grey',
    [StatusSolicitacao.ENVIADO]: 'blue',
    [StatusSolicitacao.EM_ANALISE]: 'orange',
    [StatusSolicitacao.APROVADO]: 'green',
    [StatusSolicitacao.REJEITADO]: 'red',
    [StatusSolicitacao.CONCLUIDO]: 'teal',
  }
  return cores[status] ?? 'grey'
}

export function calcularDias(dataInicio: string, dataFim: string): number {
  const inicio = new Date(dataInicio)
  const fim = new Date(dataFim)
  const diffMs = fim.getTime() - inicio.getTime()
  return Math.ceil(diffMs / (1000 * 60 * 60 * 24)) + 1
}

// Aplica a máscara 123.456.789-00 conforme o usuário digita.
export function mascararCpf(value: string): string {
  const digitos = value.replace(/\D/g, '').slice(0, 11)
  const partes = [
    digitos.slice(0, 3),
    digitos.slice(3, 6),
    digitos.slice(6, 9),
    digitos.slice(9, 11),
  ]
  let resultado = partes[0]
  if (partes[1]) resultado += `.${partes[1]}`
  if (partes[2]) resultado += `.${partes[2]}`
  if (partes[3]) resultado += `-${partes[3]}`
  return resultado
}
