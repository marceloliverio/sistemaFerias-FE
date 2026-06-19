---
name: project-flutter-architecture
description: Arquitetura Feature First do app Flutter — estrutura de pastas, providers, rotas e padroes adotados
metadata:
  type: project
---

# Arquitetura do Projeto Flutter

**Projeto:** `C:\NG\sistema-teste-ferias-FE\mobile_app`

**Por que:** Sistema de Solicitacao de Ferias com state machine no backend. O app apenas exibe estados e dispara eventos.

## Estrutura de pastas

```
lib/
├── main.dart                  — ProviderScope + SistemaFeriasApp
├── app.dart                   — MaterialApp.router (ConsumerWidget)
├── app_router.dart            — GoRouter com redirect guard via AuthTokenStore
├── core/
│   ├── network/
│   │   └── dio_provider.dart  — dioPublicProvider (login) + dioProvider (JWT) + AuthTokenStore
│   └── theme/app_theme.dart
├── features/
│   ├── auth/
│   │   ├── domain/auth_model.dart         — LoginRequest, LoginResponse, UserSession
│   │   ├── application/auth_notifier.dart — authNotifierProvider (NotifierProvider<AuthState>)
│   │   ├── infrastructure/auth_service.dart
│   │   └── presentation/login_page.dart
│   └── vacation/
│       ├── domain/vacation_request.dart   — Freezed: SolicitacaoFeriasResponse/Request, TransicaoEventoRequest, enums
│       ├── application/vacation_notifier.dart — vacationListProvider + vacationDetailProvider(family)
│       ├── infrastructure/vacation_service.dart
│       └── presentation/
│           ├── dashboard_page.dart
│           ├── vacation_list_page.dart
│           ├── vacation_form_page.dart
│           ├── vacation_detail_page.dart
│           └── manage_vacations_page.dart
└── shared/widgets/
    ├── loading_overlay.dart
    ├── status_badge.dart
    ├── error_view.dart
    └── empty_view.dart
```

## Rotas (GoRouter 8.x)

- `/login` — sem autenticacao
- `/dashboard` — pagina inicial pos-login
- `/vacations` — lista
- `/vacations/new` — formulario (antes de /:id para nao conflitar)
- `/vacations/:id` — detalhe com botoes de evento
- `/manage` — gerenciamento admin

**How to apply:** Usar `state.pathParameters['id']` — a versao 8.x removeu `state.params`.
