import 'package:flutter/material.dart';

import '../../features/vacation/domain/vacation_request.dart';

class StatusBadge extends StatelessWidget {
  final VacationStatus status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final (label, bg, fg) = _style(status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: fg.withValues(alpha: 0.3), width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: fg,
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  (String, Color, Color) _style(VacationStatus status) {
    switch (status) {
      case VacationStatus.rascunho:
        return ('Rascunho', const Color(0xFFEEEEEE), const Color(0xFF757575));
      case VacationStatus.enviado:
        return ('Enviado', const Color(0xFFE3F0FF), const Color(0xFF1565C0));
      case VacationStatus.emAnalise:
        return ('Em Análise', const Color(0xFFFFF3E0), const Color(0xFFE65100));
      case VacationStatus.aprovado:
        return ('Aprovado', const Color(0xFFE8F5E9), const Color(0xFF2E7D32));
      case VacationStatus.rejeitado:
        return ('Rejeitado', const Color(0xFFFFEBEE), const Color(0xFFB71C1C));
      case VacationStatus.concluido:
        return ('Concluído', const Color(0xFFEDE7F6), const Color(0xFF4527A0));
    }
  }
}
