# Sistema de Solicitação de Férias - Mobile

Este diretório contém o frontend mobile em Flutter para o sistema de solicitação de férias.

Estrutura inicial:
- `lib/main.dart`
- `lib/app.dart`
- `lib/app_router.dart`
- `lib/core/`
- `lib/features/`
- `lib/shared/`

Dependências principais:
- Flutter
- Riverpod
- GoRouter
- Dio
- Freezed
- Json Serializable
- Flutter Hooks

Para gerar arquivos Freezed e Json Serializable:

```bash
cd mobile_app
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```
