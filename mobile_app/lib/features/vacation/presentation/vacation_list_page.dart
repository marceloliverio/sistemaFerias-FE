import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../application/vacation_notifier.dart';
import '../domain/vacation_request.dart';
import '../../../shared/widgets/error_view.dart';
import '../../../shared/widgets/empty_view.dart';
import '../../../shared/widgets/status_badge.dart';

class VacationListPage extends ConsumerWidget {
  const VacationListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vacationsAsync = ref.watch(vacationListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Solicitacoes de Ferias'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/dashboard'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Atualizar',
            onPressed: () =>
                ref.read(vacationListProvider.notifier).refresh(),
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
        data: (vacations) {
          if (vacations.isEmpty) {
            return EmptyView(
              message: 'Nenhuma solicitacao encontrada.',
              icon: Icons.beach_access,
              action: FilledButton.icon(
                onPressed: () => context.push('/vacations/new'),
                icon: const Icon(Icons.add),
                label: const Text('Criar solicitacao'),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () =>
                ref.read(vacationListProvider.notifier).refresh(),
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
              itemCount: vacations.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                return _VacationCard(
                  vacation: vacations[index],
                  onTap: () =>
                      context.push('/vacations/${vacations[index].id}'),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _VacationCard extends StatelessWidget {
  final SolicitacaoFeriasResponse vacation;
  final VoidCallback onTap;

  const _VacationCard({required this.vacation, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      vacation.funcionarioNome,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  StatusBadge(status: vacation.status),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                'CPF: ${vacation.funcionarioCpf}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.6),
                    ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 14),
                  const SizedBox(width: 4),
                  Text(
                    '${vacation.dataInicio} ate ${vacation.dataFim}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              if (vacation.observacao != null &&
                  vacation.observacao!.isNotEmpty) ...[
                const SizedBox(height: 6),
                Text(
                  vacation.observacao!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
