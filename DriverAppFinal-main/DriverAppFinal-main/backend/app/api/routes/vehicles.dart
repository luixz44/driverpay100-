import 'api_client.dart';
import 'api_endpoints.dart';

class VehicleService {
  Future<List<dynamic>> listVehicles() async {
    return await ApiClient.get(ApiEndpoints.vehicles);
  }

  Future<Map<String, dynamic>> createVehicle(Map<String, dynamic> data) async {
    return await ApiClient.post(ApiEndpoints.vehicles, data);
  }

  Future<Map<String, dynamic>> getVehicle(int id) async {
    return await ApiClient.get(ApiEndpoints.vehicleById(id));
  }

  Future<Map<String, dynamic>> updateVehicle(int id, Map<String, dynamic> data) async {
    return await ApiClient.put(ApiEndpoints.vehicleById(id), data);
  }

  Future<void> deleteVehicle(int id) async {
    await ApiClient.delete(ApiEndpoints.vehicleById(id));
  }
}