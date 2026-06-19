---
name: project-dependencies
description: Versoes reais resolvidas pelo pub get — especialmente versoes diferentes do pubspec original
metadata:
  type: project
---

# Dependencias Resolvidas

**Por que:** O pubspec original tinha `dio: ^6.1.0` que nao existe. A versao real resolvida foi 5.9.2.

## Versoes em uso (pub.lock resolvido em 2026-06-18)

| Pacote | Versao |
|--------|--------|
| dio | 5.9.2 (pubspec pedia ^6.1.0 — inexistente) |
| flutter_riverpod | 2.6.1 |
| hooks_riverpod | 2.6.1 |
| flutter_hooks | 0.19.0 |
| go_router | 8.2.0 |
| freezed_annotation | 2.4.4 |
| json_annotation | 4.9.0 |
| freezed (dev) | 2.5.8 |
| json_serializable (dev) | 6.9.5 |
| build_runner (dev) | 2.5.4 |

## Notas

- `withOpacity()` esta depreciado na versao do Flutter usada — usar `.withValues(alpha: valor)` 
- Build web requer `flutter create . --platforms web` antes de `flutter build web`
- `flutter run -d web-server --web-port 3000` para rodar sem Chrome instalado

**How to apply:** Se adicionar dio ao pubspec, usar `^5.9.2` ou deixar sem versao para o pub resolver.
