import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/theme/app_theme.dart';
import '../application/vacation_notifier.dart';
import '../domain/vacation_request.dart';
import '../../../shared/widgets/error_view.dart';
import '../../../shared/widgets/empty_view.dart';
import '../../../shared/widgets/status_badge.dart';

class ManageVacationsPage extends ConsumerWidget {
  const ManageVacationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vacationsAsync = ref.watch(vacationListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('GERENCIAR'),
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
      body: vacationsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => ErrorView(
          message: 'Erro ao carregar solicitacoes.\n$error',
          onRetry: () => ref.read(vacationListProvider.notifier).refresh(),
        ),
        data: (vacations) {
          if (vacations.isEmpty) {
            return const EmptyView(
              message: 'Nenhuma solicitacao para gerenciar.',
              icon: Icons.manage_accounts_outlined,
            );
          }

          // Agrupa pendentes (que podem receber acao) no topo
          final pending = vacations
              .where((v) =>
                  v.status != VacationStatus.concluido &&
                  v.status != VacationStatus.rejeitado)
              .toList();
          final finished = vacations
              .where((v) =>
                  v.status == VacationStatus.concluido ||
                  v.status == VacationStatus.rejeitado)
              .toList();

          return RefreshIndicator(
            onRefresh: () =>
                ref.read(vacationListProvider.notifier).refresh(),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
              children: [
                if (pending.isNotEmpty) ...[
                  _SectionHeader(
                    title: 'PENDENTES (${pending.length})',
                    color: AppColors.primary,
                  ),
                  const SizedBox(height: 8),
                  ...pending.map(
                    (v) => _ManageCard(
                      vacation: v,
                      onViewDetail: () =>
                          context.push('/vacations/${v.id}'),
                      onDispatch: (event, observacao) async {
                        try {
                          await ref
                              .read(vacationListProvider.notifier)
                              .dispatchEvent(
                                v.id,
                                TransicaoEventoRequest(
                                  evento: event,
                                  observacao: observacao,
                                ),
                              );
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Acao aplicada com sucesso!'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          }
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Erro: $e'),
                                backgroundColor:
                                    Theme.of(context).colorScheme.error,
                              ),
                            );
                          }
                        }
                      },
                    ),
                  ),
                ],
                if (finished.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  _SectionHeader(
                    title: 'ENCERRADAS (${finished.length})',
                    color: AppColors.onSurfaceVariant,
                  ),
                  const SizedBox(height: 8),
                  ...finished.map(
                    (v) => _ManageCard(
                      vacation: v,
                      onViewDetail: () =>
                          context.push('/vacations/${v.id}'),
                      onDispatch: null,
                    ),
                  ),
                ],
              ],
            ),
          );
        },
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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _ManageCard extends StatefulWidget {
  final SolicitacaoFeriasResponse vacation;
  final VoidCallback onViewDetail;
  final Future<void> Function(VacationEvent event, String? observacao)?
      onDispatch;

  const _ManageCard({
    required this.vacation,
    required this.onViewDetail,
    required this.onDispatch,
  });

  @override
  State<_ManageCard> createState() => _ManageCardState();
}

class _ManageCardState extends State<_ManageCard> {
  bool _isActing = false;

  List<_QuickAction> get _quickActions {
    switch (widget.vacation.status) {
      case VacationStatus.rascunho:
        return [
          const _QuickAction(
            event: VacationEvent.enviar,
            label: 'Enviar',
            icon: Icons.send,
            color: Colors.blue,
            requiresObservacao: false,
          ),
        ];
      case VacationStatus.enviado:
        return [
          const _QuickAction(
            event: VacationEvent.analisar,
            label: 'Analisar',
            icon: Icons.manage_search,
            color: Colors.orange,
            requiresObservacao: false,
          ),
        ];
      case VacationStatus.emAnalise:
        return [
          const _QuickAction(
            event: VacationEvent.aprovar,
            label: 'Aprovar',
            icon: Icons.check_circle,
            color: Colors.green,
            requiresObservacao: false,
          ),
          const _QuickAction(
            event: VacationEvent.rejeitar,
            label: 'Rejeitar',
            icon: Icons.cancel,
            color: Colors.red,
            requiresObservacao: true,
          ),
        ];
      case VacationStatus.aprovado:
        return [
          const _QuickAction(
            event: VacationEvent.concluir,
            label: 'Concluir',
            icon: Icons.done_all,
            color: Colors.purple,
            requiresObservacao: false,
          ),
        ];
      case VacationStatus.rejeitado:
      case VacationStatus.concluido:
        return [];
    }
  }

  Future<void> _handleAction(_QuickAction action) async {
    String? observacao;

    if (action.requiresObservacao) {
      final controller = TextEditingController();
      observacao = await showDialog<String>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(action.label),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Motivo (obrigatorio):'),
              const SizedBox(height: 12),
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: 'Digite o motivo...',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                autofocus: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(null),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () {
                if (controller.text.trim().isEmpty) return;
                Navigator.of(ctx).pop(controller.text.trim());
              },
              child: const Text('Confirmar'),
            ),
          ],
        ),
      );
      if (observacao == null) return;
    }

    setState(() => _isActing = true);
    try {
      await widget.onDispatch?.call(action.event, observacao);
    } finally {
      if (mounted) setState(() => _isActing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.vacation.funcionarioNome,
                        style:
                            Theme.of(context).textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        widget.vacation.funcionarioCpf,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withValues(alpha: 0.6),
                            ),
                      ),
                    ],
                  ),
                ),
                StatusBadge(status: widget.vacation.status),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 12),
                const SizedBox(width: 4),
                Text(
                  '${widget.vacation.dataInicio} ate ${widget.vacation.dataFim}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),

            // Botoes de acao rapida
            if (_quickActions.isNotEmpty && widget.onDispatch != null) ...[
              const SizedBox(height: 10),
              const Divider(height: 1),
              const SizedBox(height: 8),
              Row(
                children: [
                  TextButton.icon(
                    onPressed: widget.onViewDetail,
                    icon: const Icon(Icons.visibility_outlined, size: 16),
                    label: const Text('Ver'),
                    style: TextButton.styleFrom(
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
                  const Spacer(),
                  ..._quickActions.map(
                    (action) => Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: _isActing
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : FilledButton.tonalIcon(
                              onPressed: () => _handleAction(action),
                              icon: Icon(action.icon, size: 16),
                              label: Text(action.label),
                              style: FilledButton.styleFrom(
                                backgroundColor:
                                    action.color.withValues(alpha: 0.15),
                                foregroundColor: action.color,
                                visualDensity: VisualDensity.compact,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ] else ...[
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: widget.onViewDetail,
                  icon: const Icon(Icons.visibility_outlined, size: 16),
                  label: const Text('Ver detalhes'),
                  style: TextButton.styleFrom(
                    visualDensity: VisualDensity.compact,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _QuickAction {
  final VacationEvent event;
  final String label;
  final IconData icon;
  final Color color;
  final bool requiresObservacao;

  const _QuickAction({
    required this.event,
    required this.label,
    required this.icon,
    required this.color,
    required this.requiresObservacao,
  });
}
