---
name: project-state-machine
description: Fluxo de estados da SolicitacaoFerias e responsabilidades frontend vs backend
metadata:
  type: project
---

State Machine real (confirmada via /v3/api-docs em 2026-06-16): RASCUNHO --[ENVIAR]--> ENVIADO --[ANALISAR]--> EM_ANALISE --[APROVAR]--> APROVADO --[CONCLUIR]--> CONCLUIDO, ou EM_ANALISE --[REJEITAR]--> REJEITADO (sem volta).

Eventos reais: ENVIAR, ANALISAR, APROVAR, REJEITAR, CONCLUIR. NÃO existe INICIAR_ANALISE (era suposição antiga, renomeado para ANALISAR) nem VOLTAR_RASCUNHO (não existe, removido do TRANSICOES_POR_STATUS — REJEITADO e CONCLUIDO são estados terminais na UI).

Endpoint de transição real: POST /api/v1/solicitacoes/{id}/eventos com body `{ evento, observacao? }` — não há `motivoRejeicao` estruturado, é só `observacao` genérico reaproveitado pela UI quando `requerObservacao: true`.

O frontend apenas EXIBE estados e DISPARA eventos. A lógica de transição pertence ao backend (Spring State Machine).

**Why:** Arquitetura deliberada para manter lógica de negócio centralizada no backend.

**How to apply:** Nunca implementar validação de transição no frontend. Sempre usar TRANSICOES_POR_STATUS (types/index.ts) apenas para saber quais botões mostrar — validação real é no backend. Ver [[project_api_contract]] para o contrato completo.
