---
name: feedback-dio-auth-circular
description: Solucao para dependencia circular entre dioProvider (precisa do token) e authNotifierProvider (usa o Dio para login)
metadata:
  type: feedback
---

# Dependencia Circular Dio / Auth

## Regra

Usar dois providers de Dio separados + uma classe store estatica para o token.

**Why:** Se `dioProvider` importa `authNotifierProvider` para ler o token, e `authNotifierProvider` importa `authServiceProvider` que importa `dioProvider`, criamos um ciclo que o Riverpod nao consegue resolver.

## Solucao adotada

1. `dioPublicProvider` — Dio sem interceptor JWT, usado apenas por `AuthService.login()`
2. `dioProvider` — Dio com `InterceptorsWrapper` que le `AuthTokenStore.token` (campo estatico simples)
3. `AuthTokenStore` — classe com campo estatico `static String? token` declarada em `dio_provider.dart`
4. `AuthNotifier.login()` grava `AuthTokenStore.token = response.token` apos sucesso
5. `AuthNotifier.logout()` zera `AuthTokenStore.token = null`

**How to apply:** Sempre que precisar acessar o token fora do Riverpod (ex: redirect do router, interceptors), usar `AuthTokenStore.token`. Dentro de providers Riverpod, usar `ref.watch(authNotifierProvider).token`.
