// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vacation_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SolicitacaoFeriasResponse _$SolicitacaoFeriasResponseFromJson(
    Map<String, dynamic> json) {
  return _SolicitacaoFeriasResponse.fromJson(json);
}

/// @nodoc
mixin _$SolicitacaoFeriasResponse {
  String get id => throw _privateConstructorUsedError;
  String get funcionarioNome => throw _privateConstructorUsedError;
  String get funcionarioCpf => throw _privateConstructorUsedError;
  String get dataInicio => throw _privateConstructorUsedError;
  String get dataFim => throw _privateConstructorUsedError;
  VacationStatus get status => throw _privateConstructorUsedError;
  String? get observacao => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  String get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this SolicitacaoFeriasResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SolicitacaoFeriasResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SolicitacaoFeriasResponseCopyWith<SolicitacaoFeriasResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SolicitacaoFeriasResponseCopyWith<$Res> {
  factory $SolicitacaoFeriasResponseCopyWith(SolicitacaoFeriasResponse value,
          $Res Function(SolicitacaoFeriasResponse) then) =
      _$SolicitacaoFeriasResponseCopyWithImpl<$Res, SolicitacaoFeriasResponse>;
  @useResult
  $Res call(
      {String id,
      String funcionarioNome,
      String funcionarioCpf,
      String dataInicio,
      String dataFim,
      VacationStatus status,
      String? observacao,
      String createdAt,
      String updatedAt});
}

/// @nodoc
class _$SolicitacaoFeriasResponseCopyWithImpl<$Res,
        $Val extends SolicitacaoFeriasResponse>
    implements $SolicitacaoFeriasResponseCopyWith<$Res> {
  _$SolicitacaoFeriasResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SolicitacaoFeriasResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? funcionarioNome = null,
    Object? funcionarioCpf = null,
    Object? dataInicio = null,
    Object? dataFim = null,
    Object? status = null,
    Object? observacao = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      funcionarioNome: null == funcionarioNome
          ? _value.funcionarioNome
          : funcionarioNome // ignore: cast_nullable_to_non_nullable
              as String,
      funcionarioCpf: null == funcionarioCpf
          ? _value.funcionarioCpf
          : funcionarioCpf // ignore: cast_nullable_to_non_nullable
              as String,
      dataInicio: null == dataInicio
          ? _value.dataInicio
          : dataInicio // ignore: cast_nullable_to_non_nullable
              as String,
      dataFim: null == dataFim
          ? _value.dataFim
          : dataFim // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as VacationStatus,
      observacao: freezed == observacao
          ? _value.observacao
          : observacao // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SolicitacaoFeriasResponseImplCopyWith<$Res>
    implements $SolicitacaoFeriasResponseCopyWith<$Res> {
  factory _$$SolicitacaoFeriasResponseImplCopyWith(
          _$SolicitacaoFeriasResponseImpl value,
          $Res Function(_$SolicitacaoFeriasResponseImpl) then) =
      __$$SolicitacaoFeriasResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String funcionarioNome,
      String funcionarioCpf,
      String dataInicio,
      String dataFim,
      VacationStatus status,
      String? observacao,
      String createdAt,
      String updatedAt});
}

