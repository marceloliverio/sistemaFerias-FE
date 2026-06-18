import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/dio_provider.dart';
import '../domain/auth_model.dart';
import '../infrastructure/auth_service.dart';

/// Estado de autenticacao
class AuthState {
  final bool isAuthenticated;
  final String? token;
  final String? userName;
  final bool isLoading;
  final String? errorMessage;

  const AuthState({
    this.isAuthenticated = false,
    this.token,
    this.userName,
    this.isLoading = false,
    this.errorMessage,
  });

  AuthState copyWith({
    bool? isAuthenticated,
    String? token,
    String? userName,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      token: token ?? this.token,
      userName: userName ?? this.userName,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

final authNotifierProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() => const AuthState();

  Future<bool> login(String email, String senha) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final authService = ref.read(authServiceProvider);
      final request = LoginRequest(email: email, senha: senha);
      final response = await authService.login(request);

      AuthTokenStore.token = response.token;

      state = AuthState(
        isAuthenticated: true,
        token: response.token,
        userName: response.nome ?? UserSession.fromToken(response.token).userName,
        isLoading: false,
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: _extractErrorMessage(e),
      );
      return false;
    }
  }

  void logout() {
    AuthTokenStore.token = null;
    state = const AuthState();
  }

  String _extractErrorMessage(Object error) {
    final msg = error.toString();
    if (msg.contains('401') || msg.contains('403')) {
      return 'Email ou senha invalidos.';
    }
    if (msg.contains('SocketException') || msg.contains('Failed host lookup')) {
      return 'Sem conexao com o servidor.';
    }
    if (msg.contains('TimeoutException') || msg.contains('timeout')) {
      return 'Tempo de conexao esgotado.';
    }
    return 'Erro inesperado. Tente novamente.';
  }
}
