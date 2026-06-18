import 'dart:convert';

/// Request body para POST /api/auth/login
class LoginRequest {
  final String email;
  final String senha;

  const LoginRequest({
    required this.email,
    required this.senha,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'senha': senha,
      };
}

/// Response de POST /api/auth/login
class LoginResponse {
  final String token;
  final String tipo;
  final int expiracaoMs;
  final String? nome;
  final String? perfil;

  const LoginResponse({
    required this.token,
    required this.tipo,
    required this.expiracaoMs,
    this.nome,
    this.perfil,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token'] as String,
      tipo: json['tipo'] as String,
      expiracaoMs: json['expiracaoMs'] as int,
      nome: json['nome'] as String?,
      perfil: json['perfil'] as String?,
    );
  }
}

/// Estado da sessao do usuario autenticado
class UserSession {
  final String token;
  final String userName;

  const UserSession({
    required this.token,
    required this.userName,
  });

  factory UserSession.fromToken(String token) {
    final userName = _decodeSubFromJwt(token);
    return UserSession(token: token, userName: userName);
  }

  static String _decodeSubFromJwt(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return 'Usuario';
      final payload = parts[1];
      // Adicionar padding necessario para base64
      final normalized = base64Url.normalize(payload);
      final decoded = utf8.decode(base64Url.decode(normalized));
      final map = jsonDecode(decoded) as Map<String, dynamic>;
      return map['sub']?.toString() ?? 'Usuario';
    } catch (_) {
      return 'Usuario';
    }
  }
}
