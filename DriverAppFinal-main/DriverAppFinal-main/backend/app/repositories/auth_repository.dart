import '../api/api_client.dart';
import '../api/api_endpoints.dart';
import '../models/user_model.dart';

class AuthRepository {
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await ApiClient.post(
      ApiEndpoints.login,
      {'email': email, 'password': password},
    );
    return response;
  }

  Future<void> register(Map<String, dynamic> userData) async {
    await ApiClient.post(ApiEndpoints.register, userData);
  }

  Future<void> recoverPassword(String email) async {
    await ApiClient.post(ApiEndpoints.recover, {'email': email});
  }
}