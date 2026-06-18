import 'package:freezed_annotation/freezed_annotation.dart';

part 'vacation_request.freezed.dart';
part 'vacation_request.g.dart';

/// Enum com os status possiveis — mapeados do backend
enum VacationStatus {
  @JsonValue('RASCUNHO')
  rascunho,
  @JsonValue('ENVIADO')
  enviado,
  @JsonValue('EM_ANALISE')
  emAnalise,
  @JsonValue('APROVADO')
  aprovado,
  @JsonValue('REJEITADO')
  rejeitado,
  @JsonValue('CONCLUIDO')
  concluido,
}

/// Enum com os eventos possiveis de transicao
enum VacationEvent {
  @JsonValue('ENVIAR')
  enviar,
  @JsonValue('ANALISAR')
  analisar,
  @JsonValue('APROVAR')
  aprovar,
  @JsonValue('REJEITAR')
  rejeitar,
  @JsonValue('CONCLUIR')
  concluir,
}

/// Response de GET /api/v1/solicitacoes e GET /api/v1/solicitacoes/{id}
/// Campos exatamente como o backend retorna
@freezed
class SolicitacaoFeriasResponse with _$SolicitacaoFeriasResponse {
  const factory SolicitacaoFeriasResponse({
    required String id,
    required String funcionarioNome,
    required String funcionarioCpf,
    required String dataInicio,
    required String dataFim,
    required VacationStatus status,
    String? observacao,
    required String createdAt,
    required String updatedAt,
  }) = _SolicitacaoFeriasResponse;

  factory SolicitacaoFeriasResponse.fromJson(Map<String, dynamic> json) =>
      _$SolicitacaoFeriasResponseFromJson(json);
}

/// Request body para POST /api/v1/solicitacoes
@freezed
class SolicitacaoFeriasRequest with _$SolicitacaoFeriasRequest {
  const factory SolicitacaoFeriasRequest({
    required String funcionarioNome,
    required String funcionarioCpf,
    required String dataInicio,
    required String dataFim,
    String? observacao,
  }) = _SolicitacaoFeriasRequest;

  factory SolicitacaoFeriasRequest.fromJson(Map<String, dynamic> json) =>
      _$SolicitacaoFeriasRequestFromJson(json);
}

/// Request body para POST /api/v1/solicitacoes/{id}/eventos
@freezed
class TransicaoEventoRequest with _$TransicaoEventoRequest {
  const factory TransicaoEventoRequest({
    required VacationEvent evento,
    String? observacao,
  }) = _TransicaoEventoRequest;

  factory TransicaoEventoRequest.fromJson(Map<String, dynamic> json) =>
      _$TransicaoEventoRequestFromJson(json);
}
