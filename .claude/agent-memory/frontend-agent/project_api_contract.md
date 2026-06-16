---
name: project-api-contract
description: Contrato REAL de API validado via /v3/api-docs do backend (substitui contrato hipotetico anterior)
metadata:
  type: project
---

Contrato confirmado em 2026-06-16 via `GET http://localhost:8080/v3/api-docs` contra o backend real rodando em `localhost:8080`. Substitui qualquer suposição anterior de paginação, `/auth/me`, CRUD completo etc.

Proxy Vite: `/api` → `http://localhost:8080` (vite.config.ts). `http.ts` usa `baseURL = '/api'`, então os services chamam paths sem o prefixo `/api` (ex: `/auth/login`, `/v1/solicitacoes`).

Endpoints reais:
- POST /api/auth/login — `{ email, senha }` → `{ token, tipo, expiracaoMs }`. Não há `/auth/me`, `/auth/logout`, `/auth/refresh`.
- GET /api/v1/solicitacoes — array direto, sem paginação, sem `/minhas`.
- POST /api/v1/solicitacoes — `{ funcionarioNome, funcionarioCpf (regex \d{3}\.\d{3}\.\d{3}-\d{2}), dataInicio, dataFim, observacao? }` → 201.
- GET /api/v1/solicitacoes/{id} — 200 ou 404. Sem PUT/DELETE.
- GET /api/v1/solicitacoes/status/{status} — status é **path param**, não query.
- POST /api/v1/solicitacoes/{id}/eventos — `{ evento: ENVIAR|ANALISAR|APROVAR|REJEITAR|CONCLUIR, observacao? }`. Não existe `INICIAR_ANALISE` (é `ANALISAR`) nem `VOLTAR_RASCUNHO`. Sem campo `motivoRejeicao` estruturado.

`SolicitacaoFeriasResponse`: `{ id, funcionarioNome, funcionarioCpf, dataInicio, dataFim, status, observacao?, createdAt, updatedAt }`. NÃO tem `colaboradorId`, `colaborador`, `diasSolicitados`, `motivoRejeicao`, `aprovadorId`, `aprovador`.

Erros: formato RFC 7807 Problem Details (`{ type, title, status, detail, instance }`), não `{ message, code, details }`. O `ApiError` em `types/index.ts` ainda usa o formato antigo mas só é usado para tipar o interceptor de 401 (não lê campos do body) — se algum dia precisar exibir mensagem de erro do backend, ajustar para ler `detail`/`title`.

A API **não expõe usuário autenticado nem role** — só o JWT com `sub` = email. Ver [[project_roles_mock]].

**Why:** Esse documento existe para o Backend Agent e para futuras sessões não recriarem o contrato hipotético antigo.

**How to apply:** Sempre validar contra `/v3/api-docs` antes de assumir qualquer endpoint/campo novo. Nunca reintroduzir paginação, `/minhas`, PUT/DELETE de solicitações, ou os campos removidos, a menos que o backend realmente passe a expô-los.
