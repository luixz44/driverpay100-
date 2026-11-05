import 'api_client.dart';
import 'api_endpoints.dart';

class RideService {
  Future<List<dynamic>> listRidesByVehicle(int vehicleId) async {
    return await ApiClient.get(ApiEndpoints.ridesByVehicle(vehicleId));
  }

  Future<Map<String, dynamic>> createRide(Map<String, dynamic> data) async {
    return await ApiClient.post(ApiEndpoints.rides, data);
  }

  Future<Map<String, dynamic>> getRide(int id) async {
    return await ApiClient.get(ApiEndpoints.rideById(id));
  }

  Future<Map<String, dynamic>> updateRide(int id, Map<String, dynamic> data) async {
    return await ApiClient.put(ApiEndpoints.rideById(id), data);
  }

  Future<void> deleteRide(int id) async {
    await ApiClient.delete(ApiEndpoints.rideById(id));
  }
}