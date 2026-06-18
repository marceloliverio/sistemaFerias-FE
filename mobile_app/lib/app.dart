import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app_router.dart';
import 'core/theme/app_theme.dart';

class SistemaFeriasApp extends ConsumerWidget {
  const SistemaFeriasApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Sistema de Solicitacao de Ferias',
      theme: AppTheme.light,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
