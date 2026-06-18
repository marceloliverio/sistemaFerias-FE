// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vacation_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SolicitacaoFeriasResponseImpl _$$SolicitacaoFeriasResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$SolicitacaoFeriasResponseImpl(
      id: json['id'] as String,
      funcionarioNome: json['funcionarioNome'] as String,
      funcionarioCpf: json['funcionarioCpf'] as String,
      dataInicio: json['dataInicio'] as String,
      dataFim: json['dataFim'] as String,
      status: $enumDecode(_$VacationStatusEnumMap, json['status']),
      observacao: json['observacao'] as String?,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$$SolicitacaoFeriasResponseImplToJson(
        _$SolicitacaoFeriasResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'funcionarioNome': instance.funcionarioNome,
      'funcionarioCpf': instance.funcionarioCpf,
      'dataInicio': instance.dataInicio,
      'dataFim': instance.dataFim,
      'status': _$VacationStatusEnumMap[instance.status]!,
      'observacao': instance.observacao,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

const _$VacationStatusEnumMap = {
  VacationStatus.rascunho: 'RASCUNHO',
  VacationStatus.enviado: 'ENVIADO',
  VacationStatus.emAnalise: 'EM_ANALISE',
  VacationStatus.aprovado: 'APROVADO',
  VacationStatus.rejeitado: 'REJEITADO',
  VacationStatus.concluido: 'CONCLUIDO',
};

_$SolicitacaoFeriasRequestImpl _$$SolicitacaoFeriasRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$SolicitacaoFeriasRequestImpl(
      funcionarioNome: json['funcionarioNome'] as String,
      funcionarioCpf: json['funcionarioCpf'] as String,
      dataInicio: json['dataInicio'] as String,
      dataFim: json['dataFim'] as String,
      observacao: json['observacao'] as String?,
    );

Map<String, dynamic> _$$SolicitacaoFeriasRequestImplToJson(
        _$SolicitacaoFeriasRequestImpl instance) =>
    <String, dynamic>{
      'funcionarioNome': instance.funcionarioNome,
      'funcionarioCpf': instance.funcionarioCpf,
      'dataInicio': instance.dataInicio,
      'dataFim': instance.dataFim,
      'observacao': instance.observacao,
    };

_$TransicaoEventoRequestImpl _$$TransicaoEventoRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$TransicaoEventoRequestImpl(
      evento: $enumDecode(_$VacationEventEnumMap, json['evento']),
      observacao: json['observacao'] as String?,
    );

Map<String, dynamic> _$$TransicaoEventoRequestImplToJson(
        _$TransicaoEventoRequestImpl instance) =>
    <String, dynamic>{
      'evento': _$VacationEventEnumMap[instance.evento]!,
      'observacao': instance.observacao,
    };

const _$VacationEventEnumMap = {
  VacationEvent.enviar: 'ENVIAR',
  VacationEvent.analisar: 'ANALISAR',
  VacationEvent.aprovar: 'APROVAR',
  VacationEvent.rejeitar: 'REJEITAR',
  VacationEvent.concluir: 'CONCLUIR',
};
