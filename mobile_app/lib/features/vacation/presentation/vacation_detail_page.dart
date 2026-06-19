import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/theme/app_theme.dart';
import '../application/vacation_notifier.dart';
import '../domain/vacation_request.dart';
import '../../../shared/widgets/error_view.dart';
import '../../../shared/widgets/status_badge.dart';

class VacationDetailPage extends HookConsumerWidget {
  final String vacationId;

  const VacationDetailPage({super.key, required this.vacationId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(vacationDetailProvider(vacationId));
    final isActing = useState(false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('DETALHES'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.canPop() ? context.pop() : context.go('/vacations'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () =>
                ref.read(vacationDetailProvider(vacationId).notifier).refresh(),
          ),
        ],
      ),
      body: detailAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => ErrorView(
          message: 'Erro ao carregar detalhes.\n$error',
          onRetry: () =>
              ref.read(vacationDetailProvider(vacationId).notifier).refresh(),
        ),
        data: (vacation) => _DetailContent(
          vacation: vacation,
          isActing: isActing.value,
          onDispatch: (event, observacao) async {
            isActing.value = true;
            try {
              final request = TransicaoEventoRequest(
                evento: event,
                observacao: observacao,
              );
              await ref
                  .read(vacationDetailProvider(vacationId).notifier)
                  .dispatchEvent(request);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Evento ${_eventLabel(event)} aplicado com sucesso!'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            } catch (e) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Erro: ${e.toString()}'),
                    backgroundColor: Theme.of(context).colorScheme.error,
                  ),
                );
              }
            } finally {
              isActing.value = false;
            }
          },
        ),
      ),
    );
  }

  String _eventLabel(VacationEvent event) {
    switch (event) {
      case VacationEvent.enviar:
        return 'ENVIAR';
      case VacationEvent.analisar:
        return 'ANALISAR';
      case VacationEvent.aprovar:
        return 'APROVAR';
      case VacationEvent.rejeitar:
        return 'REJEITAR';
      case VacationEvent.concluir:
        return 'CONCLUIR';
    }
  }
}

class _DetailContent extends StatelessWidget {
  final SolicitacaoFeriasResponse vacation;
  final bool isActing;
  final Future<void> Function(VacationEvent event, String? observacao) onDispatch;

  const _DetailContent({
    required this.vacation,
    required this.isActing,
    required this.onDispatch,
  });

  @override
  Widget build(BuildContext context) {
    final availableActions = _getAvailableActions(vacation.status);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card de informacoes
          Card(
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
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                      StatusBadge(status: vacation.status),
                    ],
                  ),
                  const Divider(height: 24),
                  _InfoRow(
                    icon: Icons.badge_outlined,
                    label: 'CPF',
                    value: vacation.funcionarioCpf,
                  ),
                  const SizedBox(height: 12),
                  _InfoRow(
                    icon: Icons.calendar_today_outlined,
                    label: 'Periodo',
                    value: '${vacation.dataInicio} ate ${vacation.dataFim}',
                  ),
                  if (vacation.observacao != null &&
                      vacation.observacao!.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    _InfoRow(
                      icon: Icons.notes_outlined,
                      label: 'Observacao',
                      value: vacation.observacao!,
                    ),
                  ],
                  const SizedBox(height: 12),
                  _InfoRow(
                    icon: Icons.access_time_outlined,
                    label: 'Criado em',
                    value: vacation.createdAt,
                  ),
                  const SizedBox(height: 12),
                  _InfoRow(
                    icon: Icons.update_outlined,
                    label: 'Atualizado em',
                    value: vacation.updatedAt,
                  ),
                ],
              ),
            ),
          ),

          // Secao de acoes
          if (availableActions.isNotEmpty) ...[
            const SizedBox(height: 24),
            Row(
              children: [
                Container(
                  width: 3,
                  height: 18,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'AÇÕES DISPONÍVEIS',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                        letterSpacing: 0.8,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...availableActions.map(
              (action) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _ActionButton(
                  action: action,
                  isLoading: isActing,
                  onPressed: () => _handleAction(context, action, onDispatch),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  List<_VacationAction> _getAvailableActions(VacationStatus status) {
    switch (status) {
      case VacationStatus.rascunho:
        return [
          const _VacationAction(
            event: VacationEvent.enviar,
            label: 'Enviar para Analise',
            icon: Icons.send_outlined,
            color: Colors.blue,
            requiresObservacao: false,
          ),
        ];
      case VacationStatus.enviado:
        return [
          const _VacationAction(
            event: VacationEvent.analisar,
            label: 'Iniciar Analise',
            icon: Icons.manage_search_outlined,
            color: Colors.orange,
            requiresObservacao: false,
          ),
        ];
      case VacationStatus.emAnalise:
        return [
          const _VacationAction(
            event: VacationEvent.aprovar,
            label: 'Aprovar',
            icon: Icons.check_circle_outlined,
            color: Colors.green,
            requiresObservacao: false,
          ),
          const _VacationAction(
            event: VacationEvent.rejeitar,
            label: 'Rejeitar',
            icon: Icons.cancel_outlined,
            color: Colors.red,
            requiresObservacao: true,
          ),
        ];
      case VacationStatus.aprovado:
        return [
          const _VacationAction(
            event: VacationEvent.concluir,
            label: 'Concluir',
            icon: Icons.done_all_outlined,
            color: Colors.purple,
            requiresObservacao: false,
          ),
        ];
      case VacationStatus.rejeitado:
      case VacationStatus.concluido:
        return [];
    }
  }

  Future<void> _handleAction(
    BuildContext context,
    _VacationAction action,
    Future<void> Function(VacationEvent, String?) onDispatch,
  ) async {
    String? observacao;

    if (action.requiresObservacao) {
      observacao = await _showObservacaoDialog(context, action.label);
      if (observacao == null) return; // Cancelado
    }

    await onDispatch(action.event, observacao);
  }

  Future<String?> _showObservacaoDialog(
    BuildContext context,
    String actionLabel,
  ) async {
    final controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(actionLabel),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Informe o motivo (obrigatorio):'),
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
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: AppColors.primary),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.6),
                    ),
              ),
              Text(value, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final _VacationAction action;
  final bool isLoading;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.action,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: isLoading ? null : onPressed,
        icon: isLoading
            ? SizedBox(
                height: 18,
                width: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: action.color,
                ),
              )
            : Icon(action.icon, color: action.color),
        label: Text(
          action.label,
          style: TextStyle(color: action.color),
        ),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: action.color),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }
}

class _VacationAction {
  final VacationEvent event;
  final String label;
  final IconData icon;
  final Color color;
  final bool requiresObservacao;

  const _VacationAction({
    required this.event,
    required this.label,
    required this.icon,
    required this.color,
    required this.requiresObservacao,
  });
}
