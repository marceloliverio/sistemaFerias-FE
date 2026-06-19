import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../application/vacation_notifier.dart';
import '../domain/vacation_request.dart';

class VacationFormPage extends HookConsumerWidget {
  const VacationFormPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final nomeController = useTextEditingController();
    final cpfController = useTextEditingController();
    final dataInicioController = useTextEditingController();
    final dataFimController = useTextEditingController();
    final observacaoController = useTextEditingController();
    final isSubmitting = useState(false);
    final errorMessage = useState<String?>(null);

    Future<void> selectDate(
      TextEditingController controller,
      String label,
    ) async {
      final now = DateTime.now();
      final picked = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: now,
        lastDate: DateTime(now.year + 2),
        helpText: 'Selecione $label',
      );
      if (picked != null) {
        controller.text =
            '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
      }
    }

    Future<void> handleSubmit() async {
      if (!formKey.currentState!.validate()) return;

      // Validacao de periodo
      final inicio = DateTime.tryParse(dataInicioController.text);
      final fim = DateTime.tryParse(dataFimController.text);
      if (inicio != null && fim != null && !fim.isAfter(inicio)) {
        errorMessage.value =
            'A data de fim deve ser posterior a data de inicio.';
        return;
      }

      isSubmitting.value = true;
      errorMessage.value = null;

      try {
        final request = SolicitacaoFeriasRequest(
          funcionarioNome: nomeController.text.trim(),
          funcionarioCpf: cpfController.text.trim(),
          dataInicio: dataInicioController.text,
          dataFim: dataFimController.text,
          observacao: observacaoController.text.trim().isEmpty
              ? null
              : observacaoController.text.trim(),
        );

        await ref
            .read(vacationListProvider.notifier)
            .createSolicitacao(request);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Solicitacao criada com sucesso!'),
              backgroundColor: Colors.green,
            ),
          );
          context.pop();
        }
      } catch (e) {
        errorMessage.value = _extractError(e);
      } finally {
        isSubmitting.value = false;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('NOVA SOLICITAÇÃO'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Nome do funcionario
                TextFormField(
                  controller: nomeController,
                  decoration: const InputDecoration(
                    labelText: 'Nome do Funcionario *',
                    prefixIcon: Icon(Icons.person_outlined),
                  ),
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  enabled: !isSubmitting.value,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Informe o nome do funcionario';
                    }
                    if (value.trim().length < 3) {
                      return 'Nome deve ter ao menos 3 caracteres';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // CPF
                TextFormField(
                  controller: cpfController,
                  decoration: const InputDecoration(
                    labelText: 'CPF *',
                    prefixIcon: Icon(Icons.badge_outlined),
                    hintText: '000.000.000-00',
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  enabled: !isSubmitting.value,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    _CpfInputFormatter(),
                  ],
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Informe o CPF';
                    }
                    final digits = value.replaceAll(RegExp(r'\D'), '');
                    if (digits.length != 11) {
                      return 'CPF deve ter 11 digitos';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Data de inicio
                TextFormField(
                  controller: dataInicioController,
                  decoration: InputDecoration(
                    labelText: 'Data de Inicio *',
                    prefixIcon: const Icon(Icons.calendar_today_outlined),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.event),
                      onPressed: isSubmitting.value
                          ? null
                          : () => selectDate(
                              dataInicioController, 'data de inicio'),
                    ),
                  ),
                  readOnly: true,
                  enabled: !isSubmitting.value,
                  onTap: isSubmitting.value
                      ? null
                      : () => selectDate(dataInicioController, 'data de inicio'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Selecione a data de inicio';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Data de fim
                TextFormField(
                  controller: dataFimController,
                  decoration: InputDecoration(
                    labelText: 'Data de Fim *',
                    prefixIcon: const Icon(Icons.calendar_today_outlined),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.event),
                      onPressed: isSubmitting.value
                          ? null
                          : () =>
                              selectDate(dataFimController, 'data de fim'),
                    ),
                  ),
                  readOnly: true,
                  enabled: !isSubmitting.value,
                  onTap: isSubmitting.value
                      ? null
                      : () => selectDate(dataFimController, 'data de fim'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Selecione a data de fim';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Observacao
                TextFormField(
                  controller: observacaoController,
                  decoration: const InputDecoration(
                    labelText: 'Observacao (opcional)',
                    prefixIcon: Icon(Icons.notes_outlined),
                    alignLabelWithHint: true,
                  ),
                  maxLines: 3,
                  textInputAction: TextInputAction.done,
                  enabled: !isSubmitting.value,
                ),
                const SizedBox(height: 8),

                // Mensagem de erro
                if (errorMessage.value != null) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.errorContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      errorMessage.value!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onErrorContainer,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],

                const SizedBox(height: 24),

                // Botao de submit
                FilledButton.icon(
                  onPressed: isSubmitting.value ? null : handleSubmit,
                  icon: isSubmitting.value
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white),
                        )
                      : const Icon(Icons.save_outlined),
                  label: Text(
                    isSubmitting.value ? 'Salvando...' : 'Criar Solicitação',
                  ),
                ),

                const SizedBox(height: 12),

                OutlinedButton(
                  onPressed: isSubmitting.value ? null : () => context.pop(),
                  child: const Text('Cancelar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _extractError(Object error) {
    final msg = error.toString();
    if (msg.contains('400')) return 'Dados invalidos. Verifique os campos.';
    if (msg.contains('401') || msg.contains('403')) {
      return 'Sessao expirada. Faca login novamente.';
    }
    if (msg.contains('SocketException')) return 'Sem conexao com o servidor.';
    return 'Erro ao criar solicitacao. Tente novamente.';
  }
}

/// Formatter para mascara de CPF: 000.000.000-00
class _CpfInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final buffer = StringBuffer();

    for (int i = 0; i < digits.length && i < 11; i++) {
      if (i == 3 || i == 6) buffer.write('.');
      if (i == 9) buffer.write('-');
      buffer.write(digits[i]);
    }

    final formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
