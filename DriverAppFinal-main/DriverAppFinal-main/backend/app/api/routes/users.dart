import 'api_client.dart';
import 'api_endpoints.dart';

class UserService {
  Future<Map<String, dynamic>> getMe() async {
    return await ApiClient.get(ApiEndpoints.me);
  }

  Future<Map<String, dynamic>> updateMe(Map<String, dynamic> userData) async {
    return await ApiClient.put(ApiEndpoints.me, userData);
  }
}