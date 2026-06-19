---
name: api-contract
description: Contrato real da API backend — endpoints, DTOs e campos exatos (verificado via OpenAPI)
metadata:
  type: reference
---

# Contrato da API Backend

**Base URL:** `http://localhost:8080`

## Auth

```
POST /api/auth/login
Body: { "email": string, "senha": string }
Response 200: { "token": string, "tipo": string, "expiracaoMs": number }
```

JWT: campo `sub` contem o nome/email. Nao existe endpoint /auth/me — decodificar localmente.

## Solicitacoes de Ferias

```
GET    /api/v1/solicitacoes
POST   /api/v1/solicitacoes
GET    /api/v1/solicitacoes/{id}
POST   /api/v1/solicitacoes/{id}/eventos
GET    /api/v1/solicitacoes/status/{status}
```

## DTOs

**SolicitacaoFeriasRequest (POST body):**
```json
{ "funcionarioNome": string, "funcionarioCpf": string, "dataInicio": string, "dataFim": string, "observacao": string? }
```

**SolicitacaoFeriasResponse:**
```json
{ "id": string, "funcionarioNome": string, "funcionarioCpf": string, "dataInicio": string, "dataFim": string, "status": enum, "observacao": string?, "createdAt": string, "updatedAt": string }
```

**TransicaoEventoRequest:**
```json
{ "evento": "ENVIAR"|"ANALISAR"|"APROVAR"|"REJEITAR"|"CONCLUIR", "observacao": string? }
```

## State Machine

- RASCUNHO → ENVIADO (ENVIAR)
- ENVIADO → EM_ANALISE (ANALISAR)
- EM_ANALISE → APROVADO (APROVAR)
- EM_ANALISE → REJEITADO (REJEITAR, requer observacao)
- APROVADO → CONCLUIDO (CONCLUIR)

**Erros:** RFC 7807 `{ type, title, status, detail, instance }`

**How to apply:** Nunca inventar endpoints ou campos. Usar exatamente esses nomes.
