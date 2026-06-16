---
name: project-roles-mock
description: Decisao de produto sobre roles/usuario mockados no frontend ate a API expor endpoint de perfil
metadata:
  type: project
---

A API real não expõe usuário autenticado nem role (RH/Gestor/Admin/Colaborador). O JWT retornado por POST /api/auth/login só contém `sub` (email) no payload — sem nome, sem role, sem id de usuário.

Decisão de produto validada com o usuário (2026-06-16): manter a estrutura de UI baseada em role no código (menu lateral com item "Gerenciar", guard `requiresGerenciar` no router, página GerenciarSolicitacoesPage) em vez de removê-la, mas fazê-la funcionar sem fonte real de role.

Implementação: `stores/auth.ts` decodifica o `sub` (email) do JWT localmente (decode manual, sem lib) e monta um `Usuario` mockado com `role: RoleUsuario.ADMIN` fixo — ou seja, hoje todo usuário autenticado tem acesso total (`podeGerenciar` sempre true). `TransicaoEventos.vue` também não filtra mais transições por "dono" da solicitação, pois não existe `colaboradorId` para comparar.

**Why:** Não inventar um endpoint de role que não existe, mas também não descartar trabalho de UI já construído — o usuário quer a estrutura pronta para quando o backend expuser o dado real.

**How to apply:** Sempre que tocar em `stores/auth.ts`, `router/index.ts` (guard requiresGerenciar) ou `DefaultLayout.vue`, lembrar que a role é 100% mockada client-side. Não promover esse mock a "fonte de verdade" em decisões de produto futuras — é um placeholder. Backend Agent precisa expor endpoint de perfil/role (ex: GET /api/auth/me ou similar) para isso funcionar de verdade.
