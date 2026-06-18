import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/vacation_request.dart';
import '../infrastructure/vacation_service.dart';

/// Provider da lista de solicitacoes
final vacationListProvider =
    AsyncNotifierProvider<VacationListNotifier, List<SolicitacaoFeriasResponse>>(
  VacationListNotifier.new,
);

class VacationListNotifier extends AsyncNotifier<List<SolicitacaoFeriasResponse>> {
  @override
  Future<List<SolicitacaoFeriasResponse>> build() async {
    return _fetchAll();
  }

  Future<List<SolicitacaoFeriasResponse>> _fetchAll() {
    final service = ref.read(vacationServiceProvider);
    return service.fetchAll();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_fetchAll);
  }

  Future<SolicitacaoFeriasResponse?> createSolicitacao(
    SolicitacaoFeriasRequest request,
  ) async {
    try {
      final service = ref.read(vacationServiceProvider);
      final created = await service.create(request);
      // Atualiza a lista localmente sem recarregar tudo
      state = state.whenData((list) => [created, ...list]);
      return created;
    } catch (_) {
      rethrow;
    }
  }

  Future<SolicitacaoFeriasResponse?> dispatchEvent(
    String id,
    TransicaoEventoRequest request,
  ) async {
    try {
      final service = ref.read(vacationServiceProvider);
      final updated = await service.dispatchEvent(id, request);
      // Substitui o item atualizado na lista
      state = state.whenData((list) {
        return list.map((item) => item.id == id ? updated : item).toList();
      });
      return updated;
    } catch (_) {
      rethrow;
    }
  }
}

/// Provider para detalhe de uma solicitacao especifica
final vacationDetailProvider =
    AsyncNotifierProviderFamily<VacationDetailNotifier, SolicitacaoFeriasResponse, String>(
  VacationDetailNotifier.new,
);

class VacationDetailNotifier
    extends FamilyAsyncNotifier<SolicitacaoFeriasResponse, String> {
  @override
  Future<SolicitacaoFeriasResponse> build(String arg) async {
    final service = ref.read(vacationServiceProvider);
    return service.fetchById(arg);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    final service = ref.read(vacationServiceProvider);
    state = await AsyncValue.guard(() => service.fetchById(arg));
  }

  Future<void> dispatchEvent(TransicaoEventoRequest request) async {
    try {
      final service = ref.read(vacationServiceProvider);
      final updated = await service.dispatchEvent(arg, request);
      state = AsyncData(updated);
      // Sincroniza com a lista geral
      ref.read(vacationListProvider.notifier).dispatchEvent(arg, request);
    } catch (_) {
      rethrow;
    }
  }
}
