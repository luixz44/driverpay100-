import '../api/api_client.dart';
import '../api/api_endpoints.dart';
import '../models/vehicle_model.dart';

class VehicleRepository {
  Future<List<VehicleModel>> getAllByUser() async {
    final List<dynamic> data = await ApiClient.get(ApiEndpoints.vehicles);
    return data.map((json) => VehicleModel.fromJson(json)).toList();
  }

  Future<VehicleModel> getById(int id) async {
    final data = await ApiClient.get(ApiEndpoints.vehicleById(id));
    return VehicleModel.fromJson(data);
  }

  Future<VehicleModel> create(Map<String, dynamic> vehicleData) async {
    final data = await ApiClient.post(ApiEndpoints.vehicles, vehicleData);
    return VehicleModel.fromJson(data);
  }

  Future<VehicleModel> update(int id, Map<String, dynamic> vehicleData) async {
    final data = await ApiClient.put(ApiEndpoints.vehicleById(id), vehicleData);
    return VehicleModel.fromJson(data);
  }

  Future<void> delete(int id) async {
    await ApiClient.delete(ApiEndpoints.vehicleById(id));
  }
}