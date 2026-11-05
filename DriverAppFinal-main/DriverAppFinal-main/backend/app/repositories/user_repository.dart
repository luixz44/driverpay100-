import '../api/api_client.dart';
import '../api/api_endpoints.dart';
import '../models/user_model.dart';

class UserRepository {
  Future<UserModel> getMe() async {
    final data = await ApiClient.get(ApiEndpoints.me);
    return UserModel.fromJson(data);
  }

  Future<UserModel> updateMe(Map<String, dynamic> userData) async {
    final data = await ApiClient.put(ApiEndpoints.me, userData);
    return UserModel.fromJson(data);
  }
}