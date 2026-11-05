import '../api/api_client.dart';
import '../api/api_endpoints.dart';
import '../models/dashboard_model.dart';

class DashboardService {
  /// Obtém os dados resumidos do painel para o ano especificado[cite: 27]
  Future<DashboardModel> getDashboard({int? year}) async {
    final response = await ApiClient.get(ApiEndpoints.dashboard(year: year));
    return DashboardModel.fromJson(response);
  }
}import '../api/api_client.dart';
import '../api/api_endpoints.dart';
import '../models/dashboard_model.dart';

class DashboardService {
  /// Obtém os dados resumidos do painel para o ano especificado[cite: 27]
  Future<DashboardModel> getDashboard({int? year}) async {
    final response = await ApiClient.get(ApiEndpoints.dashboard(year: year));
    return DashboardModel.fromJson(response);
  }
}