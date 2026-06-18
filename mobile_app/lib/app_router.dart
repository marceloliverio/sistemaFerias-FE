import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'core/network/dio_provider.dart';
import 'features/auth/presentation/login_page.dart';
import 'features/vacation/presentation/dashboard_page.dart';
import 'features/vacation/presentation/manage_vacations_page.dart';
import 'features/vacation/presentation/vacation_detail_page.dart';
import 'features/vacation/presentation/vacation_form_page.dart';
import 'features/vacation/presentation/vacation_list_page.dart';

/// Chave global para o navigator — usada pelo redirect guard
final _rootNavigatorKey = GlobalKey<NavigatorState>();

/// Router principal da aplicacao
///
/// Rotas:
///   /login          — tela de autenticacao
///   /dashboard      — dashboard com resumo e acoes rapidas
///   /vacations      — lista de solicitacoes
///   /vacations/new  — formulario de criacao (deve ser declarado ANTES de /:id)
///   /vacations/:id  — detalhe da solicitacao
///   /manage         — gerenciamento admin
final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/login',
  debugLogDiagnostics: true,
  redirect: (context, state) {
    // Guard simples — verifica o token no AuthTokenStore
    // Para redirect reativo, consultar o provider via ProviderScope
    final isAuthenticated = AuthTokenStore.token != null;
    final isOnLogin = state.matchedLocation == '/login';

    if (!isAuthenticated && !isOnLogin) {
      return '/login';
    }
    if (isAuthenticated && isOnLogin) {
      return '/dashboard';
    }
    return null;
  },
  routes: [
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/dashboard',
      name: 'dashboard',
      builder: (context, state) => const DashboardPage(),
    ),
    GoRoute(
      path: '/vacations',
      name: 'vacations',
      builder: (context, state) => const VacationListPage(),
      routes: [
        // IMPORTANTE: '/new' deve vir antes de '/:id' para nao conflitar
        GoRoute(
          path: 'new',
          name: 'vacation-new',
          builder: (context, state) => const VacationFormPage(),
        ),
        GoRoute(
          path: ':id',
          name: 'vacation-detail',
          builder: (context, state) {
            // go_router ^8.x usa state.pathParameters
            final id = state.pathParameters['id'] ?? '';
            return VacationDetailPage(vacationId: id);
          },
        ),
      ],
    ),
    GoRoute(
      path: '/manage',
      name: 'manage',
      builder: (context, state) => const ManageVacationsPage(),
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(title: const Text('Pagina nao encontrada')),
    body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text('Rota nao encontrada: ${state.matchedLocation}'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => GoRouter.of(context).go('/dashboard'),
            child: const Text('Ir para o inicio'),
          ),
        ],
      ),
    ),
  ),
);
