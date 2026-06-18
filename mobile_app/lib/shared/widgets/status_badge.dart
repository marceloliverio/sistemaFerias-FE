import 'package:flutter/material.dart';

import '../../features/vacation/domain/vacation_request.dart';

class StatusBadge extends StatelessWidget {
  final VacationStatus status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final (label, color) = _labelAndColor(status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color, width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  (String, Color) _labelAndColor(VacationStatus status) {
    switch (status) {
      case VacationStatus.rascunho:
        return ('Rascunho', Colors.grey);
      case VacationStatus.enviado:
        return ('Enviado', Colors.blue);
      case VacationStatus.emAnalise:
        return ('Em Analise', Colors.orange);
      case VacationStatus.aprovado:
        return ('Aprovado', Colors.green);
      case VacationStatus.rejeitado:
        return ('Rejeitado', Colors.red);
      case VacationStatus.concluido:
        return ('Concluido', Colors.purple);
    }
  }
}
