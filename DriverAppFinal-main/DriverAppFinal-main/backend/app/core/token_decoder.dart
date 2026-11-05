import 'dart:convert';

class TokenDecoder {
  /// Descodifica a carga útil (payload) de um token JWT sem validar a assinatura
  static Map<String, dynamic>? decodeToken(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return null;

      final payload = _decodeBase64(parts[1]);
      final payloadMap = json.decode(payload);

      if (payloadMap is! Map<String, dynamic>) return null;
      return payloadMap;
    } catch (_) {
      return null;
    }
  }

  /// Verifica se o token JWT já expirou[cite: 13, 16]
  static bool isTokenExpired(String token) {
    final payload = decodeToken(token);
    if (payload == null || !payload.containsKey('exp')) return true;

    final exp = payload['exp'] as int;
    final expiryDate = DateTime.fromMillisecondsSinceEpoch(exp * 1000, isUtc: true);
    return DateTime.now().toUtc().isAfter(expiryDate);
  }

  /// Obtém o ID do utilizador (subject) a partir do token
  static String? getUserIdFromToken(String token) {
    final payload = decodeToken(token);
    if (payload == null) return null;
    return payload['sub']?.toString(); //[cite: 12, 15]
  }

  static String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');
    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Cadeia de caracteres Base64URL inválida!');
    }
    return utf8.decode(base64Url.decode(output));
  }
}