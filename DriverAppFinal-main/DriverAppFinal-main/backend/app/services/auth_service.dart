import '../api/api_client.dart';
import '../api/api_endpoints.dart';
import '../core/security/secure_storage.dart';
import '../models/dtos.dart';

class AuthService {
  /// Registo de novo utilizador[cite: 26]
  Future<void> register(UserCreateDto data) async {
    await ApiClient.post(ApiEndpoints.register, data.toJson());
  }

  /// Autenticação e armazenamento dos tokens JWT no dispositivo[cite: 26]
  Future<TokenDto> login(LoginRequestDto data) async {
    final response = await ApiClient.post(ApiEndpoints.login, data.toJson());
    final tokenData = TokenDto.fromJson(response);

    // Guarda os tokens de forma segura no dispositivo Android[cite: 26]
    await SecureStorageService.saveAccessToken(tokenData.accessToken);
    await SecureStorageService.saveRefreshToken(tokenData.refreshToken);
    ApiClient.setToken(tokenData.accessToken);

    return tokenData;
  }

  /// Renovação do token de acesso expirado[cite: 26]
  Future<TokenDto> refreshToken() async {
    final refreshToken = await SecureStorageService.getRefreshToken();
    if (refreshToken == null) {
      throw Exception('Sem refresh token disponível');
    }

    final response = await ApiClient.post(
      ApiEndpoints.refresh,
      {'refresh_token': refreshToken},
    );
    final tokenData = TokenDto.fromJson(response);

    await SecureStorageService.saveAccessToken(tokenData.accessToken);
    await SecureStorageService.saveRefreshToken(tokenData.refreshToken);
    ApiClient.setToken(tokenData.accessToken);

    return tokenData;
  }

  /// Recuperação / Redefinição de palavra-passe[cite: 26]
  Future<void> resetPassword(String email) async {
    await ApiClient.post(ApiEndpoints.recover, {'email': email});
  }

  /// Terminar a sessão[cite: 26]
  Future<void> logout() async {
    await SecureStorageService.clearTokens();
    ApiClient.clearToken();
  }
}