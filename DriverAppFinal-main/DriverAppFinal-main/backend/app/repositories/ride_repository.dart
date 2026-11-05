import '../api/api_client.dart';
import '../api/api_endpoints.dart';
import '../models/ride_model.dart';

class RideRepository {
  Future<List<RideModel>> getAllByVehicle(int vehicleId) async {
    final List<dynamic> data = await ApiClient.get(ApiEndpoints.ridesByVehicle(vehicleId));
    return data.map((json) => RideModel.fromJson(json)).toList();
  }

  Future<RideModel> getById(int rideId) async {
    final data = await ApiClient.get(ApiEndpoints.rideById(rideId));
    return RideModel.fromJson(data);
  }

  Future<RideModel> create(Map<String, dynamic> rideData) async {
    final data = await ApiClient.post(ApiEndpoints.rides, rideData);
    return RideModel.fromJson(data);
  }

  Future<RideModel> update(int id, Map<String, dynamic> rideData) async {
    final data = await ApiClient.put(ApiEndpoints.rideById(id), rideData);
    return RideModel.fromJson(data);
  }

  Future<void> delete(int id) async {
    await ApiClient.delete(ApiEndpoints.rideById(id));
  }
}