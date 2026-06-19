import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/theme/app_theme.dart';
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
        title: const Text('SOLICITAÇÃO DE FÉRIAS'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Atualizar',
            onPressed: () =>
                ref.read(vacationListProvider.notifier).refresh(),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.account_circle_outlined),
            offset: const Offset(0, 48),
            itemBuilder: (_) => [
              PopupMenuItem(
                value: 'logout',
                child: const Row(
                  children: [
                    Icon(Icons.logout, size: 18, color: AppColors.primary),
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
        label: const Text('Nova Solicitação'),
      ),
      body: vacationsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => ErrorView(
          message: 'Erro ao carregar solicitações.\n$error',
          onRetry: () => ref.read(vacationListProvider.notifier).refresh(),
        ),
        data: (vacations) => _DashboardContent(
          vacations: vacations,
          userName: authState.userName ?? 'Usuário',
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner de boas-vindas
          Container(
            width: double.infinity,
            color: AppColors.primaryDark,
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: const Icon(
                    Icons.person_outlined,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName.toUpperCase(),
                        style: const TextStyle(
                          color: AppColors.textOnDark,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Bem-vindo',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.6),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Resumo de status
                _SectionHeader(
                  title: 'RESUMO',
                  color: AppColors.primary,
                ),
                const SizedBox(height: 12),
                _StatusCountGrid(
                    countByStatus: countByStatus, total: vacations.length),
                const SizedBox(height: 24),

                // Ações rápidas
                _SectionHeader(
                  title: 'AÇÕES RÁPIDAS',
                  color: AppColors.primary,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _ActionCard(
                        icon: Icons.list_alt_outlined,
                        label: 'Ver Todas',
                        onTap: () => GoRouter.of(context).go('/vacations'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _ActionCard(
                        icon: Icons.manage_accounts_outlined,
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
                    _SectionHeader(
                      title: 'RECENTES',
                      color: AppColors.primary,
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
                    child: Center(
                      child: Text('Nenhuma solicitação encontrada.'),
                    ),
                  )
                else
                  ...recentVacations.map(
                    (v) => _RecentCard(
                      vacation: v,
                      onTap: () =>
                          GoRouter.of(context).push('/vacations/${v.id}'),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final Color color;

  const _SectionHeader({required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 3,
          height: 18,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
                letterSpacing: 0.8,
              ),
        ),
      ],
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
      (label: 'Total', count: total, color: AppColors.primary),
      (
        label: 'Rascunho',
        count: countByStatus[VacationStatus.rascunho] ?? 0,
        color: AppColors.onSurfaceVariant
      ),
      (
        label: 'Enviado',
        count: countByStatus[VacationStatus.enviado] ?? 0,
        color: AppColors.accent
      ),
      (
        label: 'Em Análise',
        count: countByStatus[VacationStatus.emAnalise] ?? 0,
        color: const Color(0xFFE67E00)
      ),
      (
        label: 'Aprovado',
        count: countByStatus[VacationStatus.aprovado] ?? 0,
        color: const Color(0xFF2E7D32)
      ),
      (
        label: 'Rejeitado',
        count: countByStatus[VacationStatus.rejeitado] ?? 0,
        color: AppColors.errorRed
      ),
    ];

    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      childAspectRatio: 1.2,
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
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Center(
                child: Text(
                  count.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.onSurfaceVariant,
                  ),
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
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
          child: Column(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Icon(icon, size: 24, color: AppColors.primary),
              ),
              const SizedBox(height: 10),
              Text(
                label,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
              ),
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
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.primaryDark,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Icon(
            Icons.beach_access_outlined,
            color: Colors.white,
            size: 20,
          ),
        ),
        title: Text(
          vacation.funcionarioNome,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          '${vacation.dataInicio} até ${vacation.dataFim}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: StatusBadge(status: vacation.status),
      ),
    );
  }
}
