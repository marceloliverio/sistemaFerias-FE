import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/dio_provider.dart';
import '../domain/auth_model.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  // Usa o Dio publico (sem token) pois o login nao exige autenticacao
  final dio = ref.read(dioPublicProvider);
  return AuthService(dio);
});

class AuthService {
  final Dio _dio;

  AuthService(this._dio);

  /// POST /api/auth/login
  Future<LoginResponse> login(LoginRequest request) async {
    final response = await _dio.post(
      '/api/auth/login',
      data: request.toJson(),
    );
    return LoginResponse.fromJson(response.data as Map<String, dynamic>);
  }
}