/// @nodoc
class __$$SolicitacaoFeriasResponseImplCopyWithImpl<$Res>
    extends _$SolicitacaoFeriasResponseCopyWithImpl<$Res,
        _$SolicitacaoFeriasResponseImpl>
    implements _$$SolicitacaoFeriasResponseImplCopyWith<$Res> {
  __$$SolicitacaoFeriasResponseImplCopyWithImpl(
      _$SolicitacaoFeriasResponseImpl _value,
      $Res Function(_$SolicitacaoFeriasResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of SolicitacaoFeriasResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? funcionarioNome = null,
    Object? funcionarioCpf = null,
    Object? dataInicio = null,
    Object? dataFim = null,
    Object? status = null,
    Object? observacao = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$SolicitacaoFeriasResponseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      funcionarioNome: null == funcionarioNome
          ? _value.funcionarioNome
          : funcionarioNome // ignore: cast_nullable_to_non_nullable
              as String,
      funcionarioCpf: null == funcionarioCpf
          ? _value.funcionarioCpf
          : funcionarioCpf // ignore: cast_nullable_to_non_nullable
              as String,
      dataInicio: null == dataInicio
          ? _value.dataInicio
          : dataInicio // ignore: cast_nullable_to_non_nullable
              as String,
      dataFim: null == dataFim
          ? _value.dataFim
          : dataFim // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as VacationStatus,
      observacao: freezed == observacao
          ? _value.observacao
          : observacao // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SolicitacaoFeriasResponseImpl implements _SolicitacaoFeriasResponse {
  const _$SolicitacaoFeriasResponseImpl(
      {required this.id,
      required this.funcionarioNome,
      required this.funcionarioCpf,
      required this.dataInicio,
      required this.dataFim,
      required this.status,
      this.observacao,
      required this.createdAt,
      required this.updatedAt});

  factory _$SolicitacaoFeriasResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$SolicitacaoFeriasResponseImplFromJson(json);

  @override
  final String id;
  @override
  final String funcionarioNome;
  @override
  final String funcionarioCpf;
  @override
  final String dataInicio;
  @override
  final String dataFim;
  @override
  final VacationStatus status;
  @override
  final String? observacao;
  @override
  final String createdAt;
  @override
  final String updatedAt;

  @override
  String toString() {
    return 'SolicitacaoFeriasResponse(id: $id, funcionarioNome: $funcionarioNome, funcionarioCpf: $funcionarioCpf, dataInicio: $dataInicio, dataFim: $dataFim, status: $status, observacao: $observacao, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SolicitacaoFeriasResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.funcionarioNome, funcionarioNome) ||
                other.funcionarioNome == funcionarioNome) &&
            (identical(other.funcionarioCpf, funcionarioCpf) ||
                other.funcionarioCpf == funcionarioCpf) &&
            (identical(other.dataInicio, dataInicio) ||
                other.dataInicio == dataInicio) &&
            (identical(other.dataFim, dataFim) || other.dataFim == dataFim) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.observacao, observacao) ||
                other.observacao == observacao) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      funcionarioNome,
      funcionarioCpf,
      dataInicio,
      dataFim,
      status,
      observacao,
      createdAt,
      updatedAt);

  /// Create a copy of SolicitacaoFeriasResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SolicitacaoFeriasResponseImplCopyWith<_$SolicitacaoFeriasResponseImpl>
      get copyWith => __$$SolicitacaoFeriasResponseImplCopyWithImpl<
          _$SolicitacaoFeriasResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SolicitacaoFeriasResponseImplToJson(
      this,
    );
  }
}

abstract class _SolicitacaoFeriasResponse implements SolicitacaoFeriasResponse {
  const factory _SolicitacaoFeriasResponse(
      {required final String id,
      required final String funcionarioNome,
      required final String funcionarioCpf,
      required final String dataInicio,
      required final String dataFim,
      required final VacationStatus status,
      final String? observacao,
      required final String createdAt,
      required final String updatedAt}) = _$SolicitacaoFeriasResponseImpl;

  factory _SolicitacaoFeriasResponse.fromJson(Map<String, dynamic> json) =
      _$SolicitacaoFeriasResponseImpl.fromJson;

  @override
  String get id;
  @override
  String get funcionarioNome;
  @override
  String get funcionarioCpf;
  @override
  String get dataInicio;
  @override
  String get dataFim;
  @override
  VacationStatus get status;
  @override
  String? get observacao;
  @override
  String get createdAt;
  @override
  String get updatedAt;

