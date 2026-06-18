import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sistema_ferias_mobile/app.dart';

void main() {
  testWidgets('App smoke test — login page renders', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: SistemaFeriasApp()),
    );
    await tester.pump();
    expect(find.text('Sistema de Ferias'), findsOneWidget);
  });
}
