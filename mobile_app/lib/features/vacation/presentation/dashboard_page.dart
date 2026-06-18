import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../features/auth/application/auth_notifier.dart';
import '../application/vacation_notifier.dart';
import '../domain/vacation_request.dart';
import '../../../shared/widgets/error_view.dart';
import '../../../shared/widgets/status_badge.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final vacationsAsync = ref.watch(vacationListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Atualizar',
            onPressed: () =>
                ref.read(vacationListProvider.notifier).refresh(),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.account_circle_outlined),
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout, size: 18),
                    SizedBox(width: 8),
                    Text('Sair'),
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              if (value == 'logout') {
                ref.read(authNotifierProvider.notifier).logout();
                context.go('/login');
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/vacations/new'),
        icon: const Icon(Icons.add),
        label: const Text('Nova Solicitacao'),
      ),
      body: vacationsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => ErrorView(
          message: 'Erro ao carregar solicitacoes.\n$error',
          onRetry: () => ref.read(vacationListProvider.notifier).refresh(),
        ),
        data: (vacations) => _DashboardContent(
          vacations: vacations,
          userName: authState.userName ?? 'Usuario',
        ),
      ),
    );
  }
}

class _DashboardContent extends StatelessWidget {
  final List<SolicitacaoFeriasResponse> vacations;
  final String userName;

  const _DashboardContent({
    required this.vacations,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    final countByStatus = <VacationStatus, int>{};
    for (final v in vacations) {
      countByStatus[v.status] = (countByStatus[v.status] ?? 0) + 1;
    }

    final recentVacations = vacations.take(5).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Saudacao
          Text(
            'Ola, $userName',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            'Gerencie as solicitacoes de ferias',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                ),
          ),
          const SizedBox(height: 24),

          // Cards de contagem por status
          Text(
            'Resumo',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          _StatusCountGrid(countByStatus: countByStatus, total: vacations.length),
          const SizedBox(height: 24),

          // Acoes rapidas
          Text(
            'Acoes rapidas',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _ActionCard(
                  icon: Icons.list_alt,
                  label: 'Ver Todas',
                  onTap: () => GoRouter.of(context).go('/vacations'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _ActionCard(
                  icon: Icons.manage_accounts,
                  label: 'Gerenciar',
                  onTap: () => GoRouter.of(context).go('/manage'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Recentes
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recentes',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              TextButton(
                onPressed: () => GoRouter.of(context).go('/vacations'),
                child: const Text('Ver todas'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (recentVacations.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(child: Text('Nenhuma solicitacao encontrada.')),
            )
          else
            ...recentVacations.map(
              (v) => _RecentCard(
                vacation: v,
                onTap: () => GoRouter.of(context).push('/vacations/${v.id}'),
              ),
            ),
        ],
      ),
    );
  }
}

class _StatusCountGrid extends StatelessWidget {
  final Map<VacationStatus, int> countByStatus;
  final int total;

  const _StatusCountGrid({
    required this.countByStatus,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      (label: 'Total', count: total, color: Theme.of(context).colorScheme.primary),
      (label: 'Rascunho', count: countByStatus[VacationStatus.rascunho] ?? 0, color: Colors.grey),
      (label: 'Enviado', count: countByStatus[VacationStatus.enviado] ?? 0, color: Colors.blue),
      (label: 'Em Analise', count: countByStatus[VacationStatus.emAnalise] ?? 0, color: Colors.orange),
      (label: 'Aprovado', count: countByStatus[VacationStatus.aprovado] ?? 0, color: Colors.green),
      (label: 'Rejeitado', count: countByStatus[VacationStatus.rejeitado] ?? 0, color: Colors.red),
    ];

    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      childAspectRatio: 1.3,
      children: items
          .map((item) => _StatusCountCard(
                label: item.label,
                count: item.count,
                color: item.color,
              ))
          .toList(),
    );
  }
}

class _StatusCountCard extends StatelessWidget {
  final String label;
  final int count;
  final Color color;

  const _StatusCountCard({
    required this.label,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              count.toString(),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelSmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionCard({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
          child: Column(
            children: [
              Icon(icon, size: 32, color: Theme.of(context).colorScheme.primary),
              const SizedBox(height: 8),
              Text(label, style: Theme.of(context).textTheme.labelLarge),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecentCard extends StatelessWidget {
  final SolicitacaoFeriasResponse vacation;
  final VoidCallback onTap;

  const _RecentCard({required this.vacation, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        onTap: onTap,
        title: Text(
          vacation.funcionarioNome,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          '${vacation.dataInicio} ate ${vacation.dataFim}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: StatusBadge(status: vacation.status),
      ),
    );
  }
}