  /// Create a copy of SolicitacaoFeriasResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SolicitacaoFeriasResponseImplCopyWith<_$SolicitacaoFeriasResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

SolicitacaoFeriasRequest _$SolicitacaoFeriasRequestFromJson(
    Map<String, dynamic> json) {
  return _SolicitacaoFeriasRequest.fromJson(json);
}

/// @nodoc
mixin _$SolicitacaoFeriasRequest {
  String get funcionarioNome => throw _privateConstructorUsedError;
  String get funcionarioCpf => throw _privateConstructorUsedError;
  String get dataInicio => throw _privateConstructorUsedError;
  String get dataFim => throw _privateConstructorUsedError;
  String? get observacao => throw _privateConstructorUsedError;

  /// Serializes this SolicitacaoFeriasRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SolicitacaoFeriasRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SolicitacaoFeriasRequestCopyWith<SolicitacaoFeriasRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SolicitacaoFeriasRequestCopyWith<$Res> {
  factory $SolicitacaoFeriasRequestCopyWith(SolicitacaoFeriasRequest value,
          $Res Function(SolicitacaoFeriasRequest) then) =
      _$SolicitacaoFeriasRequestCopyWithImpl<$Res, SolicitacaoFeriasRequest>;
  @useResult
  $Res call(
      {String funcionarioNome,
      String funcionarioCpf,
      String dataInicio,
      String dataFim,
      String? observacao});
}

/// @nodoc
class _$SolicitacaoFeriasRequestCopyWithImpl<$Res,
        $Val extends SolicitacaoFeriasRequest>
    implements $SolicitacaoFeriasRequestCopyWith<$Res> {
  _$SolicitacaoFeriasRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SolicitacaoFeriasRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? funcionarioNome = null,
    Object? funcionarioCpf = null,
    Object? dataInicio = null,
    Object? dataFim = null,
    Object? observacao = freezed,
  }) {
    return _then(_value.copyWith(
      funcionarioNome: null == funcionarioNome
          ? _value.funcionarioNome
          : funcionarioNome // ignore: cast_nullable_to_non_nullable
              as String,
      funcionarioCpf: null == funcionarioCpf
          ? _value.funcionarioCpf
          : funcionarioCpf // ignore: cast_nullable_to_non_nullable
              as String,
      dataInicio: null == dataInicio
          ? _value.dataInicio
          : dataInicio // ignore: cast_nullable_to_non_nullable
              as String,
      dataFim: null == dataFim
          ? _value.dataFim
          : dataFim // ignore: cast_nullable_to_non_nullable
              as String,
      observacao: freezed == observacao
          ? _value.observacao
          : observacao // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SolicitacaoFeriasRequestImplCopyWith<$Res>
    implements $SolicitacaoFeriasRequestCopyWith<$Res> {
  factory _$$SolicitacaoFeriasRequestImplCopyWith(
          _$SolicitacaoFeriasRequestImpl value,
          $Res Function(_$SolicitacaoFeriasRequestImpl) then) =
      __$$SolicitacaoFeriasRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String funcionarioNome,
      String funcionarioCpf,
      String dataInicio,
      String dataFim,
      String? observacao});
}

/// @nodoc
class __$$SolicitacaoFeriasRequestImplCopyWithImpl<$Res>
    extends _$SolicitacaoFeriasRequestCopyWithImpl<$Res,
        _$SolicitacaoFeriasRequestImpl>
    implements _$$SolicitacaoFeriasRequestImplCopyWith<$Res> {
  __$$SolicitacaoFeriasRequestImplCopyWithImpl(
      _$SolicitacaoFeriasRequestImpl _value,
      $Res Function(_$SolicitacaoFeriasRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of SolicitacaoFeriasRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? funcionarioNome = null,
    Object? funcionarioCpf = null,
    Object? dataInicio = null,
    Object? dataFim = null,
    Object? observacao = freezed,
  }) {
    return _then(_$SolicitacaoFeriasRequestImpl(
      funcionarioNome: null == funcionarioNome
          ? _value.funcionarioNome
          : funcionarioNome // ignore: cast_nullable_to_non_nullable
              as String,
      funcionarioCpf: null == funcionarioCpf
          ? _value.funcionarioCpf
          : funcionarioCpf // ignore: cast_nullable_to_non_nullable
              as String,
      dataInicio: null == dataInicio
          ? _value.dataInicio
          : dataInicio // ignore: cast_nullable_to_non_nullable
              as String,
      dataFim: null == dataFim
          ? _value.dataFim
          : dataFim // ignore: cast_nullable_to_non_nullable
              as String,
      observacao: freezed == observacao
          ? _value.observacao
          : observacao // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SolicitacaoFeriasRequestImpl implements _SolicitacaoFeriasRequest {
  const _$SolicitacaoFeriasRequestImpl(
      {required this.funcionarioNome,
      required this.funcionarioCpf,
      required this.dataInicio,
      required this.dataFim,
      this.observacao});

  factory _$SolicitacaoFeriasRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$SolicitacaoFeriasRequestImplFromJson(json);

  @override
  final String funcionarioNome;
  @override
  final String funcionarioCpf;
  @override
  final String dataInicio;
  @override
  final String dataFim;
  @override
  final String? observacao;

  @override
  String toString() {
    return 'SolicitacaoFeriasRequest(funcionarioNome: $funcionarioNome, funcionarioCpf: $funcionarioCpf, dataInicio: $dataInicio, dataFim: $dataFim, observacao: $observacao)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SolicitacaoFeriasRequestImpl &&
            (identical(other.funcionarioNome, funcionarioNome) ||
                other.funcionarioNome == funcionarioNome) &&
            (identical(other.funcionarioCpf, funcionarioCpf) ||
                other.funcionarioCpf == funcionarioCpf) &&
            (identical(other.dataInicio, dataInicio) ||
                other.dataInicio == dataInicio) &&
            (identical(other.dataFim, dataFim) || other.dataFim == dataFim) &&
            (identical(other.observacao, observacao) ||
                other.observacao == observacao));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, funcionarioNome, funcionarioCpf,
      dataInicio, dataFim, observacao);

  /// Create a copy of SolicitacaoFeriasRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SolicitacaoFeriasRequestImplCopyWith<_$SolicitacaoFeriasRequestImpl>
      get copyWith => __$$SolicitacaoFeriasRequestImplCopyWithImpl<
          _$SolicitacaoFeriasRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SolicitacaoFeriasRequestImplToJson(
      this,
    );
  }
}

abstract class _SolicitacaoFeriasRequest implements SolicitacaoFeriasRequest {
  const factory _SolicitacaoFeriasRequest(
      {required final String funcionarioNome,
      required final String funcionarioCpf,
      required final String dataInicio,
      required final String dataFim,
      final String? observacao}) = _$SolicitacaoFeriasRequestImpl;

  factory _SolicitacaoFeriasRequest.fromJson(Map<String, dynamic> json) =
      _$SolicitacaoFeriasRequestImpl.fromJson;

  @override
  String get funcionarioNome;
  @override
  String get funcionarioCpf;
  @override
  String get dataInicio;
  @override
  String get dataFim;
  @override
  String? get observacao;

  /// Create a copy of SolicitacaoFeriasRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SolicitacaoFeriasRequestImplCopyWith<_$SolicitacaoFeriasRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

TransicaoEventoRequest _$TransicaoEventoRequestFromJson(
    Map<String, dynamic> json) {
  return _TransicaoEventoRequest.fromJson(json);
}

/// @nodoc
mixin _$TransicaoEventoRequest {
  VacationEvent get evento => throw _privateConstructorUsedError;
  String? get observacao => throw _privateConstructorUsedError;

  /// Serializes this TransicaoEventoRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TransicaoEventoRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransicaoEventoRequestCopyWith<TransicaoEventoRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransicaoEventoRequestCopyWith<$Res> {
  factory $TransicaoEventoRequestCopyWith(TransicaoEventoRequest value,
          $Res Function(TransicaoEventoRequest) then) =
      _$TransicaoEventoRequestCopyWithImpl<$Res, TransicaoEventoRequest>;
  @useResult
  $Res call({VacationEvent evento, String? observacao});
}

/// @nodoc
class _$TransicaoEventoRequestCopyWithImpl<$Res,
        $Val extends TransicaoEventoRequest>
    implements $TransicaoEventoRequestCopyWith<$Res> {
  _$TransicaoEventoRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransicaoEventoRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? evento = null,
    Object? observacao = freezed,
  }) {
    return _then(_value.copyWith(
      evento: null == evento
          ? _value.evento
          : evento // ignore: cast_nullable_to_non_nullable
              as VacationEvent,
      observacao: freezed == observacao
          ? _value.observacao
          : observacao // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TransicaoEventoRequestImplCopyWith<$Res>
    implements $TransicaoEventoRequestCopyWith<$Res> {
  factory _$$TransicaoEventoRequestImplCopyWith(
          _$TransicaoEventoRequestImpl value,
          $Res Function(_$TransicaoEventoRequestImpl) then) =
      __$$TransicaoEventoRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({VacationEvent evento, String? observacao});
}

/// @nodoc
class __$$TransicaoEventoRequestImplCopyWithImpl<$Res>
    extends _$TransicaoEventoRequestCopyWithImpl<$Res,
        _$TransicaoEventoRequestImpl>
    implements _$$TransicaoEventoRequestImplCopyWith<$Res> {
  __$$TransicaoEventoRequestImplCopyWithImpl(
      _$TransicaoEventoRequestImpl _value,
      $Res Function(_$TransicaoEventoRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransicaoEventoRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? evento = null,
    Object? observacao = freezed,
  }) {
    return _then(_$TransicaoEventoRequestImpl(
      evento: null == evento
          ? _value.evento
          : evento // ignore: cast_nullable_to_non_nullable
              as VacationEvent,
      observacao: freezed == observacao
          ? _value.observacao
          : observacao // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TransicaoEventoRequestImpl implements _TransicaoEventoRequest {
  const _$TransicaoEventoRequestImpl({required this.evento, this.observacao});

  factory _$TransicaoEventoRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransicaoEventoRequestImplFromJson(json);

  @override
  final VacationEvent evento;
  @override
  final String? observacao;

  @override
  String toString() {
    return 'TransicaoEventoRequest(evento: $evento, observacao: $observacao)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransicaoEventoRequestImpl &&
            (identical(other.evento, evento) || other.evento == evento) &&
            (identical(other.observacao, observacao) ||
                other.observacao == observacao));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, evento, observacao);

  /// Create a copy of TransicaoEventoRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransicaoEventoRequestImplCopyWith<_$TransicaoEventoRequestImpl>
      get copyWith => __$$TransicaoEventoRequestImplCopyWithImpl<
          _$TransicaoEventoRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TransicaoEventoRequestImplToJson(
      this,
    );
  }
}

abstract class _TransicaoEventoRequest implements TransicaoEventoRequest {
  const factory _TransicaoEventoRequest(
      {required final VacationEvent evento,
      final String? observacao}) = _$TransicaoEventoRequestImpl;

  factory _TransicaoEventoRequest.fromJson(Map<String, dynamic> json) =
      _$TransicaoEventoRequestImpl.fromJson;

  @override
  VacationEvent get evento;
  @override
  String? get observacao;

  /// Create a copy of TransicaoEventoRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransicaoEventoRequestImplCopyWith<_$TransicaoEventoRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
