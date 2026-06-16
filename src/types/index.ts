// ============================================================
// Enums
// ============================================================

export enum StatusSolicitacao {
  RASCUNHO = 'RASCUNHO',
  ENVIADO = 'ENVIADO',
  EM_ANALISE = 'EM_ANALISE',
  APROVADO = 'APROVADO',
  REJEITADO = 'REJEITADO',
  CONCLUIDO = 'CONCLUIDO',
}

// NOTA p/ Backend Agent: a API nao expoe usuario autenticado nem role.
// RoleUsuario e Usuario abaixo sao mockados localmente no frontend
// (ver stores/auth.ts) ate que exista um endpoint real de perfil.
export enum RoleUsuario {
  COLABORADOR = 'COLABORADOR',
  GESTOR = 'GESTOR',
  RH = 'RH',
  ADMIN = 'ADMIN',
}

export enum EventoSolicitacao {
  ENVIAR = 'ENVIAR',
  ANALISAR = 'ANALISAR',
  APROVAR = 'APROVAR',
  REJEITAR = 'REJEITAR',
  CONCLUIR = 'CONCLUIR',
}

// ============================================================
// Entidades
// ============================================================

// Usuario mockado localmente — a API nao expoe usuario/role (ver nota acima).
export interface Usuario {
  id: string
  nome: string
  email: string
  role: RoleUsuario
  departamento?: string
  matricula?: string
}

export interface SolicitacaoFerias {
  id: string
  funcionarioNome: string
  funcionarioCpf: string
  dataInicio: string
  dataFim: string
  status: StatusSolicitacao
  observacao?: string
  createdAt: string
  updatedAt: string
}

// ============================================================
// DTOs de Request
// ============================================================

export interface LoginRequest {
  email: string
  senha: string
}

export interface SolicitacaoFeriasRequest {
  funcionarioNome: string
  funcionarioCpf: string
  dataInicio: string
  dataFim: string
  observacao?: string
}

export interface TransicaoEventoRequest {
  evento: EventoSolicitacao
  observacao?: string
}

// ============================================================
// DTOs de Response
// ============================================================

export interface LoginResponse {
  token: string
  tipo: string
  expiracaoMs: number
}

export interface ApiError {
  message: string
  code?: string
  details?: Record<string, string[]>
}

// ============================================================
// State Machine — transições permitidas por role
// ============================================================

export interface TransicaoPermitida {
  evento: EventoSolicitacao
  label: string
  cor: string
  icone: string
  requerObservacao?: boolean
}

export const TRANSICOES_POR_STATUS: Record<StatusSolicitacao, TransicaoPermitida[]> = {
  [StatusSolicitacao.RASCUNHO]: [
    {
      evento: EventoSolicitacao.ENVIAR,
      label: 'Enviar para Análise',
      cor: 'primary',
      icone: 'mdi-send',
    },
  ],
  [StatusSolicitacao.ENVIADO]: [
    {
      evento: EventoSolicitacao.ANALISAR,
      label: 'Iniciar Análise',
      cor: 'info',
      icone: 'mdi-magnify',
    },
  ],
  [StatusSolicitacao.EM_ANALISE]: [
    {
      evento: EventoSolicitacao.APROVAR,
      label: 'Aprovar',
      cor: 'success',
      icone: 'mdi-check-circle',
    },
    {
      evento: EventoSolicitacao.REJEITAR,
      label: 'Rejeitar',
      cor: 'error',
      icone: 'mdi-close-circle',
      requerObservacao: true,
    },
  ],
  [StatusSolicitacao.APROVADO]: [
    {
      evento: EventoSolicitacao.CONCLUIR,
      label: 'Concluir',
      cor: 'success',
      icone: 'mdi-flag-checkered',
    },
  ],
  [StatusSolicitacao.REJEITADO]: [],
  [StatusSolicitacao.CONCLUIDO]: [],
}
