import 'api_client.dart';
import 'api_endpoints.dart';

class DashboardService {
  Future<Map<String, dynamic>> getDashboard({int? year}) async {
    return await ApiClient.get(ApiEndpoints.dashboard(year: year));
  }

  Future<List<int>> downloadRidesExcel() async {
    return await ApiClient.getBytes(ApiEndpoints.exportRidesExcel);
  }

  Future<List<int>> downloadExpensesExcel() async {
    return await ApiClient.getBytes(ApiEndpoints.exportExpensesExcel);
  }

  Future<List<int>> downloadRidesPdf() async {
    return await ApiClient.getBytes(ApiEndpoints.exportRidesPdf);
  }
}