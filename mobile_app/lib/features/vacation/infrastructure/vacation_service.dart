import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/dio_provider.dart';
import '../domain/vacation_request.dart';

final vacationServiceProvider = Provider<VacationService>((ref) {
  final dio = ref.read(dioProvider);
  return VacationService(dio);
});

class VacationService {
  final Dio _dio;

  VacationService(this._dio);

  /// GET /api/v1/solicitacoes
  Future<List<SolicitacaoFeriasResponse>> fetchAll() async {
    final response = await _dio.get('/api/v1/solicitacoes');
    final list = response.data as List<dynamic>;
    return list
        .map((item) => SolicitacaoFeriasResponse.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  /// GET /api/v1/solicitacoes/{id}
  Future<SolicitacaoFeriasResponse> fetchById(String id) async {
    final response = await _dio.get('/api/v1/solicitacoes/$id');
    return SolicitacaoFeriasResponse.fromJson(response.data as Map<String, dynamic>);
  }

  /// POST /api/v1/solicitacoes
  Future<SolicitacaoFeriasResponse> create(SolicitacaoFeriasRequest request) async {
    final response = await _dio.post(
      '/api/v1/solicitacoes',
      data: request.toJson(),
    );
    return SolicitacaoFeriasResponse.fromJson(response.data as Map<String, dynamic>);
  }

  /// POST /api/v1/solicitacoes/{id}/eventos
  Future<SolicitacaoFeriasResponse> dispatchEvent(
    String id,
    TransicaoEventoRequest request,
  ) async {
    final response = await _dio.post(
      '/api/v1/solicitacoes/$id/eventos',
      data: request.toJson(),
    );
    return SolicitacaoFeriasResponse.fromJson(response.data as Map<String, dynamic>);
  }

  /// GET /api/v1/solicitacoes/status/{status}
  Future<List<SolicitacaoFeriasResponse>> fetchByStatus(VacationStatus status) async {
    final statusStr = _statusToString(status);
    final response = await _dio.get('/api/v1/solicitacoes/status/$statusStr');
    final list = response.data as List<dynamic>;
    return list
        .map((item) => SolicitacaoFeriasResponse.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  String _statusToString(VacationStatus status) {
    switch (status) {
      case VacationStatus.rascunho:
        return 'RASCUNHO';
      case VacationStatus.enviado:
        return 'ENVIADO';
      case VacationStatus.emAnalise:
        return 'EM_ANALISE';
      case VacationStatus.aprovado:
        return 'APROVADO';
      case VacationStatus.rejeitado:
        return 'REJEITADO';
      case VacationStatus.concluido:
        return 'CONCLUIDO';
    }
  }
}
