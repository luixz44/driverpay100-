import 'api_client.dart';
import 'api_endpoints.dart';

class AuthService {
  Future<Map<String, dynamic>> login(String email, String password) async {
    final data = await ApiClient.post(
      ApiEndpoints.login,
      {'email': email, 'password': password},
    );
    if (data != null && data['access_token'] != null) {
      ApiClient.setToken(data['access_token']);
    }
    return data;
  }

  Future<void> register(Map<String, dynamic> userData) async {
    await ApiClient.post(ApiEndpoints.register, userData);
  }

  Future<Map<String, dynamic>> refreshToken(String refreshToken) async {
    return await ApiClient.post(
      ApiEndpoints.refresh,
      {'refresh_token': refreshToken},
    );
  }

  Future<void> recoverPassword(String email) async {
    await ApiClient.post(ApiEndpoints.recover, {'email': email});
  }
}