import '../api/api_client.dart';
import '../api/api_endpoints.dart';
import '../models/obd2_record_model.dart';

class OBD2Repository {
  Future<OBD2RecordModel> createRecord(Map<String, dynamic> recordData) async {
    final data = await ApiClient.post(ApiEndpoints.obd2Record, recordData);
    return OBD2RecordModel.fromJson(data);
  }

  Future<List<OBD2RecordModel>> getHistory(int vehicleId, {int limit = 100}) async {
    final List<dynamic> data = await ApiClient.get(ApiEndpoints.obd2History(vehicleId, limit: limit));
    return data.map((json) => OBD2RecordModel.fromJson(json)).toList();
  }
}