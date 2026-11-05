import '../security/secure_storage.dart';
import '../security/token_decoder.dart';

class SessionManager {
  /// Verifica se o utilizador possui uma sessão ativa e válida no dispositivo[cite: 12, 15]
  static Future<bool> isAuthenticated() async {
    final token = await SecureStorageService.getAccessToken();
    if (token == null) return false;

    // Verifica se o token expirou[cite: 13, 16]
    if (TokenDecoder.isTokenExpired(token)) {
      return false;
    }

    return true;
  }

  /// Obtém o ID do utilizador autenticado[cite: 12, 15]
  static Future<String?> getCurrentUserId() async {
    final token = await SecureStorageService.getAccessToken();
    if (token == null) return null;
    return TokenDecoder.getUserIdFromToken(token); //[cite: 12, 15]
  }

  /// Termina a sessão do utilizador
  static Future<void> logout() async {
    await SecureStorageService.clearTokens();
  }
}