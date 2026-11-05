import 'api_client.dart';
import 'api_endpoints.dart';

class OBD2Service {
  Future<Map<String, dynamic>> recordData(Map<String, dynamic> obdData) async {
    return await ApiClient.post(ApiEndpoints.obd2Record, obdData);
  }

  Future<List<dynamic>> getHistory(int vehicleId, {int limit = 100}) async {
    return await ApiClient.get(ApiEndpoints.obd2History(vehicleId, limit: limit));
  }

  Future<Map<String, dynamic>> getStatus() async {
    return await ApiClient.get(ApiEndpoints.obd2Status);
  }
}